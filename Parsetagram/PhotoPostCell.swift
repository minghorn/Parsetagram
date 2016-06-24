//
//  PhotoPostCell.swift
//  Parsetagram
//
//  Created by Ming Horn on 6/21/16.
//  Copyright © 2016 Ming Horn. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class PhotoPostCell: UITableViewCell {

    @IBOutlet weak var caption: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var photoImage: PFImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var likeHeart: UIImageView!

    
    
    override func awakeFromNib() {
        let gesture = UITapGestureRecognizer(target: self, action:#selector(PhotoPostCell.onDoubleTap(_:)))
        gesture.numberOfTapsRequired = 2
        contentView.addGestureRecognizer(gesture)
        
        likeHeart?.hidden = true
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func onDoubleTap(sender:AnyObject) {
        likeHeart?.hidden = false
        likeHeart?.alpha = 1.0
        
        UIView.animateWithDuration(1.0, delay: 1.0, options: [], animations: {
            
            self.likeHeart?.alpha = 0
            
            }, completion: {
                (value:Bool) in
                
                self.likeHeart?.hidden = true
        })
    }

}
