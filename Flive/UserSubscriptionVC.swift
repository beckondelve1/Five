//
//  UserSubscriptionVC.swift
//  Flive
//
//  Created by iosteam on 3/26/18.
//  Copyright © 2018 mac for ios. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD
class UserSubscriptionVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func handleBasicPlan(_ sender: Any) {
         savePlanToFirebase(plan: "basic")
    }
    
    @IBAction func handlePopularPlan(_ sender: Any) {
         savePlanToFirebase(plan: "popular")
    }
    
    @IBAction func handlePremiumPlan(_ sender: Any) {
        savePlanToFirebase(plan: "premium")
    }
    
    func savePlanToFirebase(plan : String ){
        let ref = Database.database().reference().child("user")
       if  let uid = Auth.auth().currentUser?.uid {
        ref.child(uid).updateChildValues(["plan" : plan], withCompletionBlock: { (err, ref) in
            if err != nil {
                print(err ?? "")
                return
            }
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserVC") as! UserVC
            SVProgressHUD.dismiss()
            self.navigationController?.pushViewController(vc, animated: true)
        })
       
        }
    }

}
