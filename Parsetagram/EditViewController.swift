//
//  EditViewController.swift
//  Parsetagram
//
//  Created by Ming Horn on 6/20/16.
//  Copyright © 2016 Ming Horn. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import AFNetworking

class EditViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var genderRadio: UISegmentedControl!
    @IBOutlet weak var profileImage: UIImageView!
    let user = parseUser.currentUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameField.text = user?.username
    }

    @IBAction func didTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveChanges(sender: AnyObject) {
        user!.setObject(descriptionField.text!, forKey: "desc")
        user!.setObject(usernameField.text!, forKey: "username")
        user!.saveInBackground();
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func cancelChanges(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }


}
