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
    var childID: [String]
}

struct AuthService {
    
    static func logUserIn(withEmail email: String, password: String,
                          completion: ((AuthDataResult?, Error?) -> Void)?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }

}
