//
//  VideoPlayer.swift
//  Flive
//
//  Created by iosteam on 3/27/18.
//  Copyright © 2018 mac for ios. All rights reserved.
//


import UIKit
import AVFoundation
import Firebase

class VideoPlayer: UIViewController {
    
    @IBOutlet weak var videoView: UIView!
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    var videoURL : URL!
    var isVideoPlaying = false
    var maxLimit : Float!
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //maxLimit = 0
        self.checkUserPlan()
        //let url = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")!
        player = AVPlayer(url: videoURL)
        player.currentItem?.addObserver(self, forKeyPath: "duration", options: [.new, .initial], context: nil)
        addTimeObserver()
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resize
        
        videoView.layer.addSublayer(playerLayer)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer.frame = videoView.bounds
    }
    
    func addTimeObserver() {
        let interval = CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        let mainQueue = DispatchQueue.main
        _ = player.addPeriodicTimeObserver(forInterval: interval, queue: mainQueue, using: { [weak self] time in
            guard let currentItem = self?.player.currentItem else {return}
            if self?.maxLimit != nil{
                if Float(currentItem.currentTime().seconds) >= (self?.maxLimit)!{
                    self?.player.pause()
                    self?.showAlert()
                }
            }
           
            self?.timeSlider.maximumValue = Float(currentItem.duration.seconds)
            self?.timeSlider.minimumValue = 0
            self?.timeSlider.value = Float(currentItem.currentTime().seconds)
            self?.currentTimeLabel.text = self?.getTimeString(from: currentItem.currentTime())
        })
    }
    @IBAction func backPressed(_ sender: UIButton) {
      //  dismiss(animated: true, completion: nil)
      //  self.navigationController?.popViewController(animated: true)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserVC") as! UserVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func playPressed(_ sender: UIButton) {
        if isVideoPlaying {
            player.pause()
            sender.setTitle("Play", for: .normal)
        }else {
            player.play()
            sender.setTitle("Pause", for: .normal)
        }
        
        isVideoPlaying = !isVideoPlaying
    }
    
    @IBAction func forwardPressed(_ sender: Any) {
        guard let duration = player.currentItem?.duration else {return}
        let currentTime = CMTimeGetSeconds(player.currentTime())
        let newTime = currentTime + 5.0
        
        if newTime < (CMTimeGetSeconds(duration) - 5.0) {
            let time: CMTime = CMTimeMake(Int64(newTime*1000), 1000)
            player.seek(to: time)
        }
    }
    
    @IBAction func backwardsPressed(_ sender: Any) {
        let currentTime = CMTimeGetSeconds(player.currentTime())
        var newTime = currentTime - 5.0
        
        if newTime < 0 {
            newTime = 0
        }
        let time: CMTime = CMTimeMake(Int64(newTime*1000), 1000)
        player.seek(to: time)
    }
    
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        player.seek(to: CMTimeMake(Int64(sender.value*1000), 1000))
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "duration", let duration = player.currentItem?.duration.seconds, duration > 0.0 {
            self.durationLabel.text = getTimeString(from: player.currentItem!.duration)
        }
    }
    
    func getTimeString(from time: CMTime) -> String {
        let totalSeconds = CMTimeGetSeconds(time)
        let hours = Int(totalSeconds/3600)
        let minutes = Int(totalSeconds/60) % 60
        let seconds = Int(totalSeconds.truncatingRemainder(dividingBy: 60))
        if hours > 0 {
            return String(format: "%i:%02i:%02i", arguments: [hours,minutes,seconds])
        }else {
            return String(format: "%02i:%02i", arguments: [minutes,seconds])
        }
    }
    func showAlert(){
        let refreshAlert = UIAlertController(title: "Alert", message: "Upgrade your plan to watch complete video", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Upgrade", style: .default, handler: { (action: UIAlertAction!) in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserSubscriptionVC") as! UserSubscriptionVC
            self.navigationController?.pushViewController(vc, animated: true)
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserVC") as! UserVC
            self.navigationController?.pushViewController(vc, animated: true)
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
    func checkUserPlan(){
        if let uid = Auth.auth().currentUser?.uid{
            let ref = Database.database().reference()
            ref.child(uid).observeSingleEvent(of: .value, with: { (snap) in
                let snapshot = snap.value as! [String:Any]
                let plan = snapshot["plan"]! as! String
                if plan  == "basic"{
                    self.maxLimit = 10
                
                    
                }
                else if plan  == "popular"{
                   self.maxLimit = 20
                    
                }
                else{
                    self.maxLimit = 30
                }
            }, withCancel: nil)
        }
    }
}


