//
//  Login.swift
//  MVVMDemo
//
//  Created by Ishi on 03/12/23.
//

import Foundation

class Login {
    var accessToken : String
    var email : String

    init(accessToken: String, email: String) {
        self.accessToken = accessToken
        self.email = email
    }
    
    init?(dictionary :JSONDictionary) {
        
        guard let title = dictionary["accessToken"] as? String,
              let description = dictionary["email"] as? String else {
            return nil
        }
        self.accessToken = title
        self.email = description
    }

}
