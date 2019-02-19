//
//  SignupViewController.swift
//  iGrant
//
//  Created by Ajeesh T S on 29/03/18.
//  Copyright © 2018 iGrant.com. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import IQKeyboardManagerSwift
import CountryPicker

class SignUpData: NSObject {
    var username: String!
    var fname: String!
    var lname: String!
    var title : String!
    var email : String!
    var pasword : String!
    var phone : String!
    
}

class SignupViewController: BaseViewController {
    @IBOutlet weak var usernameTextfld: UITextField!
    @IBOutlet weak var emailTextfld: UITextField!
    @IBOutlet weak var passwordTextfld: UITextField!
    @IBOutlet weak var confirmTextfld: UITextField!
    @IBOutlet weak var invalidEmailTextLbl: UILabel!
    @IBOutlet weak var invalidPhoneTextLbl: UILabel!
    
    @IBOutlet weak var submutBtn: UIButton!
    @IBOutlet weak var emailTxtContainer: UIView!
    @IBOutlet weak var passwordTxtContainer: UIView!
    @IBOutlet weak var nameTxtContainer: UIView!
    @IBOutlet weak var confirmPasswordTxtContainer: UIView!
    @IBOutlet weak var namevalidationImageView: UIImageView!
    @IBOutlet weak var emailValidationImageView: UIImageView!
    @IBOutlet weak var phoneValidationImageView: UIImageView!
    
    @IBOutlet var picker: CountryPicker!
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var countryCodeLbl: UILabel!
    @IBOutlet weak var phoneTextfld: UITextField!
    @IBOutlet weak var pikcerHideTouchView: UIView!
    
    //    @IBOutlet weak var emailValidationImageView: UIImageView!
    
    var signupUserInfo = SignUpData()
    var apiNumber = 0
    var apiNumberPhone = 0
    
