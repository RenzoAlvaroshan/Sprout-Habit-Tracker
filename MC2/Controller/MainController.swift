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
    
    var childUID = [String]()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        AuthenticateAndPresentLoginController()
    }
    
    //MARK: - Helpers
    
    func AuthenticateAndPresentLoginController() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true)
            }
        } else {
            guard let uid = Auth.auth().currentUser?.uid else { return }
            // jalanin loading animation
            view.backgroundColor = .arcadiaGreen
            // baru fetch data
            showLoader(true)
            
            Task.init(operation: {
                let childUID = try await Service.fetchChildUID(uid:uid)
                let currentChildUid = childUID[UserDefaults.standard.integer(forKey: "childRef")]
                let childData = try await Service.fetchChildData(childUid: currentChildUid)
                
                UserDefaults.standard.set(currentChildUid, forKey: "childCurrentUid")
                UserDefaults.standard.set(childData.name, forKey: "childDataName")
                UserDefaults.standard.set(childData.profileImage, forKey: "childDataImage")
                UserDefaults.standard.set(childData.experience, forKey: "childDataExperience")
                
                configureUI()
                configureViewControllers()
                showLoader(false)
            })
            
        }
       
    }
    
    func configureUI() {
        view.backgroundColor = .arcadiaGreen
    }
    
    func configureViewControllers() {
        let task = TaskController()
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
    
    func presentLoginController() {
        DispatchQueue.main.async {
            let controller = LoginController()
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true)
        }
    }
    
    
    func templateNavigationController(image: UIImage?,
                                      rootViewController: UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        return nav
    }
}
