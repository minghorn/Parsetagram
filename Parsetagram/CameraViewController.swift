//
//  CameraViewController.swift
//  Parsetagram
//
//  Created by Ming Horn on 6/20/16.
//  Copyright © 2016 Ming Horn. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func makeImageThing(type: String) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        if type == "Camera" {
            vc.sourceType = UIImagePickerControllerSourceType.Camera
        } else if type == "PhotoLibrary" {
            vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }
        self.presentViewController(vc, animated: true, completion: nil)
    }
    

    func imagePickerController(picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        // Do something with the images (based on your use case)
        UIImageWriteToSavedPhotosAlbum(originalImage, nil, nil, nil)
        UIImageWriteToSavedPhotosAlbum(editedImage, nil, nil, nil)
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismissViewControllerAnimated(true, completion: nil)
    }

}
