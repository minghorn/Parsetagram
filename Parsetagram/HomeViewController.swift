//
//  HomeViewController.swift
//  Parsetagram
//
//  Created by Ming Horn on 6/20/16.
//  Copyright © 2016 Ming Horn. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import SVPullToRefresh
import MBProgressHUD

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var posts: [PFObject]?
    var skip = 20
    var shareDidHappen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
         getPosts()
        
        tableView.addInfiniteScrollingWithActionHandler({() -> Void in
            self.getPosts()
            self.tableView.infiniteScrollingView.stopAnimating()
        })
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 565
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        if(!shareDidHappen) {
            getPosts()
        } else {
            MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            getPosts()
            shareDidHappen = false
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(posts != nil) {
            return posts!.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("postCell") as! PhotoPostCell
        let post = posts![indexPath.row]
        cell.photoImage.file = post["media"] as? PFFile
        cell.photoImage.loadInBackground()
        cell.usernameLabel.text = post["author"].username
        cell.likesLabel.text = "\(String(post["likesCount"])) likes"
        cell.parseObject = post
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .MediumStyle
        dateFormatter.timeStyle = .NoStyle
        
        cell.dateLabel.text = dateFormatter.stringFromDate(post.createdAt!)
        
        if(post["caption"] != nil) {
            cell.caption.text = post["caption"] as? String
        } else {
            cell.caption.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        }
        if(post["author"].valueForKey("profileImage") != nil) {
            let profile = post["author"].valueForKey("profileImage") as? PFFile
            cell.profileImage.file = profile! as PFFile
            print("there is a file")
        } else {
            print("no profile image")
        }
        return cell
    }
    
    func getPosts() {
        //Query all the PFObjects and put them into the post array
        let query = PFQuery(className: "Post")
        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.limit = skip
        
        // fetch data asynchronously
        query.findObjectsInBackgroundWithBlock { (newPosts: [PFObject]?, error: NSError?) -> Void in
            if let newPosts = newPosts {
                // do something with the data fetched
                if(self.posts == nil) {
                    self.posts = newPosts
                } else {
                    self.posts?.appendContentsOf(newPosts)
                }
                self.skip += 20
                self.tableView.reloadData()
                MBProgressHUD.hideHUDForView(self.view, animated: true)
            } else {
                // handle error
                print(error?.localizedDescription)
            }
        }

    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        getPosts()
        refreshControl.endRefreshing()
    }
}
