//
//  Child.swift
//  MC2
//
//  Created by Renzo Alvaroshan on 23/06/22.
//

import Foundation

struct Child {
    var name: String
    var profileImage: Int
    
    init(dictionary: [String: Any]) {
        self.name = dictionary["name"] as? String ?? ""
        self.profileImage = dictionary["profile"] as? Int ?? 0
    }
}
