//
//  ProfileController.swift
//  MC2
//
//  Created by Renzo Alvaroshan on 10/06/22.
//

import Firebase
import UIKit

class ProfileController: UIViewController {
    
    //MARK: - Properties
    
    var child: [Child]? {
        didSet {
            configure()
        }
    }
    
    let sceneDelegate = UIApplication.shared.connectedScenes.first
    
    
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
        return label
    }()
    
    private lazy var penButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "pencil", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24, weight: .bold)), for: .normal)
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
    
    private lazy var addKids: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsSemiBold(size: 18)
        label.text = "Add Kids"
        return label
    }()
    
    private lazy var addYourOtherKids: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsRegular(size: 14)
        label.text = "Add your other kids"
        return label
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
    
    private lazy var ecoPedia: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsSemiBold(size: 18)
        label.text = "Ecopedia"
        return label
    }()
    
    private lazy var ecopediaSubtitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsRegular(size: 14)
        label.text = "Enhance your eco-habits with Ecopedia !"
        return label
    }()
    
    private let background: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "BG")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
        
    
    //MARK: - Selectors
    
    @objc func handleEditButton() {
        let rootVC = EditChildController()
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.isNavigationBarHidden = true
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    
    @objc func handleStack1() {
        let rootVC = AddChildControllerInitial()
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.isNavigationBarHidden = true
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    
    @objc func handleStack2() {

        let rootVC = SelectChildCollectionView()
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .pageSheet
        present(navVC, animated: true) {
            navVC.presentationController?.presentedView?.gestureRecognizers?[0].isEnabled = false
        }
        
    }
    
    @objc func handleStack3() {
        
        let alert = UIAlertController(title: "Oops, not so fast!", message: "Unfortunately, this feature is not available right now. Look forward to an update later in the future!", preferredStyle: .alert)
        alert.view.tintColor = .arcadiaGreen
        
        let action = UIAlertAction(title: "OK", style: .cancel)
        
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    @objc func handleStack4() {
        do {
            let userDefaults = UserDefaults.standard
            userDefaults.set(0, forKey: "childRef")
            
            try Auth.auth().signOut()
            if let scene: SceneDelegate = (self.sceneDelegate?.delegate as? SceneDelegate)
            {
                scene.setToMain()
            }
        } catch {
            print("DEBUG: Failed to sign out")
        }
    }
    
    @objc func handleStack5() {
        let rootVC = EcopediaView()
//        let navVC = UINavigationController(rootViewController: rootVC)
//        navVC.isNavigationBarHidden = false
        navigationController?.pushViewController(rootVC, animated: true)
    }
    
    //MARK: - Helper
    
    func configure() {
        
    }
    
    func configureUI() {
        
        profileName.text = UserDefaults.standard.string(forKey: "childDataName")
        let viewmodel = ChildViewModel(imageData: UserDefaults.standard.integer(forKey: "childDataImage"))
        avatarButton.image = UIImage(named: viewmodel.profileImageChild)

        view.backgroundColor = .arcadiaGreen
        
        view.addSubview(background)
        background.centerX(inView: view)
        background.centerY(inView: view)
        background.setDimensions(height: view.frame.height, width: view.frame.width)
        
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
        
        let stack1 = UIStackView(arrangedSubviews: [addKids, addYourOtherKids])
        stack1.axis = .vertical
        stack1.setDimensions(height: view.frame.height / 10.3, width: view.frame.width / 1.14)
        stack1.backgroundColor = .arcadiaGray
        stack1.layer.cornerRadius = 16
        
        view.addSubview(stack1)
        stack1.centerX(inView: view)
        stack1.anchor(top: stack.bottomAnchor, paddingTop: 20)
        stack1.spacing = UIStackView.spacingUseSystem - 1
        stack1.isLayoutMarginsRelativeArrangement = true
        stack1.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 0)
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(handleStack1))
        stack1.addGestureRecognizer(tap1)
        stack1.isUserInteractionEnabled = true
        
        
        let stack2 = UIStackView(arrangedSubviews: [changeProfile, trackYourOtherKids])
        stack2.axis = .vertical
        stack2.setDimensions(height: view.frame.height / 10.3, width: view.frame.width / 1.14)
        stack2.backgroundColor = .arcadiaGray
        stack2.layer.cornerRadius = 16
        
        view.addSubview(stack2)
        stack2.centerX(inView: view)
        stack2.anchor(top: stack1.bottomAnchor, paddingTop: 12)
        stack2.spacing = UIStackView.spacingUseSystem - 1
        stack2.isLayoutMarginsRelativeArrangement = true
        stack2.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 0)
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(handleStack2))
        stack2.addGestureRecognizer(tap2)
        stack2.isUserInteractionEnabled = true
        
        let stack5 = UIStackView(arrangedSubviews: [ecoPedia, ecopediaSubtitle])
        stack5.axis = .vertical
        stack5.setDimensions(height: view.frame.height / 10.3, width: view.frame.width / 1.14)
        stack5.backgroundColor = .arcadiaGray
        stack5.layer.cornerRadius = 16
        
        view.addSubview(stack5)
        stack5.centerX(inView: view)
        stack5.anchor(top: stack2.bottomAnchor, paddingTop: 12)
        stack5.spacing = UIStackView.spacingUseSystem - 1
        stack5.isLayoutMarginsRelativeArrangement = true
        stack5.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 0)
        
        let tap5 = UITapGestureRecognizer(target: self, action: #selector(handleStack5))
        stack5.addGestureRecognizer(tap5)
        stack5.isUserInteractionEnabled = true
        
//        let stack3 = UIStackView(arrangedSubviews: [addGuardian, trackYourWhenAway])
//        stack3.axis = .vertical
//        stack3.setDimensions(height: view.frame.height / 10.3, width: view.frame.width / 1.14)
//        stack3.backgroundColor = .arcadiaGray
//        stack3.layer.cornerRadius = 16
//
//        view.addSubview(stack3)
//        stack3.centerX(inView: view)
//        stack3.anchor(top: stack2.bottomAnchor, paddingTop: 12)
//        stack3.spacing = UIStackView.spacingUseSystem - 1
//        stack3.isLayoutMarginsRelativeArrangement = true
//        stack3.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 0)
//
//        let tap3 = UITapGestureRecognizer(target: self, action: #selector(handleStack3))
//        stack3.addGestureRecognizer(tap3)
//        stack3.isUserInteractionEnabled = true
        
        
        let stack4 = UIStackView(arrangedSubviews: [logOut])
        stack4.axis = .vertical
        stack4.setDimensions(height: view.frame.height / 10.3, width: view.frame.width / 1.14)
        stack4.backgroundColor = .arcadiaGray
        stack4.layer.cornerRadius = 16
        
        view.addSubview(stack4)
        stack4.centerX(inView: view)
        stack4.anchor(top: stack5.bottomAnchor, paddingTop: 12)
        stack4.spacing = UIStackView.spacingUseSystem - 1
        stack4.isLayoutMarginsRelativeArrangement = true
        stack4.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 0)
        
        let tap4 = UITapGestureRecognizer(target: self, action: #selector(handleStack4))
        stack4.addGestureRecognizer(tap4)
        stack4.isUserInteractionEnabled = true
    }
}


