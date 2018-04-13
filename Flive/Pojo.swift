//
//  Pojo.swift
//  Flive
//
//  Created by Gurtej Singh on 02/04/18.
//  Copyright © 2018 mac for ios. All rights reserved.
//

import Foundation
import UIKit
class Workouts: NSObject {
    var level_of_workout : String?
    var trainer_id : String?
    var workout_category : String?
    var workout_length : String?
    var workout_thumbnail_url : String?
    var workout_time : NSNumber?
    var workout_title : String?
    var workout_video_url : String?
    var preferred_workouts : String?
    var workout_preview_video_url : String?
    var workout_preview_thumbnail_url : String?
}
class TrainerDetail: NSObject {
    var city : String?
    var address1 : String?
    var name : String?
    var address2 : String?
    var mobile : String?
    var code : String?
    var age : String?
    var gender : String?
    var imageUrl : String?
    var type : String?
    var bio : String?
    var country : String?
}
class UserDetail: NSObject {
    
}
