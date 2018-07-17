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
        AuthenticationManager.shared.googleDelegate = self
        GIDSignIn.sharedInstance().signOut()
        
    }
    
    @IBAction func twitterButtonTapped(_ sender: Any) {
        print("github button did tapped")
        
    }
    
    @IBAction func facebookButtonTapped(_ sender: Any) {
        
        AuthenticationManager.shared.facebookLogin(from: self) { (result) in
            switch result {
            case .success(let user):
                self.loginWithUser(user)
                
            case .failure(let error):
                log(error)
                
            }
        }
    }

    @IBAction func googleButtonTapped(_ sender: Any) {
        
        AuthenticationManager.shared.googleSignIn()
        AuthenticationManager.shared.onGoogleLoginSuccess = { () in
            
        }
    }
    
    @IBAction func githubButtonTapped(_ sender: Any) {
        print("github button tapped")
    }
    
    private func loginWithUser(_ user: UserEntity) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let userInfoVC = storyBoard.instantiateViewController(withIdentifier: "userInfoViewController") as! UserInformationViewController
        userInfoVC.user = user
        self.present(userInfoVC, animated: true, completion: nil)
    }
    
}

extension LoginViewController: GoogleSignInDelegate {
    func googleSignInResponse(user: UserEntity) {
        loginWithUser(user)
    }
    
    func googleSignInLaunch(_ viewController: UIViewController) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    func googleSignInDismiss(_ viewController: UIViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

