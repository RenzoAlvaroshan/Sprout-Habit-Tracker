//
//  TaskViewModel.swift
//  MC2
//
//  Created by Kevin Harijanto on 27/06/22.
//

import Foundation
import UIKit

struct TaskViewModel {
    
    let imageData: Bool
    
    var taskComplete: UIColor {
        
        let profileImage = imageData
        
        switch profileImage {
        case false:
            return .systemGray4
        case true:
            return .arcadiaGreen
        }
    }
}

