//
//  OnboardingController.swift
//  MC2
//
//  Created by Stephen Giovanni Saputra on 10/06/22.
//

import Foundation
import UIKit

class OnboardingController: UIViewController {
    
    //MARK: - Properties
    private let iconImageView: UIImageView = {
        let iv = UIImageView()
        let image = UIImage(named: "ecobit.icon")?.withRenderingMode(.alwaysTemplate)
        iv.image = image
        iv.tintColor = .arcadiaGreen
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private lazy var onboardingTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsBold(size: 23)
        label.text = "Plant Eco-friendly Habits"
        label.textColor = .arcadiaGreen
        return label
    }()
    
    private lazy var onboardingDesc: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsRegular(size: 18)
        label.text = "With Ecobit, we can help your kids to have eco-friendly habits in a fun and rewarding way"
        label.textColor = .arcadiaGreen
        label.numberOfLines = 3
        label.textAlignment = .center
        return label
    }()
    
    private lazy var getStartedButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.titleLabel?.font = UIFont.poppinsSemiBold(size: 15)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleNavigationButton), for: .touchUpInside)
        button.backgroundColor = .arcadiaGreen
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureUI()
    }

    //MARK: - Selectors
    @objc func handleNavigationButton() {
        
        let newViewController = LoginController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    //MARK: - Helpers
    func configureUI() {
        
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(iconImageView)
        iconImageView.centerX(inView: view)
        iconImageView.anchor(top: view.topAnchor, paddingTop: 200)
        
        view.addSubview(onboardingTitle)
        onboardingTitle.centerX(inView: view)
        onboardingTitle.anchor(top: iconImageView.bottomAnchor, paddingTop: 100)
        
        view.addSubview(onboardingDesc)
        onboardingDesc.centerX(inView: view)
        onboardingDesc.anchor(top: onboardingTitle.bottomAnchor, paddingTop: 35)
        onboardingDesc.setDimensions(height: 100, width: view.frame.width * 0.8)
        
        view.addSubview(getStartedButton)
        getStartedButton.centerX(inView: view)
        getStartedButton.anchor(bottom: view.bottomAnchor, paddingBottom: 115)
        getStartedButton.setDimensions(height: 50, width: view.frame.width - 48)
    }
}
