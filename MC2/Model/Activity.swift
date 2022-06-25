//
//  Activity.swift
//  MC2
//
//  Created by Kevin Harijanto on 25/06/22.
//

import Foundation

struct Activity {
    var activityName: String
    var category: String
    var isFinished: Bool
    
    init(dictionary: [String: Any]) {
        self.activityName = dictionary["activityName"] as? String ?? ""
        self.category = dictionary["category"] as? String ?? ""
        self.isFinished = dictionary["isFinished"] as? Bool ?? false
    }
}

