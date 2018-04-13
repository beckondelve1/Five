//
//  TrainerDetailVC.swift
//  Flive
//
//  Created by mac for ios on 3/16/18.
//  Copyright © 2018 mac for ios. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class TrainerDetailVC: UIViewController {
    
    @IBOutlet weak var txtBio: UITextView!
    @IBOutlet weak var txtAdd1: UITextField!
    @IBOutlet weak var txtAdd2: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtCode: UITextField!
    var call = Functions()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handleUpdateProfile(_ sender: Any) {
        if txtBio.text == "" {
            call.showAlertWithoutAction(title: "Error", message: "Bio is required", view: self)
        }
        else if txtAdd1.text == ""{
            call.showAlertWithoutAction(title: "Error", message: "Address is required", view: self)
        }
        else if txtCode.text == ""{
            call.showAlertWithoutAction(title: "Error", message: "Postcode is required", view: self)
            
        }
        else{
            let ref = Database.database().reference().child("trainer")
            if let userUid = Auth.auth().currentUser?.uid{
                ref.child(userUid).updateChildValues(["bio": txtBio.text!,"address1": txtAdd1.text!,"address2": txtAdd2.text!,"city": txtCity.text!,"code": txtCode.text!], withCompletionBlock: { (err, refr) in
                    if err != nil{
                        print(err?.localizedDescription ?? "")
                        return
                    }
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "homeVC") as! homeVC
                    SVProgressHUD.dismiss()
                    self.navigationController?.pushViewController(vc, animated: true)
                    //  self.present(vc, animated: true, completion: nil)
                })
            }
        }
       
    }
}
extension TrainerDetailVC : UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        txtBio.text = ""
    }
}
