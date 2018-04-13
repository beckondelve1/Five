//
//  CompetencyLevelVC.swift
//  Flive
//
//  Created by mac for ios on 3/13/18.
//  Copyright © 2018 mac for ios. All rights reserved.
//

import UIKit
import SVProgressHUD
import Firebase

class CompetencyLevelVC: UIViewController {
    
    @IBOutlet weak var beginnerImg: UIImageView!
    
    @IBOutlet weak var intermediateImg: UIImageView!
    
    @IBOutlet weak var advanceImg: UIImageView!
    var competencyLevel = ""
    var call = Functions()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func back2category(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func BeginnerBtn(_ sender: Any) {
        if beginnerImg.image == #imageLiteral(resourceName: "checked_sel"){
            beginnerImg.image = #imageLiteral(resourceName: "check")
            intermediateImg.image = #imageLiteral(resourceName: "checked_sel")
            advanceImg.image = #imageLiteral(resourceName: "checked_sel")
            competencyLevel = "Beginner"
        }else{
            beginnerImg.image = #imageLiteral(resourceName: "checked_sel")
            competencyLevel = ""
        }
    }

    @IBAction func IntermediateBtn(_ sender: Any) {
        if intermediateImg.image == #imageLiteral(resourceName: "checked_sel"){
            intermediateImg.image = #imageLiteral(resourceName: "check")
            beginnerImg.image = #imageLiteral(resourceName: "checked_sel")
            advanceImg.image = #imageLiteral(resourceName: "checked_sel")
            competencyLevel = "Intermediate"
        }else{
            intermediateImg.image = #imageLiteral(resourceName: "checked_sel")
           competencyLevel = ""
        }
    }
    @IBAction func AdvanceBtn(_ sender: Any) {
        if advanceImg.image == #imageLiteral(resourceName: "checked_sel"){
            advanceImg.image = #imageLiteral(resourceName: "check")
            beginnerImg.image = #imageLiteral(resourceName: "checked_sel")
            intermediateImg.image = #imageLiteral(resourceName: "checked_sel")
            competencyLevel = "Advance"
        }else{
            advanceImg.image = #imageLiteral(resourceName: "checked_sel")
            competencyLevel = ""
        }
    }
 
    @IBAction func go2workoutType(_ sender: Any) {
        SVProgressHUD.show()
        
        if competencyLevel == ""{
            call.showAlertWithoutAction(title: "Error", message: "Select Competency Level!", view: self)
            SVProgressHUD.dismiss()
        }
        else{
            let ref = Database.database().reference().child("user")
            if let userUid = Auth.auth().currentUser?.uid{
                ref.child(userUid).updateChildValues(["competencyLevel": competencyLevel], withCompletionBlock: { (err, refr) in
                    if err != nil{
                        print(err?.localizedDescription ?? "")
                        return
                    }
                    SVProgressHUD.dismiss()
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "PreferredWorkoutsVC") as! PreferredWorkoutsVC
                    self.navigationController?.pushViewController(vc, animated: true)
                    //self.present(vc, animated: true, completion: nil)
                })
            }
        }
    }


}
