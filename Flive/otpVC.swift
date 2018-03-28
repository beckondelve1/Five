//
//  otpVC.swift
//  Flive
//
//  Created by mac for ios on 3/13/18.
//  Copyright © 2018 mac for ios. All rights reserved.
//

import UIKit
import SVProgressHUD
import Firebase
class otpVC: UIViewController {
    let call = Functions ()
     
    @IBAction func backtomailvc(_ sender: Any) { self.dismiss(animated: true, completion: nil)
    }
    @IBAction func goToCreateACC(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateAccountVC") as! CreateAccountVC
        present(vc, animated: true, completion: nil)
    }
    var userEmail: String?
    var value = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        otpfield1.addTarget(self, action: #selector(textFieldDidChange(textfield:)), for: UIControlEvents.editingChanged)
        otpfield1.addTarget(self, action: #selector(textFieldDidChange(textfield:)), for: UIControlEvents.editingChanged)
        otpfield2.addTarget(self, action: #selector(textFieldDidChange(textfield:)), for: UIControlEvents.editingChanged)
        otpfield3.addTarget(self, action: #selector(textFieldDidChange(textfield:)), for: UIControlEvents.editingChanged)
        otpfield4.addTarget(self, action: #selector(textFieldDidChange(textfield:)), for:UIControlEvents.editingChanged)
        callForOTP(email: userEmail!)
        // Do any additional setup after loading the view.
    }
   
    
    @objc func textFieldDidChange(textfield:UITextField){
        
        
        
        let text1:String = otpfield1.text!
        let text2:String = otpfield2.text!
        let text3:String = otpfield3.text!
        let text4:String = otpfield4.text!
        let text = "\(text1)"+"\(text2)"+"\(text3)"+"\(text4)"
        print(text)
      
        switch textfield {
        case otpfield1:
            
             otpfield2.becomeFirstResponder()
        case otpfield2:
            otpfield3.becomeFirstResponder()
           
        case otpfield3:
            otpfield4.becomeFirstResponder()
            
        case otpfield4:
            otpfield4.resignFirstResponder()
            verifyOTP(otp: text, email: userEmail!)
                  default:
           print("nooo")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var otpfield1: UITextField!
    
    @IBOutlet weak var otpfield2: UITextField!

    @IBOutlet weak var otpfield3: UITextField!
    @IBOutlet weak var otpfield4: UITextField!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @IBAction func handleResend(_ sender: Any) {
        self.resetTextFields()
        self.callForDeleteUserOTP(email: userEmail!)
    }
    func resetTextFields(){
        otpfield1.text = ""
        otpfield2.text = ""
        otpfield3.text = ""
        otpfield4.text = ""
    }
    //MARK:- API Calls
    func callForDeleteUserOTP(email: String){
        let url = URL(string: "http://allappshere.in/phpteam/flive/index.php?action=delete_user&userEmail=\(email)")
        let task = URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil{
                print(error ?? "")
                return
            }
            do {
                let myJson2 = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                if let msg = myJson2["success"] as? Int
                {
                    if msg == 1{
                        self.callForOTP(email: email)
                    }
                }
            }
            catch
            {
                
            }
            
        })
        task.resume()
    }
    func callForOTP(email: String){
        SVProgressHUD.show()
        let url = URL(string: "http://allappshere.in/phpteam/flive/index.php?action=fliveUserSign&userEmail=\(email)")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil
            {
                print ("ERROR")
            }
            else
            {
                if let content = data
                {
                    do
                    {
                        //Array
                        let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        print(myJson)
                        if let msg = myJson["success"] as? Int
                        {
                            if msg == 0{
                                self.callForDeleteUserOTP(email: email)
                            }
                            else{
                                SVProgressHUD.dismiss()
                                self.call.showAlertWithoutAction(title: "Success", message: "OTP sent successfully to your email.", view: self)
                                
                                
                            }
                        }
                    }
                    catch
                    {
                        
                    }
                }
            }
        }
        task.resume()
        
    }
    
    func verifyOTP(otp:String, email: String){
        SVProgressHUD.show()
        let url = URL(string: "http://allappshere.in/phpteam/flive/index.php?action=fliveOtp&userEmail=\(email)&userOtp=\(otp)")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                return
            }
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as AnyObject
                if let msg = json["success"] as? Int
                {
                   
                    if msg == 0{
                         SVProgressHUD.dismiss()
                        self.call.showAlertWithoutAction(title: "Error", message: "OTP not matched.", view: self)
                    }
                    else{
                        SVProgressHUD.dismiss()
                        self.dismiss(animated: false, completion: nil)
                        DispatchQueue.main.async {
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateAccountVC") as! CreateAccountVC
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                       
                        
                        
                    }
                }
               
            }
            catch{
                
            }
            
        }
        task.resume()
    }
    
 
}

extension otpVC: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        otpfield1.resignFirstResponder()
        otpfield2.resignFirstResponder()
        otpfield3.resignFirstResponder()
        otpfield4.resignFirstResponder()
        return true
    }
    
  
}
