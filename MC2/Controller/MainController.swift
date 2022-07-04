//
//  MainController.swift
//  MC2
//
//  Created by Renzo Alvaroshan on 09/06/22.
//  Fix

import Firebase
import UIKit
import UserNotifications

class MainController: UITabBarController, UIGestureRecognizerDelegate {
    
    //MARK: - Properties
    
    var childUID = [String]()
    let notification = UNUserNotificationCenter.current()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        AuthenticateAndPresentLoginController()
    }
    
    // MARK: - Selectors
    
    @objc func profileLongPressed(gestureRecognizer: UILongPressGestureRecognizer) {
       
        
        let rootVC = SelectChildCollectionView()
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .pageSheet
        present(navVC, animated: true) {
            Utilities().vibrate(for: .warning)
            navVC.presentationController?.presentedView?.gestureRecognizers?[0].isEnabled = false
        }
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
            view.backgroundColor = .white
            Task.init(operation: {
                self.showLoader(true)
                guard let uid = Auth.auth().currentUser?.uid else { return }
                let childUID = try await Service.fetchChildUID(uid:uid)
                
                if childUID.isEmpty {
                    print("DEBUG: gaada anak nihhh main")
                    DispatchQueue.main.async {
                        let nav = UINavigationController(rootViewController: AddChildControllerInitial())
                        nav.modalPresentationStyle = .fullScreen
                        nav.isNavigationBarHidden = true
                        self.present(nav, animated: true)
                    }
                    self.showLoader(false)
                } else {
                    self.showLoader(false)
                    notification.requestAuthorization(options: [.alert, .sound, .badge]) { permissionGranted, error in
                        self.addNotification()
                    }
                    configureViewControllers()
                }
            })
        }
    }
    
    func addNotification() {
        
        let content = UNMutableNotificationContent()
        content.title = "Hey, you remember right?"
        content.body = "Don't forget to remind your kids and track their progress everyday!"
        
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        
        dateComponents.hour = 20
        // Create the trigger as a repeating event.
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents, repeats: true)
        
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,
                                            content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if error != nil {
                // Handle any errors.
            }
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
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(profileLongPressed))
        longPressRecognizer.delegate = self
        tabBar.addGestureRecognizer(longPressRecognizer)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: tabBar.subviews[3]) == true {return true}
        return false
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
