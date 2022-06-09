//
//  AuthenticationViewModel.swift
//  MC2
//
//  Created by Renzo Alvaroshan on 09/06/22.
//

import UIKit

protocol AuthenticationViewModel {
    var formIsValid: Bool { get }
}

struct LoginViewModel: AuthenticationViewModel {
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
}

struct RegisterViewModel: AuthenticationViewModel {
    var email: String?
    var fullName: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && fullName?.isEmpty == false && password?.isEmpty == false
    }
}

