//
//  LoadingViewController.swift
//  MC2
//
//  Created by Kevin Harijanto on 23/06/22.
//

import UIKit
import Firebase

class LoadingViewController: UIViewController {
    
    private var isOnboardingSeen: Bool!
    private let navigationManager = NavigationManager()
    private let onboardingManager = OnboardingManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isOnboardingSeen = onboardingManager.isOnboardingSeen()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showInitialScreen()
    }
    
    private func showInitialScreen() {
        // If onboarding seen -> Login
        if isOnboardingSeen {
            checkIfUserLoggedIn()
        // If onboarding not seed -> Show Onboarding
        } else {
            navigationManager.show(screen: .showOnboarding, inController: self)
        }
    }
    
    func checkIfUserLoggedIn() {
        if Auth.auth().currentUser == nil {
           print("DEBUG: No user logged in")
            presentLoginController()
        } else {
            print("DEBUG: User already logged in")
            let rootVC = MainController()
            let navVC = UINavigationController(rootViewController: rootVC)
            navVC.modalPresentationStyle = .fullScreen
            present(navVC, animated: true)
        }
    }
    
    func presentLoginController() {
        DispatchQueue.main.async {
            let controller = LoginController()
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true)
        }
    }
}
