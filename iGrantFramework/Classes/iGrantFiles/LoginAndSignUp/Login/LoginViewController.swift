//
//  LoginViewController.swift
//  iGrant
//
//  Created by Ajeesh T S on 07/02/18.
//  Copyright © 2018 iGrant.com. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import UserNotifications
//import Firebase
//import FirebaseInstanceID
//import FirebaseMessaging


let twitterThemeColour = UIColor(red:0, green:0.62, blue:0.95, alpha:1)
class LoginViewController: BaseViewController {

    @IBOutlet weak var emailTxtContainer: UIView!
    @IBOutlet weak var passwordTxtContainer: UIView!
    @IBOutlet weak var emailTxtFld: UITextField!
    @IBOutlet weak var passwordTxtFld: UITextField!

    @IBOutlet weak var signinBtn: UIButton!
    @IBOutlet weak var signinMobileBtn: UIButton!
    @IBOutlet weak var revealBtn: UIButton!
    
    @IBOutlet weak var emailValidationImageView: UIImageView!
    @IBOutlet weak var passwordValidationImageView: UIImageView!
    @IBOutlet weak var invalidEmailTextLbl: UILabel!
    @IBOutlet var loginButtonYPostnConstraint : NSLayoutConstraint!

    var isConfirmedEmail = false
    var orgId: String?
    //var userInfo: OpenIdClaim?
    var apiNumber = 0


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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar on the this view controller
        //UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        IQKeyboardManager.shared.enableAutoToolbar = false

//        self.navigationController?.setNavigationBarHidden(true, animated: animated)
//            UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        //        IQKeyboardManager.shared.enableAutoToolbar = false
//        IQKeyboardManager.shared.enableAutoToolbar = false
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        IQKeyboardManager.shared.enableAutoToolbar = true
        //        IQKeyboardManager.shared.enableAutoToolbar = true
    }
    
    func setupKeyboard(){
        emailTxtFld.becomeFirstResponder()
//        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "Log in"
//        emailTxtFld.keyboardToolbar.addDoneOnKeyboardWithTarget(self, action: #selector(keyboardDoneBtnClicked), titleText: "Log in")
//        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
        IQKeyboardManager.shared.enableAutoToolbar = false

        
//        emailTxtFld.addDoneOnKeyboardWithTarget(self, action: #selector(keyboardDoneBtnClicked))
//        passwordTxtFld.addDoneOnKeyboardWithTarget(self, action: #selector(keyboardDoneBtnClicked))
//        emailTxtFld.addDoneOnKeyboardWithTarget(self, action: #selector(keyboardDoneBtnClicked), titleText: "Log in")
//        passwordTxtFld.addDoneOnKeyboardWithTarget(self, action: #selector(keyboardDoneBtnClicked), titleText: "Log in")
//
//        let v = emailTxtFld.inputAccessoryView as? IQToolbar
//        v?.doneBarButton.tintColor = UIColor.blue
//        v?.doneBarButton.isEnabled = false

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        IQKeyboardManager.shared.enableAutoToolbar = true
    }
    
    
    func uiSetup(){
        signinBtn.showRoundCorner()
        let nav = self.navigationController?.navigationBar
        //        nav?.barStyle = UIBarStyle.black
        //        nav?.tintColor = UIColor.white
        nav?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        let backButton = UIButton(type: UIButton.ButtonType.custom)
        backButton.frame =  CGRect.init(x: 0, y: 0, width: 25, height: 40)
//        backButton.setImage(UIImage.init(named: "closeBtn"), for: .normal)
        backButton.setTitle("Cancel".localized(), for: .normal)
        backButton.titleLabel?.font =  UIFont(name: "OpenSans", size: 14)
        backButton.setTitleColor(twitterThemeColour, for: .normal)
        backButton.addTarget(self, action: #selector(LoginViewController.closeButtonclicked), for: UIControl.Event.touchUpInside)
        let backButtonBar = UIBarButtonItem(customView:backButton)
        self.navigationItem.leftBarButtonItem = backButtonBar

        if Constant.DeviceType.IS_IPHONE_5s == true{
            loginButtonYPostnConstraint.constant = 60
        }
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "test", style: .done, target: self, action: #selector(closeButtonclicked))


//        emailTxtContainer.showRoundCorner(roundCorner: 5.0)
//        emailTxtContainer.borderWidth = 1.0
//        emailTxtContainer.borderColor = UIColor(red:0.73, green:0.73, blue:0.73, alpha:1)
//        let color = UIColor(red:0.44, green:0.64, blue:0.82, alpha:1)
         let color = UIColor(red:0.4, green:0.47, blue:0.53, alpha:1)
        emailTxtFld.attributedPlaceholder = NSAttributedString(string: emailTxtFld.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : color])
//        passwordTxtContainer.showRoundCorner(roundCorner: 5.0)
//        passwordTxtContainer.borderWidth = 1.0
//        passwordTxtContainer.borderColor = UIColor(red:0.73, green:0.73, blue:0.73, alpha:1)
        passwordTxtFld.attributedPlaceholder = NSAttributedString(string: passwordTxtFld.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : color])
        signinMobileBtn.showRoundCorner(roundCorner: 5.0)
    }
    
    @objc func closeButtonclicked(){
//        emailTxtFld.resignFirstResponder()
        IQKeyboardManager.shared.resignFirstResponder()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.dismiss(animated: true, completion: nil)
        })
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

    
    @objc func keyboardDoneBtnClicked(){
        IQKeyboardManager.shared.resignFirstResponder()
        if validate() == true{
            callLoginService()
        }
    }
    
