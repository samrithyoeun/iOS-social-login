//
//  AppDelegate.swift
//  login social
//
//  Created by PM Academy 3 on 7/16/18.
//  Copyright © 2018 PM Academy 3. All rights reserved.
//

import UIKit
import CoreData
import FBSDKLoginKit
import GoogleSignIn
import TwitterKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        //FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        //GIDSignIn.sharedInstance().clientID = "960121798906-pgp8oqnqbups1qp85rvsupl4di75p0u0.apps.googleusercontent.com"
        TWTRTwitter.sharedInstance().start(withConsumerKey: "DAPk0M1mLBO3OALmhbGHQTDtR", consumerSecret: "NugLAUQLCfGHLLgFbEAtUNvXQUaczIs1MmiGGRFjtDnGFgpk2Z")
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
       // _ = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
       // _ = GIDSignIn.sharedInstance().handle(url as URL?,
                                    //     sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                   //      annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        
        return TWTRTwitter.sharedInstance().application(app, open: url, options: options)
    }
    
}




