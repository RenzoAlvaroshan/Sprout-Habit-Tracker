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
    
    let uid = Auth.auth().currentUser?.uid
    var childRef = UserDefaults.standard.object(forKey: "childRef")
    
    var child: [Child]? {
        didSet {
            guard let nav = viewControllers?[0] as? UINavigationController else { return }
            guard let task = nav.viewControllers.last as? TaskController else { return }
            
            task.child = child
            
            guard let nav = viewControllers?[2] as? UINavigationController else { return }
            guard let profile = nav.viewControllers.last as? ProfileController else { return }
            
            profile.child = child
        }
    }
    
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
            configureUI()
            fetchChildrenData()
            configureViewControllers()
        }
       
    }
    
    func fetchChildrenData() {
        
        Service.fetchChildrenData(uid: uid!, childRef: childRef as! Int, completion: { child in
            self.child = child
        })
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
//        nav.navigationBar.barTintColor = .white
        
        return nav
    }
}
