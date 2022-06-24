//
//  Service.swift
//  MC2
//
//  Created by Renzo Alvaroshan on 23/06/22.
//

import Firebase
import UIKit

struct Service {
    
    static let shared = Service()
    
    static func saveChildData(child: Child, completion: @escaping(Error?) -> Void) {
        
        let data = ["name": child.name,
                    "childId": child.childID] as [String : Any]
        
        COLLECTION_CHILD.addDocument(data: data)
    }
    
    static func fetchChildrenName (urutan: Int, completion: @escaping([String])->Void) {
        var children = [String]()
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            if snapshot != nil && snapshot!.exists {
                //get all document data
                guard let snapshotData = snapshot!.data() else {return}
                let element = snapshotData["childId"] as? [String]
                let childRef = element?[urutan]
                
                COLLECTION_CHILD.whereField("childId", isEqualTo: childRef as Any).getDocuments { snapshot, error in
                    for document in snapshot!.documents {
                        let childName = document["name"] as? String ?? ""
                        children.append(childName)
                        print("DEBUG: array of children in service \(children)")
                        completion(children)
                    }
                }
            }
        }
    }
}
    
    
//    static func fetchChildrenId (completion: @escaping([String])-> Void) {
//        var children = [String]()
//
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//
//        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
//            if snapshot != nil && snapshot!.exists {
//
//                //get all document data
//                guard let snapshotData = snapshot!.data() else {return}
//
//                //get value-array for key "childId"
//                if let element = snapshotData["childId"] as? [String] {
//
//                    for (_, nameid) in element.enumerated() {
//
//                        if nameid == "CcFHhz681q" {
//                            children.append( fetchChildName(childId: nameid) )
//                        }
//                    }
//                } //print -> Optional([id1, id2])
                //get first element in array, return child 0
//                guard let childRef = element?[0] as? String else {return}
//                children.append(childRef)
//            }
//        }
//        print("DEBUG: childREF: \(children)")
//    }
//}
//
//func fetchChildName(childId: String, completion: @escaping([Child])->Void) {// narik data nama child buat ditampilin
//    var children = [Child]()
//
//    COLLECTION_CHILD.whereField("childId", isEqualTo: childId).getDocuments { snapshot, error in
//        for document in snapshot!.documents {
//            let childname = Child(dictionary: <#T##[String : Any]#>)
//            let childName = document["name"] as? String ?? ""
//            children.append(childName)
//        }
//        print("DEBUG: Child Name: \(children)")
//    }
//}
