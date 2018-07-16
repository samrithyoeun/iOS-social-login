//
//  Helper.swift
//  login social
//
//  Created by PM Academy 3 on 7/16/18.
//  Copyright © 2018 PM Academy 3. All rights reserved.
//

import Foundation
import UIKit

func log(_ string: String) {
    print(string)
}

func alert(message: String, title: String = "") {
    
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(OKAction)
    
    UIApplication.topViewController()?.present(alertController, animated: true, completion: nil)
}
