//
//  SeeMoreVC.swift
//  Flive
//
//  Created by iosteam on 4/5/18.
//  Copyright © 2018 mac for ios. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage
import AVKit

class SeeMoreVC: UIViewController {
    var strCategory : String?
    var strUid = ""
    var categoryWorkout = [Workouts]()
    @IBOutlet weak var seeMoreTV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if strUid == ""{
          self.fetchAllWorkouts()
        }
        else{
            self.fetchAllUserWorkouts()
        }
        
        self.seeMoreTV.rowHeight = 210
        // Do any additional setup after loading the view.
    }
    @IBAction func handleBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func fetchAllUserWorkouts()  {
        let ref = Database.database().reference()
    ref.child("trainer_releation").child(strUid).observe(DataEventType.childAdded, with: { (snap) in
                ref.child("trainer_workouts").child(snap.key).observe(.value) { (snap) in
                    let dic :Dictionary = snap.value as! [String:Any]
                    let workout = Workouts()
                    workout.setValuesForKeys(dic)
                    let timestampNow = round(NSDate().timeIntervalSince1970)
                    if workout.workout_time!.doubleValue < timestampNow{
                        if workout.workout_category == self.strCategory{
                            self.categoryWorkout.append(workout)
                        }
                        
                        self.categoryWorkout.sort(by: { (message1, message2) -> Bool in
                            return  message1.workout_time!.intValue > message2.workout_time!.intValue
                        })
                        
                        self.timer?.invalidate()
                        self.timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(self.reloadTable), userInfo: nil, repeats: false)
                        
                    }
                }
            })
        }
        
    
    func fetchAllWorkouts()  {
        let _ = Database.database().reference().child("trainer_workouts").observe(.childAdded) { (snap) in
            let dic :Dictionary = snap.value as! [String:Any]
            let workout = Workouts()
            workout.setValuesForKeys(dic)
            let timestampNow = round(NSDate().timeIntervalSince1970)
            if workout.workout_time!.doubleValue < timestampNow{
            if workout.workout_category == self.strCategory{
                self.categoryWorkout.append(workout)
            }

           self.categoryWorkout.sort(by: { (message1, message2) -> Bool in
                return  message1.workout_time!.intValue > message2.workout_time!.intValue
            })
           
            self.timer?.invalidate()
            self.timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(self.reloadTable), userInfo: nil, repeats: false)
            
            }
        }
    }
    var timer : Timer?
    @objc func reloadTable() {
        self.seeMoreTV.reloadData()
    }
    @IBAction func getProfile(_ sender: UIButton) {
        let workout = categoryWorkout[sender.tag]
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TrainerProfileVC") as! TrainerProfileVC
        vc.trainerUID = workout.trainer_id ?? ""
        vc.viewer = true
        self.navigationController?.pushViewController(vc, animated: false)
    }
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
    @IBAction func handleMenu(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MenuTrainerVC") as! MenuTrainerVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
}
extension SeeMoreVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let workout = categoryWorkout[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrainerComingSoonTVC", for: indexPath) as! TrainerComingSoonTVC
        cell.btnGetProfile.tag = indexPath.row
        cell.workoutDisc.text = workout.workout_title
        cell.workoutImg.sd_setImage(with: URL(string: workout.workout_thumbnail_url!), placeholderImage: UIImage(named: "placeholder.png"))
        cell.workoutTime.text = "\(workout.workout_length!):00"
        if let seconds = workout.workout_time{
            let timestampDate = Date(timeIntervalSince1970: TimeInterval(truncating: seconds)).timeAgoSinceNow
            cell.workoutPostTime.text  = timestampDate
            
        }
        Database.database().reference().child("trainer").child(workout.trainer_id!).observe(.value) { (snap) in
            let dic :Dictionary = snap.value as! [String:Any]
            let trainer = TrainerDetail()
            trainer.setValuesForKeys(dic)
            cell.trainerName.text = trainer.name ?? ""
            cell.trainerProfileImg.sd_setImage(with: URL(string: trainer.imageUrl!), placeholderImage: UIImage(named: "placeholder.png"))
        }

        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryWorkout.count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCell(withIdentifier: "TrainerWorkoutHeader") as! TrainerWorkoutHeader
        headerCell.lblTitle.text = strCategory
        return headerCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let workout = categoryWorkout[indexPath.row]
            let videoURL = URL(string: workout.workout_video_url ?? "")
            let player = AVPlayer(url: videoURL as! URL)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.present(playerViewController, animated: true) {
                playerViewController.player!.play()
            }
    }
    
}
