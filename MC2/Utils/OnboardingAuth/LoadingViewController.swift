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
    
    var rootVC = UIViewController()
    
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
            
            if Auth.auth().currentUser == nil {
               print("DEBUG: No user logged in")
               rootVC = LoginController()
            } else {
                print("DEBUG: User already logged in")
                rootVC = MainController()
            }
            
            let navVC = UINavigationController(rootViewController: rootVC)
            navVC.modalPresentationStyle = .fullScreen
            navVC.setNavigationBarHidden(true, animated: true)
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
