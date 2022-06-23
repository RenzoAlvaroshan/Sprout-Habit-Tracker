//
//  RegistrationController.swift
//  MC2
//
//  Created by Renzo Alvaroshan on 09/06/22.
//

import UIKit
import Firebase

class RegistrationController: UIViewController, RegisterCardViewDelegate {
    
    //MARK: - Properties
    
    private let cardView = RegisterCardView()
    
    private let popUpView = AuthPopUpView()
    
    private let iconImageView: UIImageView = {
        let iv = UIImageView()
        let image = UIImage(named: "ecobit.icon")?.withRenderingMode(.alwaysTemplate)
        iv.image = image
        iv.tintColor = .white
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
    
    func handleRegisterButton() {
        guard let email = cardView.emailTextField.text else { return }
        guard let password = cardView.passwordTextField.text else { return }
        var childID = Array<String>()
        
        let credentials = AuthCredentials(email: email, password: password, childID: childID)
        
//        AuthService.registerUser(withCredentials: credentials) { error in
//            if let error = error {
//                return
//            } else {
//                self.navigationController?.pushViewController(AddChildController(), animated: true)
//            }
//        }
        
        Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result, error) in
            if let error = error {
                print("DEBUG: Error signing up \(error.localizedDescription)")
                RegistrationController().showPopUp()
                return
            }
            
            guard let uid = result?.user.uid else { return }
            
            let data = ["email": credentials.email,
                        "uid": uid,
                        "childId": credentials.childID] as [String : Any]
            
//            COLLECTION_USERS.document(uid).setData(data, completion: completion)
            COLLECTION_USERS.addDocument(data: data, completion: nil)
        }

    }
    
    func handleShowLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    func configureUI() {
        view.backgroundColor = .arcadiaGreen
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        view.addSubview(iconImageView)
        iconImageView.centerX(inView: view)
        iconImageView.setDimensions(height: 60, width: 60)
        iconImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        view.addSubview(cardView)
        cardView.setDimensions(height: view.frame.height * 0.7, width: view.frame.width)
        cardView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }
    
    func showPopUp() {
        
        view.addSubview(popUpView)
        popUpView.messageBody = "Wrong email or password format!"
        popUpView.centerX(inView: view)
        popUpView.setDimensions(height: 40, width: view.frame.width - 40)
        popUpView.centerYAnchor.constraint(equalTo: view.bottomAnchor, constant: 60).isActive = true
        popUpView.layer.cornerRadius = 10
        
        UIView.animate(withDuration: 0.5) {
            self.popUpView.transform = CGAffineTransform(translationX: 0, y: -110)
            Utilities().vibrate(for: .error)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            UIView.animate(withDuration: 0.5) {
                self.popUpView.transform = CGAffineTransform(translationX: 0, y: 120)
            }
        }
    }
}
