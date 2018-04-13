//
//  TrainerSettingVC.swift
//  Flive
//
//  Created by iosteam on 3/28/18.
//  Copyright © 2018 mac for ios. All rights reserved.
//

import UIKit
import Firebase

class TrainerSettingVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func SignOut(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            self.navigationController?.popToRootViewController(animated: true)
        }
        catch{
            
        }
    }
    

}
