//
//  AuthenticationManager.swift
//  login social
//
//  Created by PM Academy 3 on 7/16/18.
//  Copyright © 2018 PM Academy 3. All rights reserved.
//

import Foundation
import FBSDKLoginKit
import FBSDKCoreKit
import GoogleSignIn
import SwiftyJSON

class AuthenticationManager {
    static let shared = AuthenticationManager()
    let fbLoginManager = FBSDKLoginManager()
    
    func facebookLogin (from uiViewController: UIViewController, completion: @escaping (Result<UserEntity>) -> () ) {
        fbLoginManager.logIn(withReadPermissions: ["email"], from: uiViewController) { (result, error) -> Void in
            if (error == nil) {
                if (result?.isCancelled)! {
                    log("athentication: user cancelled Facebook log in ")
                    return
                } else {
                    FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "email, name, picture.type(large)"]).start(completionHandler: { (connection, result, error) -> Void in
                        if (error == nil){
                            let user = self.mapData(result)
                            completion(Result.success(user))
                        } else {
                            completion(Result.failure("authenticaton: cannot get the user data from Facebook"))
                        }
                    })
                }
            }
        }
    }

    func mapData(_ value: Any?) -> UserEntity {
        let json = JSON(value ?? "")
        let id = json["id"].stringValue
        let name = json["name"].stringValue
        let email = json["email"].stringValue
        let picture = json["picture"]["data"]["url"].stringValue
        let user  = UserEntity(id: id, name: name, email: email, picture: picture)
        return user
    }
}