//    @IBAction func signInButtonClicked(){
//        self.showHomeSreen()
//        return
        /*
        let keycloakConfig = KeycloakConfig(
            clientId: "igrant-ios-app",
            host: "https://iam.igrant.io",
            realm: "igrant-users",
            isOpenIDConnect: true
        )
        let oauth2Module = AccountManager.addKeycloakAccount(config: keycloakConfig)
        let http = Http()
        http.authzModule = oauth2Module
        oauth2Module.login {(accessToken: AnyObject?, claims: OpenIdClaim?, error: NSError?) in // [1]
            // Do your own stuff here
            self.userInfo = claims
            if accessToken != nil{
                let tokenStr : String = accessToken as! String
                userId = tokenStr
            }
            print(claims)
            print(accessToken)
            UserInfo.createDummySession()
            UserInfo.currentUser()?.token = userId
            UserInfo.currentUser()?.save()
            
                    self.showHomeSreen()

        }
 */
//    }
    
//    func shareWithKeycloak() {
//
//        var keycloakConfig = Config(base: "http://localhost:8080/auth",
//                                    authzEndpoint: "realms/shoot-realm/tokens/login",
//                                    redirectURL: "org.aerogear.Shoot://oauth2Callback",
//                                    accessTokenEndpoint: "realms/shoot-realm/tokens/access/codes",
//                                    clientId: "shoot-third-party",
//                                    refreshTokenEndpoint: "realms/shoot-realm/tokens/refresh",
//                                    revokeTokenEndpoint: "realms/shoot-realm/tokens/logout")
//
//        let gdModule = AccountManager.addAccount(keycloakConfig, moduleClass: KeycloakOAuth2Module.self)
//        let http = Http()
//
//        http.authzModule = gdModule
//        self.performUpload("http://localhost:8080/shoot/rest/photos", parameters: self.extractImageAsMultipartParams())
//    }
    
    
    @IBAction func signupButtonClicked(){
        let signupVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as! SignupViewController
        let signupNav = UINavigationController.init(rootViewController: signupVC)
        self.present(signupNav, animated: true, completion: nil)
    }
    
    
    @IBAction func fotgotPwdButtonClicked(){
        let resetPwdVC = Constant.getStoryboard().instantiateViewController(withIdentifier: "ResetPasswordVC") as! ForgotPasswordViewController
        let resetPwdNav = UINavigationController.init(rootViewController: resetPwdVC)
        self.present(resetPwdNav, animated: true, completion: nil)
    }
    
    
    func showOrgDetail(){
        let orgVC = Constant.getStoryboard().instantiateViewController(withIdentifier: "OrgDetailedVC") as! OrganisationViewController
        orgVC.organisationId = orgId ?? ""
        self.navigationController?.pushViewController(orgVC, animated: true)
    }
    

}


