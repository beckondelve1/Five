//
//  CategoriesVC.swift
//  Flive
//
//  Created by mac for ios on 3/13/18.
//  Copyright © 2018 mac for ios. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD
class CategoriesVC: UIViewController {
    var category :String = ""
    var call = Functions()
    @IBAction func NextBtn(_ sender: UIButton) {
        SVProgressHUD.show()
        if category == ""{
            call.showAlertWithoutAction(title: "Error", message: "Please Select Atleast One Category!", view: self)
            SVProgressHUD.dismiss()
        }
        else{
            let ref = Database.database().reference().child("user")
            if let userUid = Auth.auth().currentUser?.uid{
                ref.child(userUid).updateChildValues(["category": category], withCompletionBlock: { (err, refr) in
                    if err != nil{
                        print(err?.localizedDescription ?? "")
                        return
                    }
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "CompetencyLevelVC") as! CompetencyLevelVC
                    SVProgressHUD.dismiss()
                    self.navigationController?.pushViewController(vc, animated: true)
                  //  self.present(vc, animated: true, completion: nil)
                })
            }
        }
    }
    
    @IBAction func backItem(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
}
    @IBOutlet weak var buildingmuscleImg: UIImageView!
    
    @IBOutlet weak var weightlossImg: UIImageView!
    
    @IBOutlet weak var yogaImg: UIImageView!
    @IBOutlet weak var cardioImg: UIImageView!
    @IBAction func buildingmuscleBtn(_ sender: Any) {
        if buildingmuscleImg.image == #imageLiteral(resourceName: "checked_sel"){
            buildingmuscleImg.image = #imageLiteral(resourceName: "check")
            weightlossImg.image = #imageLiteral(resourceName: "checked_sel")
             yogaImg.image = #imageLiteral(resourceName: "checked_sel")
             otherImg.image = #imageLiteral(resourceName: "checked_sel")
            cardioImg.image = #imageLiteral(resourceName: "checked_sel")
            category = "Buliding Muscle"
            
        }
        else{
            buildingmuscleImg.image = #imageLiteral(resourceName: "checked_sel")
             category = ""
        }
        
    }
    @IBOutlet weak var otherImg: UIImageView!

    @IBAction func weightlossbtn(_ sender: Any) {
        if weightlossImg.image == #imageLiteral(resourceName: "checked_sel"){
            weightlossImg.image = #imageLiteral(resourceName: "check")
            yogaImg.image = #imageLiteral(resourceName: "checked_sel")
            otherImg.image = #imageLiteral(resourceName: "checked_sel")
            buildingmuscleImg.image = #imageLiteral(resourceName: "checked_sel")
            cardioImg.image = #imageLiteral(resourceName: "checked_sel")
             category = "Weight Loss"
        }else{
            weightlossImg.image = #imageLiteral(resourceName: "checked_sel")
            category = ""
            
        }
    }
    @IBAction func yogaCoreBtn(_ sender: Any) {
        if yogaImg.image == #imageLiteral(resourceName: "checked_sel"){
            yogaImg.image = #imageLiteral(resourceName: "check")
            weightlossImg.image = #imageLiteral(resourceName: "checked_sel")
            otherImg.image = #imageLiteral(resourceName: "checked_sel")
            buildingmuscleImg.image = #imageLiteral(resourceName: "checked_sel")
            cardioImg.image = #imageLiteral(resourceName: "checked_sel")
             category = "Yoga and Core"
        }
        else{
            yogaImg.image = #imageLiteral(resourceName: "checked_sel")
            category = ""
        }
    }
    
    @IBAction func cardioBtn(_ sender: Any) {
        if cardioImg.image == #imageLiteral(resourceName: "checked_sel"){
            cardioImg.image = #imageLiteral(resourceName: "check")
            weightlossImg.image = #imageLiteral(resourceName: "checked_sel")
            yogaImg.image = #imageLiteral(resourceName: "checked_sel")
            otherImg.image = #imageLiteral(resourceName: "checked_sel")
            buildingmuscleImg.image = #imageLiteral(resourceName: "checked_sel")
             category = "Cardio and Endurance"
        }
        else{
            cardioImg.image = #imageLiteral(resourceName: "checked_sel")
            category = ""
        }
    }
    @IBAction func otherBtn(_ sender: Any) {
        if otherImg.image == #imageLiteral(resourceName: "checked_sel"){
            otherImg.image = #imageLiteral(resourceName: "check")
            weightlossImg.image = #imageLiteral(resourceName: "checked_sel")
            yogaImg.image = #imageLiteral(resourceName: "checked_sel")
            cardioImg.image = #imageLiteral(resourceName: "checked_sel")
            buildingmuscleImg.image = #imageLiteral(resourceName: "checked_sel")
             category = "Other"
        }else{
            otherImg.image = #imageLiteral(resourceName: "checked_sel")
            category = ""
        }
    }
}
