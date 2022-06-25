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
    
    static func saveChildData(child: Child, completion: @escaping(Error?, String) -> Void) {
        
        let data = ["name": child.name,
                    "profile": child.profileImage,
                    "experience": child.experience] as [String : Any]
        
        var ref : DocumentReference? = nil
        ref = COLLECTION_CHILD.addDocument(data: data)
        // ambil document ID yang baru dibuat
        let childId = ref!.documentID
        // return 2 data, error dan UID child yang baru dibuat
        completion(Error.self as? Error, childId)
    }
    
    static func fetchChildUID(uid: String, completion: @escaping([String])->Void) {
        
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            
            if snapshot != nil && snapshot!.exists {
                guard let snapshotData = snapshot!.data() else {return}
                let childID = snapshotData["childId"] as? [String]
                let childIDSend = childID
                completion(childIDSend!)
            }
        }
    }
    
    static func fetchChildrenData (uid: String, childRef: Int, completion: @escaping([Child])->Void) {
        var children = [Child]()
        // ambil uid user
        
        fetchChildUID(uid: uid) { childID in
            let childCollection = COLLECTION_CHILD.document(childID[childRef])
            childCollection.getDocument { snapshot, error in
                let dictionary = snapshot!.data()
                let child = Child(dictionary: dictionary!)
                children.append(child)
                completion(children)
            }
        }
    }

    static func saveActivity (activity: Activity, childId: String, completion: @escaping(Error?, String) -> Void) {
        
        let data = ["activityName": activity.activityName,
                    "category": activity.category,
                    "isFinished": activity.isFinished] as [String : Any]
        
        var ref : DocumentReference? = nil
        ref = COLLECTION_CHILD.document(childId).collection("Activity").addDocument(data: data)
        // ambil document ID yang baru dibuat
        let activityId = ref!.documentID
        // return 2 data, error dan UID child yang baru dibuat
        completion(Error.self as? Error, activityId)
    }
    
    static func fetchActivity (uid: String, childRef: Int, completion: @escaping([Activity])->Void) {
        var activityArray = [Activity]()
        
        fetchChildUID(uid: uid) { childID in
            let activityCollection = COLLECTION_CHILD.document(childID[childRef]).collection("Activity").getDocuments(completion: { query, error in
                let queryDoc = query?.documents
                for i in 0..<queryDoc!.count {
                    let snapshot = queryDoc![i]
                    let activitySnapshot = snapshot.data()
                    let activity = Activity(dictionary: activitySnapshot)
                    activityArray.append(activity)
                }
                completion(activityArray)
            })
        }
    }
}
