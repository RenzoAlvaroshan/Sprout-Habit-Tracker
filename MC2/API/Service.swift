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
    
    static func fetchChildUID(uid: String) async throws -> [String] {
        do {
            let snapshot = try await COLLECTION_USERS.document(uid).getDocument()
            let childId = snapshot.data()!["childId"] as? [String]
            return childId!
            
        } catch {
            return []
        }
    }
    
    static func fetchChildData(childUid: String) async throws -> Child {
        do {
            let snapshot = try await COLLECTION_CHILD.document(childUid).getDocument()
            let dictionary = snapshot.data()
            let childData = Child(dictionary: dictionary!)
            return childData
        } 
    }
    
    static func fetchAllChild(uid: String) async throws -> [Child] {
        do {
            var children = [Child]()
            
            let childUID = try await fetchChildUID(uid: uid)
            
            for i in 0..<childUID.count {
                let childuid = childUID[i]
                
                let childData = try await Service.fetchChildData(childUid: childuid)
                children.append(childData)
            }
            return children
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

    
    static func fetchActivity(childUid: String) async throws -> [Activity] {
        do {
            var activityArray = [Activity]()
            
            let query = try await COLLECTION_CHILD.document(childUid).collection("Activity").getDocuments()
            let queryDoc = query.documents
            for i in 0..<queryDoc.count {
                let snapshot = queryDoc[i]
                let activitySnapshot = snapshot.data()
                let activity = Activity(dictionary: activitySnapshot)
                activityArray.append(activity)
            }
            return activityArray
        }
    }
    
    static func updateActivityState (ref: Int, completion: @escaping(Error?) -> Void) {
        
        let childUID = UserDefaults.standard.string(forKey: "childCurrentUid")
        
        COLLECTION_CHILD.document(childUID!).collection("Activity").addSnapshotListener { snapshot, error in
            if snapshot != nil {

                guard let documentID = snapshot?.documents[ref].documentID else { return }
                
                let updateReference = COLLECTION_CHILD.document(childUID!).collection("Activity").document(documentID)
                
                updateReference.updateData(["isFinished": true])
            }
        }
    }
    // Reset all activity to False
    static func resetActivityState (completion: @escaping(Error?) -> Void) {
        
        let childUID = UserDefaults.standard.string(forKey: "childCurrentUid")
        
        COLLECTION_CHILD.document(childUID!).collection("Activity").addSnapshotListener { snapshot, error in
            if snapshot != nil {
                for i in 0..<snapshot!.count {
                    guard let documentID = snapshot?.documents[i].documentID else { return }
                    
                    let updateReference = COLLECTION_CHILD.document(childUID!).collection("Activity").document(documentID)
                    
                    updateReference.updateData(["isFinished": false])
                }
            }
        }
    }
    
    static func updateProfileData (name: String, profile: Int, completion: @escaping(Error?)->Void) {
        guard let childUID = UserDefaults.standard.string(forKey: "childCurrentUid") else { return }
        
        let updateReference = COLLECTION_CHILD.document(childUID)
        updateReference.updateData(["name": name, "profile": profile])
    }
    
    static func updateExperience (experience: Int, completion: @escaping(Error?)->Void) {
        guard let childUID = UserDefaults.standard.string(forKey: "childCurrentUid") else { return }
        
        let updateReference = COLLECTION_CHILD.document(childUID)
        updateReference.updateData(["experience": experience])
    }
}
