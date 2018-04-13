//
//  LoginVC.swift
//  Flive
//
//  Created by iOS Devlopers on 3/27/18.
//  Copyright © 2018 mac for ios. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD
class LoginVC: UIViewController {
    let call = Functions()
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

@IBAction func handleLogin(_ sender: Any) {
    SVProgressHUD.show()
    if let txtemail = email.text , let txtPassword = password.text{
        Auth.auth().signIn(withEmail: txtemail, password: txtPassword, completion: { (user,err) in
       // Auth.auth().signIn(withEmail: "testing.beckondelve@gmail.com", password: "1234567", completion: { (user,err) in
            if err != nil {
                SVProgressHUD.dismiss()
                self.call.showAlertWithoutAction(title: "Error", message: (err?.localizedDescription)!, view: self)
                return
            }
            if let uid = user?.uid {
                let ref = Database.database().reference().child("user_types")
                ref.child(uid).observeSingleEvent(of: .value, with: { (snap) in
                    let snapshot = snap.value as! [String:Any]
                    let type = snapshot["type"]! as! String
                    SVProgressHUD.dismiss()
                    if type  == "user"{
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserVC") as! UserVC
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                    }
                    else{
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "homeVC") as! homeVC
                        self.navigationController?.pushViewController(vc, animated: true)
                        //self.present(vc, animated: true, completion: nil)
                    }
                }, withCancel: nil)
            }
           
        })
    }
    }
@IBAction func backButton(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
    }

}
extension LoginVC : UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        email.resignFirstResponder()
        password.resignFirstResponder()
        return true
    }
    
    
}
