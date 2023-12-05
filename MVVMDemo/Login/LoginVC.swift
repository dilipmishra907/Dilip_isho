//
//  LoginVC.swift
//  MVVMDemo
//
//  Created by Ishi on 03/12/23.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var activityMonitor: UIActivityIndicatorView!
    @IBOutlet weak var tftPassword: UITextField!
    @IBOutlet weak var tftEmail: UITextField!
    var dataViewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLoginViewModel()
        self.activityMonitor.isHidden = true

        
    }
   
    func initLoginViewModel(){
       
        dataViewModel.showError = {
            DispatchQueue.main.async { self.showAlert("Please enter valid username and Password.") }
        }
                
        dataViewModel.hideLoading = {
            DispatchQueue.main.async { self.activityMonitor.stopAnimating()
                self.activityMonitor.isHidden = true
            }
        }
        dataViewModel.showLoading = {
            self.activityMonitor.isHidden = false
            DispatchQueue.main.async { self.activityMonitor.startAnimating() }
        }
        dataViewModel.pushHome = {
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let nextScene = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                self.navigationController?.pushViewController(nextScene, animated: true)
            }
        }
    }
    
    @IBAction func loginBtnAction(_ sender: Any) {
    
        dataViewModel.username = tftEmail.text!
        dataViewModel.password = tftPassword.text!
        
        switch self.dataViewModel.validate() {
        case .Valid:
            
            tftEmail.text = "mkdemo@gmail.com"
            tftPassword.text = "123456789"
            tftEmail.resignFirstResponder()
            tftPassword.resignFirstResponder()

            let param : [String :Any] = ["username" : tftEmail.text ?? "","password" : tftPassword.text ?? ""]
            let url = URL(string: "https://bidinnhotelcp.com/hmapp/api/auth/signin")
            dataViewModel.loginApiCall(url: url!, param: param)
            break

        case .Invalid(let errmessage):
            print("Error",errmessage)
            dataViewModel.showError = {
                DispatchQueue.main.async {
                    self.showAlert(errmessage)
                }
            }
            break
        }
    }
}
