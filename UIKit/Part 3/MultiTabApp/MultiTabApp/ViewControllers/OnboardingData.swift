//
//  OnboardingData.swift
//  MultiTabApp
//
//  Created by Artur Harutyunyan on 15.06.25.
//


import Foundation

class OnboardingData {
    var fullName: String
    var phoneNumber: String
    var preference: String
    
    init(fullName: String = "", phoneNumber: String = "", preference: String = "") {
        self.fullName = fullName
        self.phoneNumber = phoneNumber
        self.preference = preference
    }
    
}
