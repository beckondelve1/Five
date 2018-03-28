//
//  SignupViaEmailVC.swift
//  Flive
//
//  Created by mac for ios on 3/13/18.
//  Copyright © 2018 mac for ios. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class SignupViaEmailVC: UIViewController {
let call = Functions()
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      self.view.endEditing(true)
    }
    
    @IBAction func SignUpConfirmation(_ sender: Any) {
       SVProgressHUD.show()
        if password.text == confirmPassword.text {
            if let txtEmail = email.text , let txtPassword = password.text {
                Auth.auth().createUser(withEmail: txtEmail, password: txtPassword, completion: { (user, error) in
                    if error != nil{
                        SVProgressHUD.dismiss()
                        self.call.showAlertWithoutAction(title: "Error", message: (error?.localizedDescription)!, view: self)
                        return
                    }
                    if let uid = user?.uid{
                        SVProgressHUD.dismiss()
                         let vc = self.storyboard?.instantiateViewController(withIdentifier: "otpVC") as! otpVC
                        vc.userEmail = txtEmail
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                   
                })
            }
        }
        else{
            call.showAlertWithoutAction(title: "Error", message: "Password not matched", view: self)
        }
        
        
    }

}

extension SignupViaEmailVC : UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        email.resignFirstResponder()
        password.resignFirstResponder()
        confirmPassword.resignFirstResponder()
        return true
    }
   
 
}