    var isConfirmedUserName = false
    var isConfirmedEmail = false
    var isConfirmedPhoneNumber = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = Constant.AppSetupConstant.KAppName
        //        self.navigationController?.navigationBar.isHidden = false
        //        self.navigationController?.navigationBar.tintColor = UIColor.black
        submutBtn.showRoundCorner()
        uiSetup()
        setupKeyboard()
        //        UINavigationBar.appearance().titleTextAttributes = [
        //            NSAttributedStringKey.foregroundColor: UIColor.black,
        //            NSAttributedStringKey.font: UIFont(name: "OpenSans", size: 18)!
        //        ]
        //        self.navigationItem.title = "Phone number"
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    override func viewWillDisappear(_ animated: Bool) {
    //        super.viewWillDisappear(true)
    //        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    //    }
    
    func setupKeyboard(){
     //   IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        usernameTextfld.becomeFirstResponder()
        
        //        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "Log in"
        //        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
        //        emailTxtFld.addDoneOnKeyboardWithTarget(self, action: #selector(keyboardDoneBtnClicked))
        //        passwordTxtFld.addDoneOnKeyboardWithTarget(self, action: #selector(keyboardDoneBtnClicked))
        //        usernameTextfld.addDoneOnKeyboardWithTarget(self, action: #selector(keyboardDoneBtnClicked), titleText: "Next")
        // emailTextfld.addDoneOnKeyboardWithTarget(self, action: #selector(keyboardDoneBtnClicked), titleText: "Next")
        
        
    }
    
    @objc func keyboardDoneBtnClicked(){
        IQKeyboardManager.shared.resignFirstResponder()
        validateAndCallSignupApi()
        //        if validate() == true{
        //            callLoginService()
        //        }
    }
    
    
    func uiSetup(){
        
        let nav = self.navigationController?.navigationBar
        nav?.tintColor = UIColor.black
        nav?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        let backButton = UIButton(type: UIButton.ButtonType.custom)
        backButton.frame =  CGRect.init(x: 0, y: 0, width: 25, height: 40)
        backButton.setTitle("Cancel".localized(), for: .normal)
        backButton.setTitleColor(twitterThemeColour, for: .normal)
        backButton.titleLabel?.font =  UIFont(name: "OpenSans", size: 14)
        backButton.addTarget(self, action: #selector(LoginViewController.closeButtonclicked), for: UIControl.Event.touchUpInside)
        let backButtonBar = UIBarButtonItem(customView:backButton)
        self.navigationItem.leftBarButtonItem = backButtonBar
        
        let color = UIColor(red:0.4, green:0.47, blue:0.53, alpha:1)
        
        emailTextfld.attributedPlaceholder = NSAttributedString(string: emailTextfld.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : color])
        usernameTextfld.attributedPlaceholder = NSAttributedString(string: usernameTextfld.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : color])
        phoneTextfld.attributedPlaceholder = NSAttributedString(string: phoneTextfld.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : color])
        setupCounrtyPikcer()
        
    }
    
    func setupCounrtyPikcer(){
        let locale = Locale.current
        let code = (locale as NSLocale).object(forKey: NSLocale.Key.countryCode) as! String?
        
        //init Picker
        picker.displayOnlyCountriesWithCodes = ["SE","FI","PT","IN","US","MT","GB","CH","DK","NO","EE"] //display only
        //        picker.exeptCountriesWithCodes = ["RU"] //exept country
        let theme = CountryViewTheme(countryCodeTextColor: .black, countryNameTextColor: .black, rowBackgroundColor: .white, showFlagsBorder: true)        //optional for UIPickerView theme changes
        picker.theme = theme //optional for UIPickerView theme changes
        picker.countryPickerDelegate = self
        picker.showPhoneNumbers = true
        
        picker.setCountry(code!)
        flagImageView.layer.borderWidth = 0.5
        flagImageView.layer.borderColor = UIColor(red:0.9, green:0.92, blue:0.93, alpha:1).cgColor
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
    
    
    @IBAction func countrySelectionButtonClicked(){
        IQKeyboardManager.shared.resignFirstResponder()
        self.pikcerHideTouchView.isHidden = false
        self.picker.isHidden = false
    }
    
    @IBAction func hideCountrySelectionButtonClicked(){
        self.pikcerHideTouchView.isHidden = true
        self.picker.isHidden = true
    }
    
    func validateAndCallSignupApi(){
        guard let username = self.usernameTextfld.text, !username.isBlank else {
            self.showWarningAlert(message: Constant.Alert.KPromptMsgEnterUserName)
            return
        }
        
        if self.isConfirmedUserName == false{
            self.showWarningAlert(message: Constant.Alert.KPromptMsgEnterLastName)
            return
        }
        guard let email = self.emailTextfld.text, !email.isBlank else {
            self.showWarningAlert(message: Constant.Alert.KPromptMsgEnterEmail)
            return
        }
        //        guard let validEmail = self.emailTextfld.text, validEmail.isValidEmail else {
        //            self.showWarningAlert(message: Constant.Alert.KPromptMsgEnterValidEmail)
        //            return
        //        }
        if self.isConfirmedEmail == false{
            self.showWarningAlert(message: Constant.Alert.KPromptMsgEnterValidEmail)
            return
        }
        
        guard let phone = self.phoneTextfld.text, !phone.isBlank else {
            self.showWarningAlert(message: Constant.Alert.KPromptMsgEnterMobileNumber)
            return
        }
        
        //        if phone.count <= 13 && phone.count >= 4 {
        //            self.showWarningAlert(message: Constant.Alert.KPromptMsgEnterValidMobileNumber)
        //            return
        //        }
        
        if self.isConfirmedPhoneNumber == false{
            self.showWarningAlert(message: Constant.Alert.KPromptMsgEnterValidMobileNumber)
            return
        }
        
        //        guard let confirmpassword = self.confirmTextfld.text, !confirmpassword.isBlank else {
        //            self.showWarningAlert(message: Constant.Alert.KPromptMsgEnterPassword)
        //            return
        //        }
        //        if password != confirmpassword{
        //            self.showWarningAlert(message: Constant.Alert.KPromptMsgPasswordMismatch)
        //            return
        //        }
        //
        //        signupUserInfo.fname = fname
        //        signupUserInfo.lname = lname
        signupUserInfo.phone = phone
        signupUserInfo.username = username
        signupUserInfo.email = email
        callOtpGenarationApi()
        //        signupUserInfo.pasword = password
        
        //        let passwordVC = Constant.getStoryboard(vc: self.classForCoder).instantiateViewController(withIdentifier: "PasswordVC") as! PasswordViewController
        //        passwordVC.signupInfo = signupUserInfo
        
        
        
    }
    
    func callOtpGenarationApi(){
        //if self.isNetWorkAvailable{
            self.addLoadingIndicator()
            let serviceManager = LoginServiceManager()
            serviceManager.managerDelegate = self
            let phoneWithCoutryCode = (countryCodeLbl.text)! + (phoneTextfld.text)!
            serviceManager.genarateOtpNumber(userInfo: self.signupUserInfo, phone: phoneWithCoutryCode)
       // }
    }
    
    func showOtpView(){
        let otpVC = Constant.getStoryboard(vc: self.classForCoder).instantiateViewController(withIdentifier: "OTPSendingVC") as! OtpEnteringViewController
        otpVC.phoneNumber = (countryCodeLbl.text)! + (phoneTextfld.text)!
        otpVC.signupInfo = signupUserInfo
        self.navigationController?.pushViewController(otpVC, animated: true)
        
    }
    
    func callLoginService(){
//        if self.isNetWorkAvailable{
            let email : String = (self.emailTextfld.text)!
            let password : String = (self.passwordTextfld.text)!
            let serviceManager = LoginServiceManager()
            serviceManager.managerDelegate = self
            serviceManager.loginService(uname: email , pwd:password)
//        }
    }
    
    func showHomeSreen(){
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "OpenSans", size: 18)!
        ]
       // UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        let tabView = Constant.getStoryboard(vc: self.classForCoder).instantiateViewController(withIdentifier: "TabView") as! UITabBarController
        UIApplication.shared.keyWindow?.rootViewController = tabView
    }
    
    
}

extension SignupViewController:WebServiceTaskManagerProtocol{
    
