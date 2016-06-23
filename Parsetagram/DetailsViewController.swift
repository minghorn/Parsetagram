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

    @IBOutlet weak var profImage: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var postImage: PFImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    var post: PFObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userLabel.text = post?["author"].username
        dateLabel.text = post?["createdAt"] as? String
        postImage.file = post?["media"] as? PFFile
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
