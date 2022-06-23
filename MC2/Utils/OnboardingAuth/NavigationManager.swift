//
//  NavigationManager.swift
//  MC2
//
//  Created by Kevin Harijanto on 23/06/22.
//

import UIKit

class NavigationManager {
    
    enum Screen {
        case showOnboarding
        case showMain
    }
    
    func show(screen: Screen, inController: UIViewController) {
        
        var viewController: UIViewController!
        
        switch screen {
        case .showOnboarding:
            viewController = OnboardingViewContainer()
        case .showMain:
            viewController = MainController()
        }
        
        if let sceneDelegate = inController.view.window?.windowScene?.delegate as? SceneDelegate, let window = sceneDelegate.window {
            window.rootViewController = viewController
            UIView.transition(with: window, duration: 0.5, animations: nil)
        }
        
    }
    
}
