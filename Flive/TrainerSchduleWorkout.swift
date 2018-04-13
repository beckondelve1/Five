//
//  TrainerSchduleWorkout.swift
//  Flive
//
//  Created by Gurtej Singh on 03/04/18.
//  Copyright © 2018 mac for ios. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import SVProgressHUD
class TrainerSchduleWorkout: UIViewController {
    @IBOutlet weak var selectedDateTime: UIButton!
    @IBOutlet weak var dateTimeView: UIView!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var dateTimePicker: UIDatePicker!
    var dateAndTime : String?
    var preferredWorkouts : String?
    var videoUrl : String?
    var workoutTitle: String?
    var thumbnailURL : String?
    var videoLength : String?
    var levelWorkout : String?
    var category : String?
    var previewVideoUrl : String?
    var previewThumbnailURL :String?
    override func viewDidLoad() {
        super.viewDidLoad()
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        popupView.addSubview(blurEffectView)
        dateTimePicker.setValue(UIColor.white, forKeyPath: "textColor")
        dateTimePicker.minimumDate = Date()
        
    }
    @IBAction func handleDateDone(_ sender: Any) {
        popupView.isHidden = true
        
        dateTimeView.isHidden = true
        dateAndTime = self.dateTimePicker.date.timeIntervalSince1970.description
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy, h:mm a"
        let strDate = dateFormatter.string(from: dateTimePicker.date)
        selectedDateTime.setTitle(strDate, for: .normal)
      // self.lblSelectDateTime.text = strDate
        
    }
    @IBAction func handleDateAndTime(_ sender: Any) {
        popupView.isHidden = false
        dateTimeView.isHidden = false
    }
    @IBAction func handlePublish(_ sender: Any) {
        
            if let uid = Auth.auth().currentUser?.uid{
                let ref = Database.database().reference()
                let ref2 = Database.database().reference()
                let refWithAutoID = ref.child("trainer_workouts").childByAutoId()
                let post = ["preferred_workouts":preferredWorkouts,"workout_title":workoutTitle,"workout_length":videoLength,"level_of_workout":levelWorkout,"workout_category":category,"workout_time":dateAndTime,"workout_video_url":videoUrl,"workout_thumbnail_url":thumbnailURL,"workout_preview_video_url":previewVideoUrl!,"workout_preview_thumbnail_url":previewThumbnailURL!,"trainer_id":uid]
                refWithAutoID.updateChildValues(post as Any as! [AnyHashable : Any]) { (err, ref) in
                    if err != nil {
                        print(err ?? "")
                        return
                    }
                    let key = refWithAutoID.key
                    ref2.child("trainer_releation").child(uid).updateChildValues([key:"1"], withCompletionBlock: { (err, refr) in
                        if err != nil {
                            print(err ?? "")
                            return
                        }
                        else{
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AwesomePOPupVC") as! AwesomePOPupVC
                            self.navigationController?.pushViewController(vc, animated: false)
                        }
                    })
                    
                }
            }
        
        
        
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
