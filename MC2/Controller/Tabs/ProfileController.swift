//
//  ProfileController.swift
//  MC2
//
//  Created by Renzo Alvaroshan on 10/06/22.
//

import UIKit

class ProfileController: UIViewController {
    
    //MARK: - Properties
    
    private lazy var roundedRectangel: UIView = {
        let rect = UIView()
        rect.setDimensions(height: view.frame.height / 1.51, width: view.frame.width)
        rect.layer.cornerRadius = 33
        rect.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        rect.backgroundColor = .white
        return rect
    }()
    
    private lazy var circleView: UIView = {
        let circle = UIView()
        circle.setDimensions(height: view.frame.height / 4.9, width: view.frame.height / 4.9)
        circle.layer.cornerRadius = view.frame.height / 4.9 / 2
        circle.backgroundColor = .white
        return circle
    }()
    
    private lazy var avatarButton: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "ava1_f")
        iv.setDimensions(height: view.frame.width / 2.6, width: view.frame.width / 2.6)
        return iv
    }()
    
    private lazy var profileName: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsSemiBold(size: 24)
        label.text = "Karen" // need to take from textField.text (atau firebase)
        return label
    }()
    
    private lazy var penButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.tintColor = .arcadiaGreen
        button.addTarget(self, action: #selector(handleEditButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var rectangle: UIView = {
        let rect = UIView()
        rect.setDimensions(height: view.frame.height / 10.3, width: view.frame.width / 1.14)
        rect.backgroundColor = .arcadiaGray
        rect.layer.cornerRadius = 16
        return rect
    }()
    
    private lazy var changeProfile: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsSemiBold(size: 18)
        label.text = "Change Profile"
        return label
    }()
    
    private lazy var trackYourOtherKids: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsRegular(size: 14)
        label.text = "Track your other kids"
        return label
    }()
    
    private lazy var addGuardian: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsSemiBold(size: 18)
        label.text = "Add Guardian"
        return label
    }()
    
    private lazy var trackYourWhenAway: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsRegular(size: 14)
        label.text = "Track your kids when you are away"
        return label
    }()
    
    private lazy var logOut: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsSemiBold(size: 18)
        label.text = "Log Out"
        return label
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Selectors
    
    @objc func handleEditButton() {
        print("DEBUG: Edit button..")
    }
    
    @objc func handleStack2() {
        print("DEBUG: Stack 2 tapped..")
    }
    
    @objc func handleStack3() {
        print("DEBUG: Stack 3 tapped..")
    }
    
    @objc func handleStack4() {
        print("DEBUG: Stack 4 tapped..")
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .arcadiaGreen
        
        view.addSubview(roundedRectangel)
        roundedRectangel.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor)
        
        view.addSubview(circleView)
        circleView.centerX(inView: view)
        circleView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 24)
        
        circleView.addSubview(avatarButton)
        avatarButton.centerX(inView: circleView)
        avatarButton.centerY(inView: circleView)
        
        let stack = UIStackView(arrangedSubviews: [profileName, penButton])
        stack.spacing = 7
        
        view.addSubview(stack)
        stack.centerX(inView: view)
        stack.anchor(top: circleView.bottomAnchor)
        
        let stack2 = UIStackView(arrangedSubviews: [changeProfile, trackYourOtherKids])
        stack2.axis = .vertical
        stack2.setDimensions(height: view.frame.height / 10.3, width: view.frame.width / 1.14)
        stack2.backgroundColor = .arcadiaGray
        stack2.layer.cornerRadius = 16
        
        view.addSubview(stack2)
        stack2.centerX(inView: view)
        stack2.anchor(top: stack.bottomAnchor, paddingTop: 16)
        stack2.spacing = UIStackView.spacingUseSystem - 1
        stack2.isLayoutMarginsRelativeArrangement = true
        stack2.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 0)
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(handleStack2))
        stack2.addGestureRecognizer(tap2)
        stack2.isUserInteractionEnabled = true
        
        let stack3 = UIStackView(arrangedSubviews: [addGuardian, trackYourWhenAway])
        stack3.axis = .vertical
        stack3.setDimensions(height: view.frame.height / 10.3, width: view.frame.width / 1.14)
        stack3.backgroundColor = .arcadiaGray
        stack3.layer.cornerRadius = 16
        
        view.addSubview(stack3)
        stack3.centerX(inView: view)
        stack3.anchor(top: stack2.bottomAnchor, paddingTop: 16)
        stack3.spacing = UIStackView.spacingUseSystem - 1
        stack3.isLayoutMarginsRelativeArrangement = true
        stack3.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 0)
        
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(handleStack3))
        stack3.addGestureRecognizer(tap3)
        stack3.isUserInteractionEnabled = true
        
        let stack4 = UIStackView(arrangedSubviews: [logOut])
        stack4.axis = .vertical
        stack4.setDimensions(height: view.frame.height / 10.3, width: view.frame.width / 1.14)
        stack4.backgroundColor = .arcadiaGray
        stack4.layer.cornerRadius = 16
        
        view.addSubview(stack4)
        stack4.centerX(inView: view)
        stack4.anchor(top: stack3.bottomAnchor, paddingTop: 16)
        stack4.spacing = UIStackView.spacingUseSystem - 1
        stack4.isLayoutMarginsRelativeArrangement = true
        stack4.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 0)
        
        let tap4 = UITapGestureRecognizer(target: self, action: #selector(handleStack4))
        stack4.addGestureRecognizer(tap4)
        stack4.isUserInteractionEnabled = true
    }
}
