//
//  TrainerCreateWorkoutAfterVideoVC.swift
//  Flive
//
//  Created by iosteam on 3/29/18.
//  Copyright © 2018 mac for ios. All rights reserved.
//

import UIKit
import SVProgressHUD
import Firebase
import MobileCoreServices
import AVKit
class TrainerCreateWorkoutAfterVideoVC: UIViewController {
    @IBOutlet weak var length10min: UIButton!
    @IBOutlet weak var workoutTitle: UITextView!
    @IBOutlet weak var lblSelectWorkout: UILabel!
    @IBOutlet weak var lblSelectCatagory: UILabel!
    @IBOutlet weak var length15min: UIButton!
    @IBOutlet weak var length20min: UIButton!
    @IBOutlet weak var length25min: UIButton!
    @IBOutlet weak var length30min: UIButton!
    @IBOutlet weak var beginner: UIButton!
    @IBOutlet weak var intermediate: UIButton!
    @IBOutlet weak var workoutButton: UIButton!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var advance: UIButton!
    @IBOutlet weak var upload10SecVideo: UIButton!
    @IBOutlet weak var PublishNow: UIButton!
    @IBOutlet weak var schedulePublishTime: UIButton!
    @IBOutlet weak var workoutTypeView: UIView!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var buildingmuscleImg: UIImageView!
    @IBOutlet weak var weightlossImg: UIImageView!
    @IBOutlet weak var yogaImg: UIImageView!
    @IBOutlet weak var cardioImg: UIImageView!
    @IBOutlet weak var otherImg: UIImageView!
    @IBOutlet weak var gymImg: UIImageView!
    @IBOutlet weak var equipmentImg: UIImageView!
    @IBOutlet weak var bodyweightImg: UIImageView!
    @IBOutlet weak var officeImg: UIImageView!
    var preferredWorkouts = ""
    var videoUrl : String?
    var previewVideoUrl = ""
    var previewthumbnailUrl  = ""
    var thumbnailURL : String?
    var videoLength : String?
    var levelWorkout = "" 
    var category = ""
    var dateAndTime : String?
    var call = Functions()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        //Blur popup start
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        popupView.addSubview(blurEffectView)
        //Blur popup End
        popupView.isHidden = true
        categoryView.isHidden = true
        workoutTypeView.isHidden = true
    }
   
    @IBAction func gymBtn(_ sender: Any) {
        if gymImg.image == #imageLiteral(resourceName: "checked_sel") {
            gymImg.image = #imageLiteral(resourceName: "check")
            equipmentImg.image = #imageLiteral(resourceName: "checked_sel")
            bodyweightImg.image = #imageLiteral(resourceName: "checked_sel")
            officeImg.image = #imageLiteral(resourceName: "checked_sel")
            preferredWorkouts = "Gym"
        }else{
            gymImg.image = #imageLiteral(resourceName: "checked_sel")
            preferredWorkouts = ""
        }
    }
    
    @IBAction func equipmentBtn(_ sender: Any) {
        if equipmentImg.image == #imageLiteral(resourceName: "checked_sel") {
            equipmentImg.image = #imageLiteral(resourceName: "check")
            bodyweightImg.image = #imageLiteral(resourceName: "checked_sel")
            officeImg.image = #imageLiteral(resourceName: "checked_sel")
            gymImg.image = #imageLiteral(resourceName: "checked_sel")
            preferredWorkouts = "Home"
        }else{
            equipmentImg.image = #imageLiteral(resourceName: "checked_sel")
            preferredWorkouts = ""
        }
    }
    
    @IBAction func BodyweightBtn(_ sender: Any) {
        if bodyweightImg.image == #imageLiteral(resourceName: "checked_sel") {
            bodyweightImg.image = #imageLiteral(resourceName: "check")
            equipmentImg.image = #imageLiteral(resourceName: "checked_sel")
            officeImg.image = #imageLiteral(resourceName: "checked_sel")
            gymImg.image = #imageLiteral(resourceName: "checked_sel")
            preferredWorkouts = "BodyWeight"
        }else{
            bodyweightImg.image = #imageLiteral(resourceName: "checked_sel")
            preferredWorkouts = ""
        }
    }
    @IBAction func officeBtn(_ sender: Any) {
        if officeImg.image == #imageLiteral(resourceName: "checked_sel") {
            officeImg.image = #imageLiteral(resourceName: "check")
            equipmentImg.image = #imageLiteral(resourceName: "checked_sel")
            bodyweightImg.image = #imageLiteral(resourceName: "checked_sel")
            gymImg.image = #imageLiteral(resourceName: "checked_sel")
            preferredWorkouts = "Office"
        }else{
            officeImg.image = #imageLiteral(resourceName: "checked_sel")
            preferredWorkouts = ""
        }
        print(preferredWorkouts)
    }
    
    @IBAction func handlePrefferedDone(_ sender: Any) {
        popupView.isHidden = true
        categoryView.isHidden = true
        workoutTypeView.isHidden = true
        lblSelectWorkout.text = preferredWorkouts
    }
    @IBAction func handleCategoryDone(_ sender: Any) {
        popupView.isHidden = true
        categoryView.isHidden = true
        workoutTypeView.isHidden = true
        lblSelectCatagory.text = category
    }
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
    func setupUI(){
        length10min.layer.borderColor = UIColor.darkGray.cgColor
        length10min.layer.borderWidth = 2.0
        length10min.layer.cornerRadius = 10
        length10min.clipsToBounds = true
        length10min.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom:10, right: 10)

        length15min.layer.borderColor = UIColor.darkGray.cgColor
        length15min.layer.cornerRadius = 10
        length15min.layer.borderWidth = 2.0
        length15min.clipsToBounds = true
        length15min.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom:10, right: 10)
        
        length20min.layer.borderColor = UIColor.darkGray.cgColor
        length20min.layer.cornerRadius = 10
        length20min.layer.borderWidth = 2.0
        length20min.clipsToBounds = true
        length20min.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom:10, right: 10)
        
        length25min.layer.borderColor = UIColor.darkGray.cgColor
        length25min.layer.cornerRadius = 10
        length25min.layer.borderWidth = 2.0
        length25min.clipsToBounds = true
        length25min.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom:10, right: 10)
        
        length30min.layer.borderColor = UIColor.darkGray.cgColor
        length30min.layer.cornerRadius = 10
        length30min.layer.borderWidth = 2.0
        length30min.clipsToBounds = true
        length30min.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom:10, right: 10)
        
        beginner.layer.borderColor = UIColor.darkGray.cgColor
        beginner.layer.cornerRadius = 10
        beginner.layer.borderWidth = 2.0
        beginner.clipsToBounds = true
        beginner.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom:10, right: 10)
        
        intermediate.layer.borderColor = UIColor.darkGray.cgColor
        intermediate.layer.cornerRadius = 10
        intermediate.layer.borderWidth = 2.0
        intermediate.clipsToBounds = true
        intermediate.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom:10, right: 10)
        
        advance.layer.borderColor = UIColor.darkGray.cgColor
        advance.layer.cornerRadius = 10
        advance.layer.borderWidth = 2.0
        advance.clipsToBounds = true
        advance.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom:10, right: 10)
        
        upload10SecVideo.layer.borderColor = UIColor.darkGray.cgColor
        upload10SecVideo.layer.cornerRadius = 5
        upload10SecVideo.clipsToBounds = true
        
        
        schedulePublishTime.layer.borderColor = UIColor.darkGray.cgColor
        schedulePublishTime.layer.cornerRadius = 5
        schedulePublishTime.clipsToBounds = true
        
        PublishNow.layer.borderColor = UIColor.darkGray.cgColor
        PublishNow.layer.cornerRadius = 5
        PublishNow.clipsToBounds = true
        
    }
    @IBAction func upload10SecVideo(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        let MAX_VIDEO_DURATION = 10.0 // note the .0, must be double, move this at the top of your class preferrebly
        imagePicker.videoMaximumDuration = TimeInterval(MAX_VIDEO_DURATION)
        imagePicker.mediaTypes = [kUTTypeMovie as String]
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action : UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            }
            else{
                self.call.showAlertWithoutAction(title: "Error", message: "Camera not available", view: self)
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action : UIAlertAction) in
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(actionSheet, animated: true, completion: nil)
    }
    @IBAction func PublishNow(_ sender: Any) {
        if workoutTitle.text == "" {
            call.showAlertWithoutAction(title: "Error", message: "Enter workout title", view: self)
        }
        
        else if lblSelectWorkout.text == "" || lblSelectWorkout.text == "Select"{
            call.showAlertWithoutAction(title: "Error", message: "Select workout type", view: self)
        }
        else if lblSelectCatagory.text == "" || lblSelectCatagory.text == "Select"{
            call.showAlertWithoutAction(title: "Error", message: "Select category", view: self)
        }
        else if videoLength == "" {
            call.showAlertWithoutAction(title: "Error", message: "Select workout length", view: self)
        }
        else if levelWorkout == ""{
            call.showAlertWithoutAction(title: "Error", message: "Select level of workout", view: self)
        }
        else if previewVideoUrl == ""{
            call.showAlertWithoutAction(title: "Error", message: "Select 10 sec preview video", view: self)
        }
        else {
            dateAndTime = Date().timeIntervalSince1970.description
            if let uid = Auth.auth().currentUser?.uid{
                let ref = Database.database().reference()
                let ref2 = Database.database().reference()
                let refWithAutoID = ref.child("trainer_workouts").childByAutoId()
                let post = ["preferred_workouts":preferredWorkouts,"workout_title":workoutTitle.text!,"workout_length":videoLength!,"level_of_workout":levelWorkout,"workout_category":category,"workout_time":dateAndTime!,"workout_video_url":videoUrl!,"workout_thumbnail_url":thumbnailURL!,"workout_preview_video_url":previewVideoUrl,"workout_preview_thumbnail_url":previewthumbnailUrl,"trainer_id":uid]
                    refWithAutoID.updateChildValues(post) { (err, ref) in
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
    }
    @IBAction func schedulePublishTime(_ sender: Any) {
        if workoutTitle.text == "" {
            call.showAlertWithoutAction(title: "Error", message: "Enter workout title", view: self)
        }
            
        else if lblSelectWorkout.text == "" || lblSelectWorkout.text == "Select"{
            call.showAlertWithoutAction(title: "Error", message: "Select workout type", view: self)
        }
        else if lblSelectCatagory.text == "" || lblSelectCatagory.text == "Select"{
            call.showAlertWithoutAction(title: "Error", message: "Select category", view: self)
        }
        else if videoLength == "" {
            call.showAlertWithoutAction(title: "Error", message: "Select workout length", view: self)
        }
        else if levelWorkout == ""{
            call.showAlertWithoutAction(title: "Error", message: "Select level of workout", view: self)
        }
        else if previewVideoUrl == ""{
            call.showAlertWithoutAction(title: "Error", message: "Select 10 sec preview video", view: self)
        }
        else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "TrainerSchduleWorkout") as! TrainerSchduleWorkout
            vc.preferredWorkouts = self.preferredWorkouts
            vc.category = self.category
            vc.videoUrl = self.videoUrl
            vc.levelWorkout = self.levelWorkout
            vc.thumbnailURL = self.thumbnailURL
            vc.workoutTitle = self.workoutTitle.text ?? ""
            vc.videoLength = self.videoLength
            vc.previewVideoUrl = self.previewVideoUrl
            vc.previewThumbnailURL = self.previewthumbnailUrl
            self.navigationController?.pushViewController(vc, animated: false)
        }
        
       
    }
    /*
     
     if workoutTitle.text == "" {
     call.showAlertWithoutAction(title: "Error", message: "Enter workout title", view: self)
     }
     
     else if lblSelectWorkout.text == "" || lblSelectWorkout.text == "Select"{
     call.showAlertWithoutAction(title: "Error", message: "Select workout type", view: self)
     }
     else if lblSelectCatagory.text == "" || lblSelectCatagory.text == "Select"{
     call.showAlertWithoutAction(title: "Error", message: "Select category", view: self)
     }
     else if videoLength == "" {
     call.showAlertWithoutAction(title: "Error", message: "Select workout length", view: self)
     }
     else if levelWorkout == ""{
     call.showAlertWithoutAction(title: "Error", message: "Select level of workout", view: self)
     }
     else {
     dateAndTime = Date().timeIntervalSince1970.description
     if let uid = Auth.auth().currentUser?.uid{
     let ref = Database.database().reference()
     let ref2 = Database.database().reference()
     let refWithAutoID = ref.child("trainer_workouts").childByAutoId()
     let post = ["workout_title":workoutTitle.text!,"workout_length":videoLength!,"level_of_workout":levelWorkout,"workout_category":category,"workout_time":dateAndTime!,"workout_video_url":videoUrl!,"workout_thumbnail_url":thumbnailURL!,"trainer_id":uid]
     refWithAutoID.updateChildValues(post) { (err, ref) in
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
     */
    @IBAction func Length10Min(_ sender: Any) {
        videoLength = "10"
        length10min.backgroundColor = UIColor.black
        length15min.backgroundColor = UIColor.white
        length20min.backgroundColor = UIColor.white
        length25min.backgroundColor = UIColor.white
        length30min.backgroundColor = UIColor.white
        
        length10min.setTitleColor(UIColor.white, for: .normal)
        length15min.setTitleColor(UIColor.black, for: .normal)
        length20min.setTitleColor(UIColor.black, for: .normal)
        length25min.setTitleColor(UIColor.black, for: .normal)
        length30min.setTitleColor(UIColor.black, for: .normal)
    }
   
    @IBAction func length15min(_ sender: Any) {
        videoLength = "15"
        length10min.backgroundColor = UIColor.white
        length15min.backgroundColor = UIColor.black
        length20min.backgroundColor = UIColor.white
        length25min.backgroundColor = UIColor.white
        length30min.backgroundColor = UIColor.white
        
        length10min.setTitleColor(UIColor.black, for: .normal)
        length15min.setTitleColor(UIColor.white, for: .normal)
        length20min.setTitleColor(UIColor.black, for: .normal)
        length25min.setTitleColor(UIColor.black, for: .normal)
        length30min.setTitleColor(UIColor.black, for: .normal)
    }
    
    @IBAction func length20min(_ sender: Any) {
        videoLength = "20"
        length10min.backgroundColor = UIColor.white
        length15min.backgroundColor = UIColor.white
        length20min.backgroundColor = UIColor.black
        length25min.backgroundColor = UIColor.white
        length30min.backgroundColor = UIColor.white
        
        length10min.setTitleColor(UIColor.black, for: .normal)
        length15min.setTitleColor(UIColor.black, for: .normal)
        length20min.setTitleColor(UIColor.white, for: .normal)
        length25min.setTitleColor(UIColor.black, for: .normal)
        length30min.setTitleColor(UIColor.black, for: .normal)
    }
    
    @IBAction func length25min(_ sender: Any) {
        videoLength = "25"
        length10min.backgroundColor = UIColor.white
        length15min.backgroundColor = UIColor.white
        length20min.backgroundColor = UIColor.white
        length25min.backgroundColor = UIColor.black
        length30min.backgroundColor = UIColor.white
        
        length10min.setTitleColor(UIColor.black, for: .normal)
        length15min.setTitleColor(UIColor.black, for: .normal)
        length20min.setTitleColor(UIColor.black, for: .normal)
        length25min.setTitleColor(UIColor.white, for: .normal)
        length30min.setTitleColor(UIColor.black, for: .normal)
    }
    
    @IBAction func length30min(_ sender: Any) {
        videoLength = "30"
        length10min.backgroundColor = UIColor.white
        length15min.backgroundColor = UIColor.white
        length20min.backgroundColor = UIColor.white
        length25min.backgroundColor = UIColor.white
        length30min.backgroundColor = UIColor.black
        
        length10min.setTitleColor(UIColor.black, for: .normal)
        length15min.setTitleColor(UIColor.black, for: .normal)
        length20min.setTitleColor(UIColor.black, for: .normal)
        length25min.setTitleColor(UIColor.black, for: .normal)
        length30min.setTitleColor(UIColor.white, for: .normal)
    }
    @IBAction func beginner(_ sender: Any) {
        levelWorkout = "beginner"
        beginner.backgroundColor = UIColor.black
        intermediate.backgroundColor = UIColor.white
        advance.backgroundColor = UIColor.white
        
        beginner.setTitleColor(UIColor.white, for: .normal)
        intermediate.setTitleColor(UIColor.black, for: .normal)
        advance.setTitleColor(UIColor.black, for: .normal)
    }
    @IBAction func intermediate(_ sender: Any) {
        levelWorkout = "intermediate"
        beginner.backgroundColor = UIColor.white
        intermediate.backgroundColor = UIColor.black
        advance.backgroundColor = UIColor.white
        
        beginner.setTitleColor(UIColor.black, for: .normal)
        intermediate.setTitleColor(UIColor.white, for: .normal)
        advance.setTitleColor(UIColor.black, for: .normal)
    }
    @IBAction func advance(_ sender: Any) {
        levelWorkout = "advance"
        beginner.backgroundColor = UIColor.white
        intermediate.backgroundColor = UIColor.white
        advance.backgroundColor = UIColor.black
        
        beginner.setTitleColor(UIColor.black, for: .normal)
        intermediate.setTitleColor(UIColor.black, for: .normal)
        advance.setTitleColor(UIColor.white, for: .normal)
    }
    @IBAction func handleCategory(_ sender: Any) {
        popupView.isHidden = false
        categoryView.isHidden = false
        workoutTypeView.isHidden = true
        
    }
    @IBAction func handleWorkoutType(_ sender: Any) {
        popupView.isHidden = false
        categoryView.isHidden = true
        workoutTypeView.isHidden = false
        
    }
    func getThumbnailFrom(path: URL) -> UIImage? {
        
        do {
            
            let asset = AVURLAsset(url: path , options: nil)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            imgGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(0, 1), actualTime: nil)
            let thumbnail = UIImage(cgImage: cgImage)
            
            return thumbnail
            
        } catch let error {
            
            print("*** Error generating thumbnail: \(error.localizedDescription)")
            return nil
            
        }
        
    }
    func uploadImageToFirebase(image : UIImage) {
        let imageName = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child("workout_preview_thumbnails").child("\(imageName).jpg")
        //if let uploadData = UIImagePNGRepresentation(self.profileImage.image!)
        if let uploadData = UIImageJPEGRepresentation(image, 0.80){
            storageRef.putData(uploadData, metadata: nil, completion: { (metadata, err) in
                if err != nil {
                    print(err ?? "")
                    return
                }
                self.previewthumbnailUrl = (metadata?.downloadURL()?.absoluteString)!
                
                
                print(metadata ?? "")
            })
        }
    }
    func uploadVideo(videourl : URL){
        SVProgressHUD.show()
        let videoName = "\(UUID().uuidString).mov"
        let uploadTask = Storage.storage().reference().child("workout_preview_videos").child(videoName).putFile(from: videourl, metadata: nil, completion: { (metadata, err) in
            if err != nil{
                print(err ?? "")
                return
            }
            self.previewVideoUrl = (metadata?.downloadURL()?.absoluteString)!
        })
        uploadTask.observe(.progress, handler: { (snapshot) in
            
        })
        uploadTask.observe(.success, handler: { (snaphot) in
            SVProgressHUD.dismiss()        })
    }

    
}
extension TrainerCreateWorkoutAfterVideoVC : UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        workoutTitle.text = ""
    }
}
extension TrainerCreateWorkoutAfterVideoVC : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let videoUrl = info[UIImagePickerControllerMediaURL] as? URL {
            self.dismiss(animated: true, completion: nil)
           // previewVideoUrl = videoUrl
            uploadVideo(videourl: videoUrl)
            uploadImageToFirebase(image: getThumbnailFrom(path: videoUrl)!)
            
            
        }
    }
}
