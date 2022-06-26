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
            view.backgroundColor = .white
            configureViewControllers()
        }
    }
    
    func configureViewControllers() {
        let viewmodel = ChildViewModel(imageData: UserDefaults.standard.integer(forKey: "childDataImage"))
        
        let task = TaskController()
        let imageTask = UIImage(named: "task.icon.gray")
        let imageTask2 = UIImage(named: "task.icon.green")
        let nav1 = templateNavigationController(deselectImage: imageTask, selectImage: imageTask2, rootViewController: task)
        nav1.title = "Task"
        
        let reward = RewardController()
        let imageReward =  UIImage(named: "reward.icon.gray")
        let imageReward2 = UIImage(named: "reward.icon.green")
        let nav2 = templateNavigationController(deselectImage: imageReward, selectImage: imageReward2, rootViewController: reward)
        nav2.title = "Reward"
        
        let profile = ProfileController()
        // tarik image
        let profileImage = UIImage(named: viewmodel.profileImageChild)
        let targetSize = CGSize(width: 30, height: 30)

        let scaledImage = profileImage!.scalePreservingAspectRatio(
            targetSize: targetSize
        )
        
        let nav3 = templateNavigationController(deselectImage: scaledImage, selectImage: scaledImage, rootViewController: profile)
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
    
    
    func templateNavigationController(deselectImage: UIImage?, selectImage: UIImage?,
                                      rootViewController: UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = deselectImage!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        nav.tabBarItem.selectedImage = selectImage!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        return nav
    }
}
