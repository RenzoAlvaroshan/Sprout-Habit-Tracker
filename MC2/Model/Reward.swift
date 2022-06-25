//
//  Reward.swift
//  MC2
//
//  Created by Kevin Harijanto on 25/06/22.
//

import Foundation

struct Reward {
    var rewardName: String
    var isClaimed: Bool
    
    init(dictionary: [String: Any]) {
        self.rewardName = dictionary["rewardName"] as? String ?? ""
        self.isClaimed  = dictionary["isClaimed"] as? Bool ?? false
    }
}