extension LoginViewController{
    
    @IBAction func signInButtonClicked(){
        IQKeyboardManager.shared.resignFirstResponder()
        if validate() == true{
            callLoginService()
        }
    }
    
    func validate() -> Bool{
        guard let email = self.emailTxtFld.text, !email.isBlank else {
            self.showWarningAlert(message: Constant.Alert.KPromptMsgEnterEmail)
            return false
        }
        guard let validEmail = self.emailTxtFld.text, validEmail.isValidEmail else {
            self.showWarningAlert(message: Constant.Alert.KPromptMsgEnterValidEmail)
            return false
        }
       
        guard let password = self.passwordTxtFld.text, !password.isBlank else {
            self.showWarningAlert(message: Constant.Alert.KPromptMsgEnterPassword)
            return false
        }

        return true
    }
    
    
    func callLoginService(){
            self.addLoadingIndicator()
            let serviceManager = LoginServiceManager()
            serviceManager.managerDelegate = self
            serviceManager.loginService(uname: (self.emailTxtFld.text)!, pwd: (self.passwordTxtFld.text)!)
        }
}


extension LoginViewController:WebServiceTaskManagerProtocol,UITextFieldDelegate{
    func didFinishTask(from manager:AnyObject, response:(data:RestResponse?,error:String?)){
        self.removeLoadingIndicator()
        if response.error != nil{
            self.showErrorAlert(message: response.error!)
        }else{
            if let serviceManager = manager as? LoginServiceManager{
                if serviceManager.serviceType == .Login{
                    
                    showOrgDetail()
                }
                else if serviceManager.serviceType == .ValidEmail{
                    if serviceManager.apiSequenceNumber == self.apiNumber{
                        if response.data?.responseCode == 0{
                            self.showEmailValidationSucess()
                        }else{
                            self.invalidEmailTextLbl.isHidden = false
                            self.invalidEmailTextLbl.text = response.data?.message
                        }
                    }
                }
                
            }
        }
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
       
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
            let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            let tmptext : String = updatedText
            if (tmptext.isValidString){
                if textField.tag == 0{
                    resetEmailValidationUI()
                    if tmptext.isValidEmail{
//                        showEmailValidationSucess()
                        self.emailValidationImageView.isHidden = false
                        self.isConfirmedEmail = true

//                        callEmailValidationApi(email: tmptext)
                    }else{
                        
                    }
                }
                else if textField.tag == 1{
                    revealBtn.isHidden = false
//                    if tmptext.count > 5{
//                        passwordValidationImageView.isHidden = false
//                    }else{
//                        passwordValidationImageView.isHidden = true
//                    }
                }
            }else{
                if textField.tag == 0{
                    resetEmailValidationUI()
                }else{
                    revealBtn.isHidden = true
                    passwordValidationImageView.isHidden = true
                }
            }
            
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 0{
            passwordTxtFld.becomeFirstResponder()
        }else{
            textField.resignFirstResponder()
        }
        return true
        
    }
    
    func resetEmailValidationUI(){
        self.invalidEmailTextLbl.isHidden = true
        self.emailValidationImageView.isHidden = true
        self.isConfirmedEmail = false
    }
    
    func showEmailValidationSucess(){
        let email : String = (self.emailTxtFld.text)!
        if email.isValidEmail == true{
            self.emailValidationImageView.isHidden = false
            self.isConfirmedEmail = true
        }
    }
    
    func callEmailValidationApi(email:String){
            apiNumber = apiNumber + 1
            //            let email : String = (self.emailTextfld.text)!
            let serviceManager = LoginServiceManager()
            serviceManager.apiSequenceNumber = apiNumber
            serviceManager.managerDelegate = self
            serviceManager.validateEmail(email: email)
        }
}



