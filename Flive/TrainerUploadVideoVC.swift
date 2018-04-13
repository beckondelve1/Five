//
//  TrainerUploadVideoVC.swift
//  Flive
//
//  Created by iosteam on 3/29/18.
//  Copyright © 2018 mac for ios. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase
import SVProgressHUD
class TrainerUploadVideoVC: UIViewController {
    @IBOutlet weak var btnContinue: UIButton!
    @IBOutlet weak var imgTick: UIImageView!
    @IBOutlet weak var lblUploading: UILabel!
    @IBOutlet weak var videoPreview: UIImageView!
      @IBOutlet weak var videoProgressBar: UIProgressView!
    var videoUrl : URL?
    var videoSize : Data?
    var storageUrl : String?
    var thumbnailUrl : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        btnContinue.isEnabled = false
        videoProgressBar.setProgress(0, animated: true)
        if videoUrl != nil{
            videoPreview.image = getThumbnailFrom(path: videoUrl!)
            do{
                 videoSize = try Data(contentsOf: videoUrl!)
            }
            catch{
            }
            uploadVideo(videourl: videoUrl!)
            uploadImageToFirebase(image: getThumbnailFrom(path: videoUrl!)!)
        }
    }
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func handleContinue(_ sender: Any) {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TrainerCreateWorkoutAfterVideoVC") as! TrainerCreateWorkoutAfterVideoVC
                        vc.videoUrl = storageUrl
                        vc.thumbnailURL = thumbnailUrl
                        self.navigationController?.pushViewController(vc, animated: false)
        
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
        let storageRef = Storage.storage().reference().child("workout_thumbnails").child("\(imageName).jpg")
        //if let uploadData = UIImagePNGRepresentation(self.profileImage.image!)
        if let uploadData = UIImageJPEGRepresentation(image, 0.80){
            storageRef.putData(uploadData, metadata: nil, completion: { (metadata, err) in
                if err != nil {
                    print(err ?? "")
                    return
                }
                self.thumbnailUrl = metadata?.downloadURL()?.absoluteString
                
                
                print(metadata ?? "")
            })
        }
    }
    func uploadVideo(videourl : URL){
        let videoName = "\(UUID().uuidString).mov"
        let uploadTask = Storage.storage().reference().child("workout_videos").child(videoName).putFile(from: videourl, metadata: nil, completion: { (metadata, err) in
            if err != nil{
                print(err ?? "")
                return
            }
            self.storageUrl = metadata?.downloadURL()?.absoluteString
        })
        uploadTask.observe(.progress, handler: { (snapshot) in
            var mini = Int64(0)
            let max = Int64(self.videoSize!.count)
            if let completedUnitCount = snapshot.progress?.completedUnitCount{
                mini = mini + completedUnitCount
                let fractionalProgress = Float(mini) / Float(max)
                self.videoProgressBar.setProgress(fractionalProgress, animated: true)

                print(String(completedUnitCount))
            }
        })
        uploadTask.observe(.success, handler: { (snaphot) in
            self.imgTick.isHidden = false
            self.btnContinue.isEnabled = true
           self.lblUploading.text = "Uploaded Successfully!"
        })
    }
    func saveVideoUrlToFirebase(videoUrl: URL , storageUrl:String){
        print("videourl \(videoUrl)")
        print("storageUrl \(storageUrl)")
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
