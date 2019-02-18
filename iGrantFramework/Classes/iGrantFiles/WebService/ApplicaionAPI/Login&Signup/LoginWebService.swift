//
//  LoginWebService.swift
//  DocuTRUST
//
//  Created by Ajeesh Thankachan on 17/05/18.
//  Copyright © 2018 Marlabs. All rights reserved.
//

import UIKit

class LoginWebService: BaseWebService {
    func callLoginService(){
        self.url = baseUrl + "users/login"
        POST()
    }
    
    func callSignupService(){
        self.url = baseUrl + "users/register"
        POST()
    }
    
    func generateOtpService(){
        self.url = baseUrl + "users/verify/phone"
        POST()
    }
    
    func verifyOtpService(){
        self.url = baseUrl + "users/verify/otp"
        POST()
    }
    
    func validEmailSerivce(){
        self.url = baseUrl + "users/validate/email"
        POST()
    }
    
    func forgotPasswordSerivce(){
        self.url = baseUrl + "user/password/forgot"
        PUT()
    }
    
    func validPhoneSerivce(){
        self.url = baseUrl + "users/validate/phone"
        POST()
    }

    func callForgotpasswordService(){
        self.url = baseUrl + "users/forgotPassword"
        GET()
    }
    
    func changeProfileImageService(){
        self.url = baseUrl + "user/image"
        POST()
    }
    
    func updateProfileInfoService(){
        self.url = baseUrl + "user"
        PATCH()
    }
   
    func changePwdService(){
        self.url = baseUrl + "user/password/reset"
        PUT()
    }
    
    func updateDeviceToken(){
        self.url = baseUrl + "user/register/ios"
        POST()

//        var userId : String = ""
//        ifConstant.Userinfo.currentUser.iGrantUserID != ""{
//            userId =  Constant.Userinfo.currentUser.iGrantUserID 
//        }
//        var accessToken : String = ""
//        if Constant.Userinfo.currentUser.isUserAvailable{
//            accessToken = Constant.Userinfo.currentUser.iGrantToken
//        }
//        self.url = baseUrl + "users/" + userId + "?access_token=" + accessToken
//        PATCH()
    }
}
