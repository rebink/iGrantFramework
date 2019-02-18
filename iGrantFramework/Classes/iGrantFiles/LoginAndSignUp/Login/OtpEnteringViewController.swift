//
//  OtpEnteringViewController.swift
//  iGrant
//
//  Created by Ajeesh T S on 09/04/18.
//  Copyright © 2018 iGrant.com. All rights reserved.
//

import UIKit

class OtpEnteringViewController: BaseViewController,UITextFieldDelegate {
    @IBOutlet weak var otpTxtFld: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var otpValidationImageView: UIImageView!
    @IBOutlet weak var otpDescLbl: UILabel!
    var phoneNumber = ""
    var signupInfo : SignUpData!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUI(){
        self.title = Constant.AppSetupConstant.KAppName
        submitBtn.showRoundCorner()
        let color = UIColor(red:0.4, green:0.47, blue:0.53, alpha:1)
        otpTxtFld.attributedPlaceholder = NSAttributedString(string: otpTxtFld.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : color])
        otpDescLbl.text = "A text message with a 6-digit verification code was just sent to ".localized() + phoneNumber

    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 6
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        if newString.length == maxLength {
            otpValidationImageView.isHidden = false
        }else{
            otpValidationImageView.isHidden = true
        }
        return true
    }
    
    @IBAction func submitButtonClicked(){
        guard let otpNumber = self.otpTxtFld.text, !otpNumber.isBlank else {
            self.showWarningAlert(message: Constant.Alert.KPromptMsgEnterOTP)
            return
        }
       // if self.isNetWorkAvailable{
            self.addLoadingIndicator()
            let serviceManager = LoginServiceManager()
            serviceManager.managerDelegate = self
            serviceManager.verfiyOtpNumber(phone: self.phoneNumber, otp: otpNumber)
        //}
        
    }
  
    func showPasswordView(){
        let passwordVC = Constant.getStoryboard().instantiateViewController(withIdentifier: "PasswordVC") as! PasswordViewController
        self.signupInfo.phone = self.phoneNumber
        passwordVC.signupInfo = self.signupInfo
        self.navigationController?.pushViewController(passwordVC, animated: true)
        
    }
}

extension OtpEnteringViewController:WebServiceTaskManagerProtocol{
    
    func didFinishTask(from manager:AnyObject, response:(data:RestResponse?,error:String?)){
        if response.error != nil{
            self.removeLoadingIndicator()
            self.showErrorAlert(message: response.error!)
        }else{
            if let serviceManager = manager as? LoginServiceManager{
                if serviceManager.serviceType == .VerifyOTP{
                   self.showPasswordView()
                }
                else if serviceManager.serviceType == .GenarateOTP{
                    if response.data?.responseCode == 1{
                        self.otpValidationImageView.isHidden = false
                    }else{
                        
                    }
                }
                
            }
        }
    }
    
   
    
}
