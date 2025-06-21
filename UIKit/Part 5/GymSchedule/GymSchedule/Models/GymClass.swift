//
//  GymClass.swift
//  GymSchedule
//
//  Created by Artur Harutyunyan on 21.06.25.
//

import UIKit

class GymClass {
    let className: String
    let time: String
    let date: String
    let weekday: String
    let duration: String
    let trainerName: String
    let trainerPhoto: String
    var isRegistered: Bool
    
    init(className: String, time: String, date: String, weekday: String, duration: String, trainerName: String, trainerPhoto: String, isRegistered: Bool) {
        self.className = className
        self.time = time
        self.date = date
        self.weekday = weekday
        self.duration = duration
        self.trainerName = trainerName
        self.trainerPhoto = trainerPhoto
        self.isRegistered = isRegistered
    }
}
