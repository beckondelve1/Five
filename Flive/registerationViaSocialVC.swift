//
//  registerationViaSocialVC.swift
//  Flive
//
//  Created by mac for ios on 3/13/18.
//  Copyright © 2018 mac for ios. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import SVProgressHUD

class registerationViaSocialVC: UIViewController {

    @IBOutlet weak var registerWithFB: UIButton!
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func signupemailPress(_ sender: UIButton) {
        let emailsignupViewController = self.storyboard?.instantiateViewController(withIdentifier: "SignupViaEmailVC") as! SignupViaEmailVC
       // present(emailsignupViewController, animated: true, completion: nil)
        self.navigationController?.pushViewController(emailsignupViewController, animated: true)
        
    }
    @IBAction func signupFBPress(_ sender: UIButton) {
        let facebookLogin = FBSDKLoginManager()
        print("Logging In")
        facebookLogin.logIn(withReadPermissions: ["email"], from: self, handler:{(facebookResult, facebookError) -> Void in
            if facebookError != nil { print("Facebook login failed.Error \(String(describing: facebookError))")
            } else if (facebookResult?.isCancelled)! {
                print("Facebook login was cancelled.")
            } else{
                SVProgressHUD.show()
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                Auth.auth().signIn(with: credential, completion: { (user, error) in
                    if error != nil{
                        print(error ?? "")
                        return
                    }
                    if let uid = user?.uid{
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateAccountVC") as! CreateAccountVC
                        vc.userUid = uid
                        SVProgressHUD.dismiss()
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                })
                
            }
        });
    }
    @IBAction func directLoginPress(_ sender: UIButton) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            self.navigationController?.pushViewController(vc, animated: true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
