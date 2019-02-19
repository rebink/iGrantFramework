//
//  GetOTPViewController.swift
//  iGrant
//
//  Created by Ajeesh T S on 05/04/18.
//  Copyright © 2018 iGrant.com. All rights reserved.
//

import UIKit

class GetOTPViewController: BaseViewController {
    @IBOutlet weak var otpTxtContainer: UIView!
    @IBOutlet weak var otpTxtFld: UITextField!
    @IBOutlet weak var getOtpBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        uiSetup()
        self.title = "Mobile Number".localized()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        otpTxtFld.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }
    
    func uiSetup(){
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = UIColor.black
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont(name: "OpenSans", size: 18)!
        ]
        otpTxtContainer.showRoundCorner(roundCorner: 5.0)
        otpTxtContainer.borderWidth = 1.0
        otpTxtContainer.borderColor = UIColor(red:0.73, green:0.73, blue:0.73, alpha:1)
        let color = UIColor(red:0.44, green:0.64, blue:0.82, alpha:1)
        otpTxtFld.attributedPlaceholder = NSAttributedString(string: otpTxtFld.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : color])
        getOtpBtn.showRoundCorner(roundCorner: 5.0)
    }

    @IBAction func getOtpButtonClicked(){
        let otpVC = Constant.getStoryboard(vc: self.classForCoder).instantiateViewController(withIdentifier: "OTPSendingVC") as! OtpEnteringViewController
        self.navigationController?.pushViewController(otpVC, animated: true)

    }
  

}
