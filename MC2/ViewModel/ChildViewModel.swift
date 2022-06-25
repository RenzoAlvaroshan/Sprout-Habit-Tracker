//
//  ChildViewModel.swift
//  MC2
//
//  Created by Kevin Harijanto on 25/06/22.
//

import Foundation

struct ChildViewModel {
    
    let child: [Child]?
    
    var profileImageChild: String {
        let profileImage = child?[0].profileImage
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
            return "ava2_m"
            
        case .none:
            return "ava1_f"
        case .some(_):
            return "ava1_f"
        }
    }
}
