//
//  MainController.swift
//  MC2
//
//  Created by Renzo Alvaroshan on 09/06/22.
//  Fix

import Firebase
import UIKit

class MainController: UITabBarController {
    
    //MARK: - Properties
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureViewControllers()
        
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .arcadiaGreen
    }
    
    func configureViewControllers() {
        let task = TaskController()
//        let task = ActivityController()
        let nav1 = templateNavigationController(image: UIImage(named: "task.icon.gray"), rootViewController: task)
        nav1.title = "Task"
        
        let reward = RewardController()
        let nav2 = templateNavigationController(image: UIImage(named: "reward.icon.gray"), rootViewController: reward)
        nav2.title = "Reward"
        
        let profile = ProfileController()
        let nav3 = templateNavigationController(image: UIImage(named: "profile.icon.gray"), rootViewController: profile)
        nav3.title = "Profile"
        
        viewControllers = [nav1, nav2, nav3]
        tabBar.backgroundColor = .white
        tabBar.tintColor = .arcadiaGreen
    }
    
    
    func templateNavigationController(image: UIImage?,
                                      rootViewController: UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
//        nav.navigationBar.barTintColor = .white
        
        return nav
    }
}
