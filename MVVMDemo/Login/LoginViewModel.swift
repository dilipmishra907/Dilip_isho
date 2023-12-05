//
//  LoginViewModel.swift
//  MVVMDemo
//
//  Created by Ishi on 05/12/23.
//

import Foundation

enum ValidationState {
    case Valid
    case Invalid(String)
}

class LoginViewModel {
    
    var pushHome: (()->())?
    var showError: (()->())?
    var showValidationError: (()->())?

    var showLoading: (()->())?
    var hideLoading: (()->())?
    
    var username:String = ""
    var password:String = ""
    
    func validate() -> ValidationState {
        
        if username.isEmpty && password.isEmpty {
            self.showError?()
            return .Invalid("Please enter valid username and Password")
        }
//        if username.count < minUsernameLenth {
//            return .Invalid("username should be atleast \(minUsernameLenth) char long")
//        }
//        if password.count < minPasswordLenght {
//        return .Invalid("password should be atleast \(minPasswordLenght) char long")
//        }
        return .Valid
    }
    
    func loginApiCall(url : URL, param: [String: Any]){
        showLoading?()
        Webservice().loginApiCall(url: url, param: param, completionHandler: {success, data in
            self.hideLoading?()
            if(success){
                DispatchQueue.main.async {
                    self.pushHome?()
                }
            }
            else
            {
                self.showError?()
            }
        })
    }
}


