//
//  parseUser.swift
//  Parsetagram
//
//  Created by Ming Horn on 6/20/16.
//  Copyright © 2016 Ming Horn. All rights reserved.
//

import UIKit
import Parse

class parseUser: PFUser{
    dynamic var gender: Int = 2
    dynamic var profileImage: NSURL?
    dynamic var desc: String?
    
    override class func initialize() {
        self.registerSubclass()
    }
}

