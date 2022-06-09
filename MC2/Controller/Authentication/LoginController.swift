//
//  LoginController.swift
//  MC2
//
//  Created by Renzo Alvaroshan on 09/06/22.
//

import UIKit

class LoginController: UIViewController {
    
    //MARK: - Properties
    
    private let cardView = CardView()
    
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
        configureUI()
    }
    
    //MARK: - Selectors
    
    
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .arcadiaGreen
        
        view.addSubview(iconImageView)
        iconImageView.centerX(inView: view)
        iconImageView.setDimensions(height: 60, width: 60)
        iconImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        view.addSubview(cardView)
        cardView.setDimensions(height: view.frame.height * 0.7, width: view.frame.width)
        cardView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }
}
