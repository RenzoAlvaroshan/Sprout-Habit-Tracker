//
//  LoginController.swift
//  MC2
//
//  Created by Renzo Alvaroshan on 09/06/22.
//

import UIKit
import Firebase

class LoginController: UIViewController, LoginCardViewDelegate {
    
    //MARK: - Properties
    var childUID = [String]()
    
    private let cardView = LoginCardView()
    
    private let popUpView = AuthPopUpView()
    
    private let iconImageView: UIImageView = {
        let iv = UIImageView()
        let image = UIImage(named: "ecobit.icon")?.withRenderingMode(.alwaysTemplate)
        iv.image = image
        iv.tintColor = .white
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private let background: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "loginBG")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardView.delegate = self
        
        configureUI()
    }
    
    //MARK: - Selectors
    
    
    
    //MARK: - Helpers
    
    func handleLoginButton() {
        guard let email = cardView.emailTextField.text else { return }
        guard let password = cardView.passwordTextField.text else { return }
        
        AuthService.logUserIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("DEBUG: Error logging user in \(error.localizedDescription)")
                self.view.addSubview(self.popUpView)
                self.popUpView.messageBody = "Oops, wrong email or password!"
                self.popUpView.centerX(inView: self.view)
                self.popUpView.setDimensions(height: 40, width: self.view.frame.width - 40)
                self.popUpView.centerYAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 60).isActive = true
                self.popUpView.layer.cornerRadius = 10
                
                UIView.animate(withDuration: 0.5) {
                    self.popUpView.transform = CGAffineTransform(translationX: 0, y: -110)
                    Utilities().vibrate(for: .error)
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    UIView.animate(withDuration: 0.5) {
                        self.popUpView.transform = CGAffineTransform(translationX: 0, y: 120)
                    }
                }
                return
            } else {
                Task.init(operation: {
                    self.showLoader(true)
                    guard let uid = Auth.auth().currentUser?.uid else { return }
                    let childUID = try await Service.fetchChildUID(uid:uid)
                    
                    if childUID.isEmpty {
                        print("DEBUG: gaada anak nihhh")
                        self.navigationController?.pushViewController(AddChildControllerInitial(), animated: true)
                    } else {
                        if childUID.count == 1{
                            print("DEBUG: jumlah anak ada: \(childUID.count)")
                            let currentChildUid = childUID[0]
                            let childData = try await Service.fetchChildData(childUid: currentChildUid)
                            
                            UserDefaults.standard.set(0, forKey: "childRef")
                            UserDefaults.standard.set(currentChildUid, forKey: "childCurrentUid")
                            UserDefaults.standard.set(childData.name, forKey: "childDataName")
                            UserDefaults.standard.set(childData.profileImage, forKey: "childDataImage")
                            UserDefaults.standard.set(childData.experience, forKey: "childDataExperience")
                            
                            self.navigationController?.pushViewController(MainController(), animated: true)
                            self.showLoader(false)
                        }
                        else { // go to picker
                            print("DEBUG: jumlah anak lebih dari 1, \(childUID.count)")
                            let rootVC = SelectChildAfterLoginVC()
                            let navVC = UINavigationController(rootViewController: rootVC)
                            navVC.modalPresentationStyle = .overFullScreen
                            self.present(navVC, animated: true) {
                            navVC.presentationController?.presentedView?.gestureRecognizers?[0].isEnabled = false
                            }
                        }
                    }
                })
            }
        }
    }
    
    func handleShowRegistration() {
        navigationController?.pushViewController(RegistrationController(), animated: true)
    }
    
    func configureUI() {
        view.backgroundColor = .arcadiaGreen
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        view.addSubview(background)
        background.centerX(inView: view)
        background.centerY(inView: view)
        background.setDimensions(height: view.frame.height, width: view.frame.width)
        
        view.addSubview(iconImageView)
        iconImageView.centerX(inView: view)
        iconImageView.setDimensions(height: 60, width: 60)
        iconImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 60)
        
        view.addSubview(cardView)
        cardView.setDimensions(height: view.frame.height * 0.7, width: view.frame.width)
        cardView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }
}
