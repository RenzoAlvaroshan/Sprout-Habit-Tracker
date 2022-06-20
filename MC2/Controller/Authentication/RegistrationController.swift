//
//  RegistrationController.swift
//  MC2
//
//  Created by Renzo Alvaroshan on 09/06/22.
//

import UIKit

class RegistrationController: UIViewController, RegisterCardViewDelegate {
    
    //MARK: - Properties
    
    private let cardView = RegisterCardView()
    
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
        
        let credentials = AuthCredentials(email: email, password: password)
        
        AuthService.registerUser(withCredentials: credentials) { error in
            if let error = error {
                print("DEBUG: Error signing user up \(error.localizedDescription)")
                return
            } else {
                self.navigationController?.pushViewController(AddChildController(), animated: true)
            }
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
}
