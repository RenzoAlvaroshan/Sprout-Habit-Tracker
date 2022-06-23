//
//  Service.swift
//  MC2
//
//  Created by Renzo Alvaroshan on 23/06/22.
//

import Firebase
import UIKit

struct Service {
    
    static func saveChildData(child: Child, completion: @escaping(Error?) -> Void) {
        
        let data = ["name": child.name,
                    "childId": child.childID] as [String : Any]
        
        COLLECTION_CHILD.addDocument(data: data)
    }
}
