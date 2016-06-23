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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
