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
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let data = ["uid": uid,
                    "name": child.name] as [String: Any]
        
        COLLECTION_CHILD.document(uid).setData(data, completion: completion)
    }
    
}
