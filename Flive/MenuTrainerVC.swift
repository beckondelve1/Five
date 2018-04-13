//
//  MenuTrainerVC.swift
//  Flive
//
//  Created by mac for ios on 3/28/18.
//  Copyright © 2018 mac for ios. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class MenuTrainerVC: UIViewController {
    
    @IBOutlet weak var CategoryFilterTV: UITableView!
    var workouts = [Workouts]()
    var uniqueWorkouts = [Workouts]()
    var workoutCategory = [String]()
    @IBAction func handleHome(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "homeVC") as! homeVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func handlenotifications
        (_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TrainerNotificationsVC") as! TrainerNotificationsVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func handleCreateNewWorkout(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateNewWorkoutVC") as! CreateNewWorkoutVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func handleTrainerProfile(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TrainerProfileVC") as! TrainerProfileVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
self.fetchAllWorkouts()
        // Do any additional setup after loading the view.
    }

    func fetchAllWorkouts(){
        let ref = Database.database().reference()
        if let uid = Auth.auth().currentUser?.uid{
            ref.child("trainer_releation").child(uid).observe(.childAdded, with: { (snap) in
                ref.child("trainer_workouts").child(snap.key).observe(.value, with: { (snapshot) in
                    let dic :Dictionary = snapshot.value as! [String:Any]
                    let workout = Workouts()
                    workout.setValuesForKeys(dic)
                    //self.workouts.append(workout)
                    switch workout.workout_category ?? ""{
                    case "Weight Loss" :
                        if self.workoutCategory.contains("Weight Loss"){
                            return
                        }
                        self.workoutCategory.append("Weight Loss")
                    case "Cardio and Endurance":
                        if self.workoutCategory.contains("Cardio and Endurance"){
                            return
                        }
                        self.workoutCategory.append("Cardio and Endurance")
                    case "Buliding Muscle" :
                        if self.workoutCategory.contains("Buliding Muscle"){
                            return
                        }
                        self.workoutCategory.append("Buliding Muscle")
                    case "Other":
                        if self.workoutCategory.contains("Other"){
                            return
                        }
                        self.workoutCategory.append("Other")
                    default :
                        print("Nonnnnee")
                    }
                    self.CategoryFilterTV.reloadData()
                
                })
            })
        }
    }
 
}
extension MenuTrainerVC : UITableViewDelegate, UITableViewDataSource{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return   workoutCategory.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrainerMenuCell", for: indexPath) as! TrainerMenuCell
        //let arrValue =  Array(Set(self.workouts))
       // let work = arrValue[indexPath.row]
        cell.menuImg.image = UIImage(named:workoutCategory[indexPath.row])
        cell.MenuLbl1.text = workoutCategory[indexPath.row]
        cell.menuLbl2.text = ""
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SeeMoreVC") as! SeeMoreVC
        vc.strUid = (Auth.auth().currentUser?.uid)!
        vc.strCategory = workoutCategory[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: false)
    }
}
extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: [Iterator.Element: Bool] = [:]
        return self.filter { seen.updateValue(true, forKey: $0) == nil }
    }
}
