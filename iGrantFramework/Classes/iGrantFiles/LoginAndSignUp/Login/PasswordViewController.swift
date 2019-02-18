//
//  PasswordViewController.swift
//  iGrant
//
//  Created by Ajeesh T S on 03/07/18.
//  Copyright © 2018 iGrant.com. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Localize_Swift

class PasswordViewController: BaseViewController {
    @IBOutlet weak var passwordTxtContainer: UIView!
    @IBOutlet weak var passwordTxtFld: UITextField!
    @IBOutlet weak var revealBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var passwordHeaderLbl: UILabel!
    @IBOutlet var titleLblConstraint : NSLayoutConstraint!
    @IBOutlet weak var passwordValidationImageView: UIImageView!

    var isProfileFlow = false

    var signupInfo : SignUpData!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Constant.AppSetupConstant.KAppName
        uiSetup()
        setupKeyboard()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setupKeyboard(){
        nextBtn.showRoundCorner()
        passwordTxtFld.becomeFirstResponder()
//        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "Next"
//        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
        //        emailTxtFld.addDoneOnKeyboardWithTarget(self, action: #selector(keyboardDoneBtnClicked))
        //        passwordTxtFld.addDoneOnKeyboardWithTarget(self, action: #selector(keyboardDoneBtnClicked))
//        passwordTxtFld.addDoneOnKeyboardWithTarget(self, action: #selector(keyboardDoneBtnClicked), titleText: "Log in")
        
    }
    
    func uiSetup(){
        if isProfileFlow == true{
            self.navigationController?.isNavigationBarHidden = false
            titleLblConstraint.constant = 0
            self.title = "Change Password".localized()
            passwordHeaderLbl.isHidden = true
            nextBtn.setTitle("Save".lowercased(), for: .normal)
            passwordTxtFld.placeholder = "New password".localized()
        }else{
            self.navigationItem.setHidesBackButton(true, animated: false)
        }
        let color = UIColor(red:0.4, green:0.47, blue:0.53, alpha:1)
        passwordTxtFld.attributedPlaceholder = NSAttributedString(string: passwordTxtFld.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : color])

    }
    
    @objc func keyboardDoneBtnClicked(){
        IQKeyboardManager.shared.resignFirstResponder()
        validateAndCallService()
//        if validate() == true{
//            callLoginService()
//        }
    }
    
    @IBAction func nextButtonClicked(){
        IQKeyboardManager.shared.resignFirstResponder()
        validateAndCallService()
    }
    
    func validateAndCallService(){
        guard let password = self.passwordTxtFld.text, !password.isBlank else {
            if isProfileFlow == true{
                self.showWarningAlert(message: Constant.Alert.KPromptMsgEnterNewPassword)
            }else{
                self.showWarningAlert(message: Constant.Alert.KPromptMsgEnterPassword)
                
            }
            
            return
        }
        if password.count < 6{
            self.showWarningAlert(message: Constant.Alert.KPromptMsgEnterValidPassword)
            return
        }
      //  if self.isNetWorkAvailable{
            self.addLoadingIndicator()
            let serviceManager = LoginServiceManager()
            serviceManager.managerDelegate = self
            if isProfileFlow{
              //  serviceManager.changepassword(newpassword: password)
            }
            else{
                signupInfo.pasword = password
                serviceManager.signupService(userInfo: signupInfo)
            }
      //  }
    
    }
    
    @IBAction func revealButtonClicked(sender:UIButton){
        if sender.tag == 1{
            passwordTxtFld.isSecureTextEntry = false
            sender.tag = 0
            sender.setTitle("Hide password".localized(), for: .normal)
        }else{
            passwordTxtFld.isSecureTextEntry = true
            sender.tag = 1
            sender.setTitle("Show password".localized(), for: .normal)
        }
        let currentText: String = self.passwordTxtFld.text!
        self.passwordTxtFld.text = " "
        self.passwordTxtFld.text = currentText
    }
    
    
    func callLoginService(){
      //  if self.isNetWorkAvailable{
            let serviceManager = LoginServiceManager()
            serviceManager.managerDelegate = self
            serviceManager.loginService(uname: signupInfo.email , pwd:signupInfo.pasword)
       // }
    }
    
    func showHomeSreen(){
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "OpenSans", size: 18)!
        ]
        //UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        let tabView = Constant.getStoryboard().instantiateViewController(withIdentifier: "TabView") as! UITabBarController
        UIApplication.shared.keyWindow?.rootViewController = tabView
    }
    
}



extension PasswordViewController:WebServiceTaskManagerProtocol,UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 1{
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
            let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            let tmptext : String = updatedText
            if (tmptext.isValidString){
                revealBtn.isHidden = false
                if tmptext.count > 5{
                    passwordValidationImageView.isHidden = false
                }else{
                    passwordValidationImageView.isHidden = true
                }
            }else{
                passwordValidationImageView.isHidden = true
            }
        }
        return true
    }

    func didFinishTask(from manager:AnyObject, response:(data:RestResponse?,error:String?)){
        if response.error != nil{
            self.removeLoadingIndicator()
            self.showErrorAlert(message: response.error!)
        }else{
            if let serviceManager = manager as? LoginServiceManager{
                if serviceManager.serviceType == .SignUp{
                    self.callLoginService()
                }
                else if serviceManager.serviceType == .ChangePassword{
                  // self.showfloatingAlert(description: "Password has been updated successfully".localized())
                    self.navigationController?.popViewController(animated: true)
                }
                else{
                    self.removeLoadingIndicator()
                  //  showProfileEditViewController()
                }
            }
            
        }
    }
    
}
