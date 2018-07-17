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

class AuthenticationManager: NSObject {
    static let shared = AuthenticationManager()
    let fbLoginManager = FBSDKLoginManager()
    var googleDelegate: GoogleSignInDelegate?
    var onGoogleLoginSuccess: (()->Void)?
    override init() {
        super.init()
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
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
    
    func facebookLogOut(){
        fbLoginManager.logOut()
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
    
    func googleSignIn() {
        GIDSignIn.sharedInstance().signIn()
    }
    
    func googleSignOut() {
        GIDSignIn.sharedInstance().signOut()
    }

}

extension AuthenticationManager: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
            NotificationCenter.default.post(
                name: Notification.Name(rawValue: "ToggleAuthUINotification"), object: nil, userInfo: nil)
        } else {
            let userId = user.userID
            _ = user.authentication.idToken
            let fullName = user.profile.name
            let email = user.profile.email
            let picture = user.profile.imageURL(withDimension: 200)
            let user = UserEntity(id: userId ?? "" , name: fullName ?? "", email: email ?? "", picture: (picture?.absoluteString)!)
            googleDelegate?.googleSignInResponse(user: user)
            onGoogleLoginSuccess?()
        }
        
    }
    
}

extension AuthenticationManager: GIDSignInUIDelegate {
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
         googleDelegate?.googleSignInLaunch(viewController)
    }
    
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        googleDelegate?.googleSignInDismiss(viewController)
    }
}




