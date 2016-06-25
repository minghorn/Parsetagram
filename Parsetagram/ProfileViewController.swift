//
//  ProfileViewController.swift
//  Parsetagram
//
//  Created by Ming Horn on 6/20/16.
//  Copyright © 2016 Ming Horn. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ProfileViewController: UIViewController, UICollectionViewDataSource {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var likedButton: UIButton!
    @IBOutlet weak var postsButton: UIButton!
    @IBOutlet weak var likesButton: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    var posts: [PFObject]?
    let user = parseUser.currentUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        
        usernameLabel.text = user?.username
        getPosts()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(animated: Bool) {
        getPosts()
        descLabel.text = user?.desc
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(posts != nil) {
            return (posts?.count)!
        }
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("photoGridCell", forIndexPath: indexPath) as! PhotoCollectionCell
        let post = posts![indexPath.row]
        cell.postImage.file = post["media"] as? PFFile
        return cell
    }
    
    func getPosts() {
        let user = parseUser.currentUser()
        
        //Query all the PFObjects and put them into the post array
        let query = PFQuery(className: "Post")
        query.includeKey("author")
        query.whereKey("author", equalTo: user!)
        query.orderByDescending("createdAt")
        
        // fetch data asynchronously
        query.findObjectsInBackgroundWithBlock { (newPosts: [PFObject]?, error: NSError?) -> Void in
            if let newPosts = newPosts {
                // do something with the data fetched
                self.posts = newPosts
                self.collectionView.reloadData()
            } else {
                // handle error
                print(error?.localizedDescription)
            }
        }
    }
    
    @IBAction func logOut(sender: AnyObject) {
        PFUser.logOutInBackgroundWithBlock { (error: NSError?) in
            if error != nil {
                print("Could not log out")
            } else {
                self.performSegueWithIdentifier("logoutSegue", sender: self)
            }
        }
    }

    

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detailSegue" {
            let indexPath1 = self.collectionView.indexPathForCell(sender as! UICollectionViewCell)
            let vc = segue.destinationViewController as? UINavigationController
            let detailVC = vc?.viewControllers.first as? DetailsViewController
            let post = posts![indexPath1!.item]
            detailVC!.post = post
        }
    }


}
