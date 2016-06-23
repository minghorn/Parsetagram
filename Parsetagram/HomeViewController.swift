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
    
    var timer: NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: #selector(getPosts), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        timer!.invalidate()
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
        
        if(post["caption"] != nil) {
            cell.caption.text = post["caption"] as? String
        } else {
            cell.caption.text = ""
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
            } else {
                // handle error
                print(error?.localizedDescription)
            }
        }
        self.tableView.reloadData()

    }
    func refreshControlAction(refreshControl: UIRefreshControl) {
        getPosts()
        refreshControl.endRefreshing()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detailSegue" {
            let indexPath1 = self.tableView.indexPathForCell(sender as! UITableViewCell)
            let vc = segue.destinationViewController as? UINavigationController
            let detailVC = vc?.viewControllers.first as? DetailsViewController
            let post = posts![indexPath1!.item]
            detailVC!.post = post
        }
    }

    

}
