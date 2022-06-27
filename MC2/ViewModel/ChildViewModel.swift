//
//  ChildViewModel.swift
//  MC2
//
//  Created by Kevin Harijanto on 25/06/22.
//

import Foundation

struct ChildViewModel {
    let imageData: Int
    
    var profileImageChild: String {
        
        let profileImage = imageData
        
        switch profileImage {
        case 0:
            return "ava1_f"
        case 1:
            return "ava2_f"
        case 2:
            return "ava3_f"
        case 3:
            return "ava1_m"
        case 4:
            return "ava2_m"
        case 5:
            return "ava3_m"
        default:
            return "ava1_f"
        }
    }
}
