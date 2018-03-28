//
//  Functions.swift
//  Flive
//
//  Created by iosteam on 3/23/18.
//  Copyright © 2018 mac for ios. All rights reserved.
//


import Foundation
import UIKit
class Functions {
    func applyMotionEffect(toView view: UIView, magintude : Float) {
        let xMotion = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        xMotion.minimumRelativeValue = -magintude
        xMotion.maximumRelativeValue = magintude
        let yMotion = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        yMotion.minimumRelativeValue = -magintude
        yMotion.maximumRelativeValue = magintude
        
        let group = UIMotionEffectGroup()
        group.motionEffects = [xMotion,yMotion]
        view.addMotionEffect(group)
    }
    func showAlertWithoutAction(title : String, message : String, view : UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
            print("OK")
        }
        alertController.addAction(okAction)
        view.present(alertController, animated: true, completion: nil)
    }
    func showAlertWithoutActionWithDestination(title : String, message : String, view : UIViewController, Destination :String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
            let vc = view.storyboard?.instantiateViewController(withIdentifier: Destination)
            view.navigationController!.pushViewController(vc!, animated: true)
        }
        alertController.addAction(okAction)
        view.present(alertController, animated: true, completion: nil)
    }
   
}

