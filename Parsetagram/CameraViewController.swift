//
//  CameraViewController.swift
//  Parsetagram
//
//  Created by Ming Horn on 6/20/16.
//  Copyright © 2016 Ming Horn. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var editedPhotoView: UIImageView!
    @IBOutlet weak var optionalEdits: UISegmentedControl!
    @IBOutlet weak var caption: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeImageThing(1)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func makeImageThing(type: Int) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        if type == 0 {
            vc.sourceType = UIImagePickerControllerSourceType.Camera
        } else if type == 1 {
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
        editedPhotoView.image = editedImage
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cameraClicked(sender: AnyObject) {
        makeImageThing(0)
    }
    @IBAction func libraryClicked(sender: AnyObject) {
        makeImageThing(1)
    }

    @IBAction func shareClicked(sender: AnyObject) {
        Post.postUserImage(editedPhotoView.image, withCaption: caption?.text)
        tabBarController?.selectedIndex = 0
    }

}
