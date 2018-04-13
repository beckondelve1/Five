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
                
                //Graph Request for Image
                let request = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, email, picture.type(large),gender"])
                let _ = request?.start(completionHandler: { (connection, result, error) in
                    guard let userInfo = result as? [String: Any] else { return } //handle the error
                    
                    //The url is nested 3 layers deep into the result so it's pretty messy
                    if let imageURL = ((userInfo["picture"] as? [String: Any])?["data"] as? [String: Any])?["url"] as? String {
                        let gender = userInfo["gender"] as! String
                        let fname = userInfo["first_name"] as! String
                        let lname = userInfo["last_name"] as! String
                        let name = "\(fname) \(lname)"
                        SVProgressHUD.show()
                        let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                        Auth.auth().signIn(with: credential, completion: { (user, error) in
                            if error != nil{
                                print(error ?? "")
                                return
                            }
                            if let uid = user?.uid{
                                let ref = Database.database().reference().child("user_types")
                                
                                ref.child(uid).observeSingleEvent(of: .value, with: { (snap) in
                                    if snap.hasChild("type"){
                                        let snapshot = snap.value as! [String:Any]
                                        if snapshot.index(forKey: "type") == nil{
                                            print("no type exist")
                                            return
                                        }
                                        else{
                                            let type = snapshot["type"]! as! String
                                            if type  == "user"{
                                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserVC") as! UserVC
                                                self.navigationController?.pushViewController(vc, animated: true)
                                                
                                            }
                                            else if type  == "trainer" {
                                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "homeVC") as! homeVC
                                                self.navigationController?.pushViewController(vc, animated: true)
                                                //self.present(vc, animated: true, completion: nil)
                                            }
                                            else{
                                                print("no user")
                                                return
                                            }
                                            SVProgressHUD.dismiss()
                                        }
                                    }
                                    else{
                                        
                                        print("nochild")
                                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateAccountVC") as! CreateAccountVC
                                        vc.userUid = uid
                                        vc.fbGender = gender
                                        vc.fbName = name
                                        vc.fbImageUrl = imageURL
                                        SVProgressHUD.dismiss()
                                        self.navigationController?.pushViewController(vc, animated: true)
                                    }
                                    
                                    
                                }, withCancel: nil)
                            }
                           
                        })
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
