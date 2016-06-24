//
//  EditViewController.swift
//  Parsetagram
//
//  Created by Ming Horn on 6/20/16.
//  Copyright © 2016 Ming Horn. All rights reserved.
//

import UIKit
import Parse

class EditViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var genderRadio: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = parseUser.currentUser()
        usernameField.text = user?.username
        let desc = user?.desc
        let gen = user?.gender
        if(desc != nil) {
            descriptionField.text = desc
        }
        if(gen != 2) {
            if(gen == 0) {
                genderRadio.selectedSegmentIndex = 0
            } else {
                genderRadio.selectedSegmentIndex = 1
            }
        }
        // Do any additional setup after loading the view.
    }

    @IBAction func didTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveChanges(sender: AnyObject) {
        parseUser.currentUser()?.username = usernameField.text
        parseUser.currentUser()?.desc = descriptionField.text
        parseUser.currentUser()?.gender = genderRadio.selectedSegmentIndex
    }

    @IBAction func cancelChanges(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }


}
