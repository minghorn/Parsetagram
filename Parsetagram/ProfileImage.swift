//
//  ProfileImage.swift
//  Parsetagram
//
//  Created by Ming Horn on 6/24/16.
//  Copyright © 2016 Ming Horn. All rights reserved.
//

import UIKit
import ParseUI
import Parse

class ProfileImage: NSObject {
    class func postProfileImage(image: UIImage){
        // Create Parse object PFObject
        let profile = PFObject(className: "ProfileImage")
        
        // Add relevant fields to the object
        profile["media"] = getPFFileFromImage(image) // PFFile column type
        
        
        // Save object (following function will save the object in Parse asynchronously)
        profile.saveInBackgroundWithBlock{ (success: Bool, error: NSError?) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        
    }
    /**
     Method to convert UIImage to PFFile
     
     - parameter image: Image that the user wants to upload to parse
     
     - returns: PFFile for the the data in the image
     */
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
}
