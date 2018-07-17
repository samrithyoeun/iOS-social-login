//
//  File.swift
//  login social
//
//  Created by PM Academy 3 on 7/16/18.
//  Copyright © 2018 PM Academy 3. All rights reserved.
//

import Foundation

struct Instagram {
    static let authenURL = "https://api.instagram.com/oauth/authorize/"
    static let apiURL = "https://api.instagram.com/v1/users/"
    static let clientId = "76cab302605e42b7aa488ee1d4480f01"
    static let clientSecret = "0e3875de28484c7cb6af054ac87f2ba5"
    static let redirectURL = "https://www.facebook.com/samrith.yoeun"
    static let accessToken = "access_Token"
    static let scope = "likes-comments-relationships"
}

struct GitHub {
    static let clientId = "809d0206b4c7616d363a"
    static let clientSecret = "904ba5c0e0a2721f0546ae2e54fc730b9cdf4011"
}