    func didFinishTask(from manager:AnyObject, response:(data:RestResponse?,error:String?)){
        self.removeLoadingIndicator()
        if response.error != nil{
            if let serviceManager = manager as? LoginServiceManager{
                if serviceManager.serviceType == .GenarateOTP{
                    showOtpView()
                }
            }
            //            }else{
            self.showErrorAlert(message: response.error!)
        }else{
            //            showHomeSreen()
            if let serviceManager = manager as? LoginServiceManager{
                if serviceManager.serviceType == .SignUp{
                    self.callLoginService()
                }
                else if serviceManager.serviceType == .ValidEmail{
                    if serviceManager.apiSequenceNumber == self.apiNumber{
                        if response.data?.responseCode == 0{
                            self.invalidEmailTextLbl.isHidden = false
                            self.invalidEmailTextLbl.text = response.data?.message
                        }else{
                            self.showEmailValidationSucess()
                        }
                    }
                }
                else if serviceManager.serviceType == .ValidPhoneNumber{
                    if serviceManager.apiSequenceNumber == self.apiNumberPhone{
                        if response.data?.responseCode == 0{
                            self.invalidPhoneTextLbl.isHidden = false
                            self.invalidPhoneTextLbl.text = response.data?.message
                        }else{
                            self.showPhoneValidationSucess()
                        }
                    }
                }
                else if serviceManager.serviceType == .GenarateOTP{
                    self.showOtpView()
                }
                else{
                    self.removeLoadingIndicator()
                    showHomeSreen()
                }
            }
            
        }
    }
    
    func showEmailValidationSucess(){
        let email : String = (self.emailTextfld.text)!
        if email.isValidEmail == true{
            self.emailValidationImageView.isHidden = false
            self.isConfirmedEmail = true
        }
    }
    
    func showEmailValidationFail(){
        let email : String = (self.emailTextfld.text)!
        if email.isValidEmail == true{
            self.invalidEmailTextLbl.isHidden = false
        }
    }
    
    func resetEmailValidationUI(){
        self.invalidEmailTextLbl.isHidden = true
        self.emailValidationImageView.isHidden = true
        self.isConfirmedEmail = false
    }
    
    func showPhoneValidationSucess(){
        //        if email.isValidEmail == true{
        self.phoneValidationImageView.isHidden = false
        self.isConfirmedPhoneNumber = true
        //        }
    }
    
    func resetPhoneValidationUI(){
        self.isConfirmedPhoneNumber = false
        self.invalidPhoneTextLbl.isHidden = true
        self.phoneValidationImageView.isHidden = true
        //        Utilitymethods.setView(view: phoneValidationImageView, hidden: true)
        //        Utilitymethods.setView(view: invalidPhoneTextLbl, hidden: true)
    }
    
    
}


extension SignupViewController: UITextFieldDelegate,CountryPickerDelegate,UIPickerViewDelegate{
    
    func countryPhoneCodePicker(_ picker: CountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage) {
        self.flagImageView.image = flag
        self.countryCodeLbl.text = phoneCode
        //        picker.isHidden = true
        //        self.pikcerHideTouchView.isHidden = true
        
        //pick up anythink
        //        code.text = phoneCode
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
            let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            let tmptext : String = updatedText
            if (tmptext.isValidString){
                if textField.tag == 0{
                    let trimmedString = tmptext.trimmingCharacters(in: .whitespacesAndNewlines)
                    let wordCount = trimmedString.components(separatedBy: .whitespaces)
                    if wordCount.count > 1{
                        isConfirmedUserName = true
                        namevalidationImageView.isHidden = false
                    }else{
                        isConfirmedUserName = false
                        namevalidationImageView.isHidden = true
                    }
                }
                else if textField.tag == 1{
                    resetEmailValidationUI()
                    if tmptext.isValidEmail{
                        callEmailValidationApi(email: tmptext)
                    }else{
                        
                    }
                }
                else{
                    resetPhoneValidationUI()
                    if tmptext.count >= 5 && tmptext.count <= 13{
                        let phoneNumber = (countryCodeLbl.text)! + tmptext
                        callPhoneValidationApi(phoneNumber: phoneNumber)
                        //                        callPhoneValidationApi(phoneNumber: (countryCodeLbl.text)!)
                        
                    }else{
                        
                    }
                }
            }else{
                if textField.tag == 0 {
                    isConfirmedUserName = false
                    namevalidationImageView.isHidden = true
                }
                else if textField.tag == 1{
                    resetEmailValidationUI()
                }else{
                    resetPhoneValidationUI()
                }
            }
        }
        return true
    }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            if textField.tag == 0{
                emailTextfld.becomeFirstResponder()
            }
            else  if textField.tag == 1{
                textField.resignFirstResponder()
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
            //}
        }
        
        func callPhoneValidationApi(phoneNumber:String){
           // if self.isNetWorkAvailable{
                apiNumberPhone = apiNumberPhone + 1
                //            let email : String = (self.emailTextfld.text)!
                let serviceManager = LoginServiceManager()
                serviceManager.apiSequenceNumber = apiNumberPhone
                serviceManager.managerDelegate = self
                serviceManager.validatePhoneNumber(phone: phoneNumber)
           // }
        }
}
