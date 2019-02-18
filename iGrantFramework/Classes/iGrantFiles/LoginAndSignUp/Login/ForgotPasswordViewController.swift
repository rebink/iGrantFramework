

//
//  ForgotPasswordViewController.swift
//  iGrant
//
//  Created by Ajeesh T S on 01/08/18.
//  Copyright © 2018 iGrant.com. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class ForgotPasswordViewController: BaseViewController {
    @IBOutlet weak var emailTextfld: UITextField!
    @IBOutlet weak var emailValidationImageView: UIImageView!
    @IBOutlet weak var submutBtn: UIButton!
    var apiNumber = 0
    var isConfirmedEmail = false
    @IBOutlet weak var invalidEmailTextLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        uiSetup()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func uiSetup(){
        self.title = Constant.AppSetupConstant.KAppName
        let nav = self.navigationController?.navigationBar
        nav?.tintColor = UIColor.black
        nav?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        let backButton = UIButton(type: UIButton.ButtonType.custom)
        backButton.frame =  CGRect.init(x: 0, y: 0, width: 25, height: 40)
        backButton.setTitle("Cancel".localized(), for: .normal)
        backButton.titleLabel?.font =  UIFont(name: "OpenSans", size: 14)
        backButton.setTitleColor(twitterThemeColour, for: .normal)
        backButton.addTarget(self, action: #selector(LoginViewController.closeButtonclicked), for: UIControl.Event.touchUpInside)
        let backButtonBar = UIBarButtonItem(customView:backButton)
        self.navigationItem.leftBarButtonItem = backButtonBar
        let color = UIColor(red:0.4, green:0.47, blue:0.53, alpha:1)
        emailTextfld.attributedPlaceholder = NSAttributedString(string: emailTextfld.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : color])
        submutBtn.showRoundCorner()
        
    }
    
    @objc func closeButtonclicked(){
        IQKeyboardManager.shared.resignFirstResponder()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.dismiss(animated: true, completion: nil)
        })
    }
    
    @IBAction func submitButtonClicked(){
        IQKeyboardManager.shared.resignFirstResponder()
        validateAndCallSignupApi()
    }

    func validateAndCallSignupApi(){
        guard let email = self.emailTextfld.text, !email.isBlank else {
            self.showWarningAlert(message: Constant.Alert.KPromptMsgEnterEmail)
            return
        }
        if self.isConfirmedEmail == false{
            self.showWarningAlert(message: Constant.Alert.KPromptMsgEnterValidEmail)
            return
        }
        callForgotPasswordApi(email: email)
    }
   
}

extension ForgotPasswordViewController:WebServiceTaskManagerProtocol{
    
    func didFinishTask(from manager:AnyObject, response:(data:RestResponse?,error:String?)){
        if response.error != nil{
            self.removeLoadingIndicator()
            if let serviceManager = manager as? LoginServiceManager{
                if serviceManager.serviceType == .ValidEmail{
                    if serviceManager.apiSequenceNumber == self.apiNumber{
                        self.showEmailValidationFail()
                    }
                }
            }
            self.showErrorAlert(message: response.error!)
        }else{
            //            showHomeSreen()
            if let serviceManager = manager as? LoginServiceManager{
                if serviceManager.serviceType == .ForgotPwd{
                    self.removeLoadingIndicator()
                    if response.data?.message != nil{
                       // self.showfloatingAlert(description: (response.data?.message)!)
                        self.dismiss(animated: true, completion: nil)
                    }
//                    self.callLoginService()
                }
                else if serviceManager.serviceType == .ValidEmail{
                    if serviceManager.apiSequenceNumber == self.apiNumber{
                        if response.data?.responseCode == 0{
                            self.showEmailValidationSucess()
                        }else{
                            self.isConfirmedEmail = false
                            self.invalidEmailTextLbl.isHidden = false
                            self.invalidEmailTextLbl.text = response.data?.message
                        }
                    }
                }
                else{
                    self.removeLoadingIndicator()
                }
            }
            
        }
    }
    
    func showEmailValidationSucess(){
//        let email : String = (self.emailTextfld.text)!
//        if email.isValidEmail == true{
            self.emailValidationImageView.isHidden = false
            self.isConfirmedEmail = true
//        }
    }
    
    func showEmailValidationFail(){
        self.isConfirmedEmail = false
        self.emailValidationImageView.isHidden = true
        let email : String = (self.emailTextfld.text)!
        if email.isValidEmail == true{
            self.invalidEmailTextLbl.isHidden = false
        }
    }
    
    func resetEmailValidationUI(){
        self.invalidEmailTextLbl.isHidden = true
        self.emailValidationImageView.isHidden = true
    }
    
    
}

extension ForgotPasswordViewController: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
            let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            let tmptext : String = updatedText
            if (tmptext.isValidString){
                    resetEmailValidationUI()
                if tmptext.isValidEmail{
                    callEmailValidationApi(email: tmptext)
                }
            }else{
                resetEmailValidationUI()
            }
        }
        return true
    }
    
    func callEmailValidationApi(email:String){
       // if self.isNetWorkAvailable{
            apiNumber = apiNumber + 1
            //            let email : String = (self.emailTextfld.text)!
            let serviceManager = LoginServiceManager()
            serviceManager.apiSequenceNumber = apiNumber
            serviceManager.managerDelegate = self
            serviceManager.validateEmail(email: email)
       // }
    }
    
    func callForgotPasswordApi(email:String){
       // if self.isNetWorkAvailable{
            self.addLoadingIndicator()
            //            let email : String = (self.emailTextfld.text)!
            let serviceManager = LoginServiceManager()
            serviceManager.managerDelegate = self
            serviceManager.forgotPassword(email: email)
       // }
    }
}
