//
//  SignInViewController.swift
//  login social
//
//  Created by Samrith Yoeun on 7/17/18.
//  Copyright © 2018 PM Academy 3. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("signInViewController")
        if let webview = view as? UIWebView {
            webview.delegate = self
            let urlString = "https://github.com/login/oauth/authorize?client_id=\(GitHub.clientSecret)"
            if let url = NSURL(string: urlString) {
                let req = NSURLRequest(url: url as URL)
                webview.loadRequest(req as URLRequest)
            }
        }
    }
}

extension SignInViewController: UIWebViewDelegate {
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if let url = request.url, url.host == "example.com" {
            if let code = url.query?.components(separatedBy: "code=").last {
                let urlString = "https://github.com/login/oauth/access_token"
                if let tokenUrl = NSURL(string: urlString) {
                    let req = NSMutableURLRequest(url: tokenUrl as URL)
                    req.httpMethod = "POST"
                    req.addValue("application/json", forHTTPHeaderField: "Content-Type")
                    req.addValue("application/json", forHTTPHeaderField: "Accept")
                    let params = [
                        "client_id" : GitHub.clientId,
                        "client_secret" : GitHub.clientSecret,
                        "code" : code
                    ]
                    req.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
                    let task = URLSession.shared.dataTask(with: req as URLRequest) { data, response, error in
                        if let data = data {
                            do {
                                if let content = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] {
                                    if let accessToken = content["access_token"] as? String {
                                        self.getUser(accessToken: accessToken)
                                    }
                                }
                            } catch {}
                        }
                    }
                    task.resume()
                }
            }
            return false
        }
        return true
    }
    
    func getUser(accessToken: String) {
        let urlString = "https://api.github.com/user"
        if let url = NSURL(string: urlString) {
            let req = NSMutableURLRequest(url: url as URL)
            req.addValue("application/json", forHTTPHeaderField: "Accept")
            req.addValue("token \(accessToken)", forHTTPHeaderField: "Authorization")
            let task = URLSession.shared.dataTask(with: req as URLRequest) { data, response, error in
                if let data = data {
                    if let content = String(data: data, encoding: String.Encoding.utf8) {
                        DispatchQueue.main.async() {
                            print(content)
                            self.presentingViewController?.dismiss(animated: true, completion: nil)
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
