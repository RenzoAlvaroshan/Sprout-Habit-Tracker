//
//  AuthService.swift
//  MC2
//
//  Created by Renzo Alvaroshan on 20/06/22.
//

import Firebase
import UIKit

struct AuthCredentials {
    let email: String
    let password: String
    
}

struct AuthService {
    
    static func logUserIn(withEmail email: String, password: String,
                          completion: ((AuthDataResult?, Error?) -> Void)?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    static func registerUser(withCredentials credentials: AuthCredentials,
                             completion: @escaping((Error?) -> Void)) {
        Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result, error) in
            if let error = error {
                print("DEBUG: Error signing up")
                RegistrationController().showPopUp()
                return
            }
            
            guard let uid = result?.user.uid else { return }
            
            let data = ["email": credentials.email,
                        "uid": uid]
            
            COLLECTION_USERS.document(uid).setData(data, completion: completion)
        }
    }
}
