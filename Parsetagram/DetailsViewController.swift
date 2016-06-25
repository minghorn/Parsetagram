//
//  DetailsViewController.swift
//  Parsetagram
//
//  Created by Ming Horn on 6/22/16.
//  Copyright © 2016 Ming Horn. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class DetailsViewController: UIViewController {

    @IBOutlet weak var profImage: PFImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var postImage: PFImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var likeHeart: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!

    
    var post: PFObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userLabel.text = post?["author"].username
        //dateLabel.text = post?["createdAt"]
        postImage.file = post?["media"] as? PFFile
        // Do any additional setup after loading the view.
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .MediumStyle
        dateFormatter.timeStyle = .NoStyle
        
        dateLabel.text = dateFormatter.stringFromDate(post!.createdAt!)
        
        if(post!["caption"] != nil) {
            captionLabel.text = post!["caption"] as? String
        } else {
            captionLabel.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        }
        
        let gesture = UITapGestureRecognizer(target: self, action:#selector(PhotoPostCell.onDoubleTap(_:)))
        gesture.numberOfTapsRequired = 2
        view.addGestureRecognizer(gesture)
        
        likeHeart?.hidden = true
        likesLabel.text = "\(String(post!["likesCount"])) likes"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func onDoubleTap(sender:AnyObject) {
        if(post != nil) {
            if var likes:Int? = post!.objectForKey("likesCount") as? Int {
                likes! += 1
                
                post!.setObject(likes!, forKey: "likesCount");
                post!.saveInBackground();
                
                likesLabel?.text = "\(likes!) likes";
            }
        }
        
        likeHeart?.hidden = false
        likeHeart?.alpha = 1.0
        
        UIView.animateWithDuration(1.0, delay: 1.0, options: [], animations: {
            
            self.likeHeart?.alpha = 0
            
            }, completion: {
                (value:Bool) in
                
                self.likeHeart?.hidden = true
        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
