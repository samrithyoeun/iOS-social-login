//
//  ViewController.swift
//  login social
//
//  Created by PM Academy 3 on 7/16/18.
//  Copyright © 2018 PM Academy 3. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn
import TwitterKit

class LoginViewController: UIViewController {
    
    var user = UserEntity()
    var isComplete = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (identifier == "facebookLogIn") {
            return isComplete
        }
        return true
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let userInfoVC = segue.destination as? UserInformationViewController {
            userInfoVC.user = self.user
        }
    }

    @IBAction func twitterButtonTapped(_ sender: Any) {
//        TWTRTwitter.sharedInstance().logIn(completion: { (session, error) in
//            if (session != nil) {
//                print("signed in as \(String(describing: session?.userName))");
//            } else {
//                print("error: \(String(describing: error?.localizedDescription))");
//            }
//        })
        GIDSignIn.sharedInstance().signOut()
    }
    
    @IBAction func facebookButtonTapped(_ sender: Any) {
        
        AuthenticationManager.shared.facebookLogin(from: self) { (result) in
            switch result {
            case .failure(let error):
                log(error)
                
            case .success(let result):
                self.user = result
                print("Data : \(self.user) ")
                self.isComplete = true
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "facebookLogIn", sender: self)
                }
            }
        }
    }

    @IBAction func googleButtonTapped(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
        print("self is complete \(isComplete)")
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "processLogIn", sender: self)
        }
    }
    
}

extension LoginViewController: GIDSignInUIDelegate {
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
            self.user = UserEntity(id: userId ?? "" , name: fullName ?? "", email: email ?? "", picture: (picture?.absoluteString)!)
            print(self.user)
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: "ToggleAuthUINotification"),
            object: nil,
            userInfo: ["statusText": "User has disconnected."])
    }
}

extension LoginViewController: GIDSignInDelegate{
    
}


