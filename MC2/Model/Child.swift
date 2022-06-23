//
//  Child.swift
//  MC2
//
//  Created by Renzo Alvaroshan on 23/06/22.
//

import Foundation

struct Child {
    var name: String
    var childID: String
    
    init(dictionary: [String: Any]) {
        self.name = dictionary["name"] as? String ?? ""
        self.childID = dictionary["childID"] as? String ?? ""
    }
}
