//
//  ShareAppVC.swift
//  Flive
//
//  Created by mac for ios on 3/14/18.
//  Copyright © 2018 mac for ios. All rights reserved.
//

import UIKit

class ShareAppVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var shareView: UICollectionView!
    
    let shareImages = [#imageLiteral(resourceName: "share_fb"),#imageLiteral(resourceName: "share_twitter"),#imageLiteral(resourceName: "share_instagram"),#imageLiteral(resourceName: "share_whatsapp"),#imageLiteral(resourceName: "share_txt"),#imageLiteral(resourceName: "share_email")]
    let shareLbl = ["Facebook","Twitter","Instagram","WhatsApp","Text Message","Email"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return shareImages.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShareAppCell", for: indexPath) as! ShareAppCell
        cell.ImageCell.image = shareImages[indexPath.row]
        cell.Lbl.text = shareLbl[indexPath.row]
        return cell
    }
}
