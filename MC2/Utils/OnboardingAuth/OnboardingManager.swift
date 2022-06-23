//
//  OnboardingManager.swift
//  MC2
//
//  Created by Kevin Harijanto on 23/06/22.
//

import Foundation

class OnboardingManager {
    
    enum Key: String {
        case onboardingSeen
    }
    
    func isOnboardingSeen() -> Bool {
        UserDefaults.standard.bool(forKey: Key.onboardingSeen.rawValue)
    }
    
    func setOnboardingSeen() {
        UserDefaults.standard.set(true, forKey: Key.onboardingSeen.rawValue)
    }
}
