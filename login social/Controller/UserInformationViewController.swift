//
//  UserInformationViewController.swift
//  login social
//
//  Created by PM Academy 3 on 7/16/18.
//  Copyright © 2018 PM Academy 3. All rights reserved.
//

import UIKit

class UserInformationViewController: UIViewController {
   
    @IBOutlet weak var informationLabel: UILabel!
    
    var user = UserEntity()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("receving data : \(user)")
        informationLabel.text = "You logged in with: \nName: \(user.name)\nEmail: \(user.email)\nId: \(user.id) "

    }
    
}
