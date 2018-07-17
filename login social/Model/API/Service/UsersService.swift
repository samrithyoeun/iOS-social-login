//
//  UsersService.swift
//  Project
//
//  Created by Ricky_DO on 3/19/18.
//  Copyright © 2018 Pathmazing. All rights reserved.
//

import UIKit
import SwiftyJSON

struct UsersService {
    
    static func getUsers(completion: @escaping(Result<UserEntity>) -> ()) {
        
        let headers = APIHeader.getAuthorizationApp()
        APIRequest.get(endPoint: "/getUserEntPoint", headers: headers) { (response: JSON, responseCode: Int?, error: Error?) in
            
            if let error = error {
                print(error)
                completion(Result.failure("get user list error"))
                return
            }
            
            let invite = self.parseUserResponse(response: response)
            completion(Result.success(invite))
        }
    }
    
    static private func parseUserResponse(response: JSON) -> UserEntity {
        
        var userEntity = UserEntity()
        userEntity.id = response["id"].intValue
        return userEntity
    }
}
