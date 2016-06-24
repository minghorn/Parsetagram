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

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var posts: [PFObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
         getPosts()
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        getPosts()
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
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .MediumStyle
        dateFormatter.timeStyle = .NoStyle
        
        cell.dateLabel.text = dateFormatter.stringFromDate(post.createdAt!)
        
        if(post["caption"] != nil) {
            cell.caption.text = post["caption"] as? String
        } else {
            cell.caption.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        }
        return cell
    }
    
    func getPosts() {
        //Query all the PFObjects and put them into the post array
        let query = PFQuery(className: "Post")
        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackgroundWithBlock { (newPosts: [PFObject]?, error: NSError?) -> Void in
            if let newPosts = newPosts {
                // do something with the data fetched
                self.posts = newPosts
                self.tableView.reloadData()
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
