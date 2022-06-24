//
//  AddChildController.swift
//  MC2
//
//  Created by Renzo Alvaroshan on 13/06/22.
//

import UIKit
import Firebase

enum AvatarStyle: String, CaseIterable {
    case ava1 = "ava1_f"
    case ava2 = "ava2_f"
    case ava3 = "ava3_f"
    case ava4 = "ava1_m"
    case ava5 = "ava2_m"
    case ava6 = "ava3_m"
}

class AddChildController: UIViewController {
    
    //MARK: - Properties
    
    var child: Child?
    
    lazy var randomID = randomString(length: 10)
    
    private var radioButton: RadioButtonManager<UIView>?
    private var selectedBorderView: UIView?
    
    private lazy var roundedRectangel: UIView = {
        let rect = UIView()
        rect.setDimensions(height: view.frame.height / 1.28, width: view.frame.width)
        rect.layer.cornerRadius = 33
        rect.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        rect.backgroundColor = .white
        return rect
    }()
    
    private lazy var addChildTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsMedium(size: 18)
        label.text = "Add Child"
        label.textColor = .white
        return label
    }()
    
    private lazy var circleView: UIView = {
        let circle = UIView()
        circle.setDimensions(height: view.frame.height / 4.9, width: view.frame.height / 4.9)
        circle.layer.cornerRadius = view.frame.height / 4.9 / 2
        circle.backgroundColor = .white
        return circle
    }()
    
    private lazy var avatarProfile: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "ava1_f")
        iv.setDimensions(height: view.frame.width / 2.6, width: view.frame.width / 2.6)
        return iv
    }()
    
    private lazy var nameTextField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.poppinsSemiBold(size: 18)
        tf.layer.borderColor = UIColor.systemGray.cgColor
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 8
        tf.placeholder = "Enter your child name"
        tf.setDimensions(height: view.frame.width / 10.54, width: view.frame.width / 1.58)
        tf.textAlignment = .center
        return tf
    }()
    
    private lazy var getStartedButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .arcadiaGreen
        button.layer.cornerRadius = 10
        button.setDimensions(height: 50, width: 341)
        button.setTitle("Let's get started!", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.poppinsSemiBold(size: 15)
        button.addTarget(self, action: #selector(handleGetStarted), for: .touchUpInside)
        return button
    }()
    
    private lazy var borderView: UIView = {
        let border = UIView()
        border.setDimensions(height: view.frame.width / 3.54, width: view.frame.width / 3.54)
        border.layer.borderColor = UIColor.arcadiaGreen.cgColor
        border.layer.borderWidth = 5
        border.layer.cornerRadius = 110 / 2
        return border
    }()
    
    private var avatars: [UIImageView]?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Selectors
    
    @objc func handleGetStarted() {
        // cara kevin
        let childName = nameTextField.text!
        let childID = randomID

        let model = Child(dictionary: ["name" : childName, "childID": childID])
        
        // update array childId di users
        guard let uid = Auth.auth().currentUser?.uid else { return }
        COLLECTION_USERS.document(uid).updateData(["childId": FieldValue.arrayUnion([childID])])
        
        // save child data di collection child
        Service.saveChildData(child: model) { error in
            if let error = error {
                print("ERROR is \(error.localizedDescription)")
            }
        }
//        self.navigationController?.popViewController(MainController(), animated: true)
        dismiss(animated: true)
    }
    
    @objc func handleTapAvatar(_ sender: UIGestureRecognizer) {
        guard let iv = sender.view as? UIImageView else { return }
        radioButton?.selected = iv
        avatarProfile.image = iv.image
        print("DEBUG: \(iv)")
    }
    
    //MARK: - Helpers
    
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    func configureUI() {
        view.backgroundColor = .arcadiaGreen
        
        let avatars: [UIImageView] = AvatarStyle.allCases.map {
            let assetName = $0.rawValue
            return createAvatar(imageName: assetName)
        }
        self.avatars = avatars

        radioButton = RadioButtonManager(
            avatars,
            onSelected: { [unowned self] avatar in
                let borderView = UIView()
                borderView.setDimensions(height: 110, width: 110)
                borderView.layer.borderColor = UIColor.arcadiaGreen.cgColor
                borderView.layer.borderWidth = 5
                borderView.layer.cornerRadius = 110 / 2

                avatar.addSubview(borderView)
                borderView.centerX(inView: avatar)
                borderView.centerY(inView: avatar)
                
                selectedBorderView = borderView
        }, onDeselect: { [unowned self] avatar in
            selectedBorderView?.removeFromSuperview()
        })

        avatars.forEach { avatar in
            let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapAvatar(_:)))
            avatar.isUserInteractionEnabled = true
            avatar.addGestureRecognizer(tap)
        }
        
        view.addSubview(roundedRectangel)
        roundedRectangel.anchor(left: view.leftAnchor, bottom: view.bottomAnchor)
        
        view.addSubview(addChildTitle)
        addChildTitle.centerX(inView: view)
        addChildTitle.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 8)
        
        view.addSubview(circleView)
        circleView.centerX(inView: view)
        circleView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 48)
        
        circleView.addSubview(avatarProfile)
        avatarProfile.centerX(inView: circleView)
        avatarProfile.centerY(inView: circleView)
        
        view.addSubview(nameTextField)
        nameTextField.centerX(inView: view)
        nameTextField.anchor(top: circleView.bottomAnchor)
        
//        let totalStack = avatars.count % 3
        
        let stack1 = UIStackView(arrangedSubviews: Array(avatars.prefix(3)))
        stack1.spacing = 16
        stack1.distribution = .fillEqually
        
        view.addSubview(stack1)
        stack1.centerX(inView: view)
        stack1.anchor(top: nameTextField.bottomAnchor, paddingTop: 40)
        
        let stack2 = UIStackView(arrangedSubviews: avatars.suffix(3))
        stack2.spacing = 16
        stack2.distribution = .fillEqually
        
        view.addSubview(stack2)
        stack2.centerX(inView: view)
        stack2.anchor(top: stack1.bottomAnchor, paddingTop: 32)
        
        view.addSubview(getStartedButton)
        getStartedButton.centerX(inView: view)
        getStartedButton.anchor(top: stack2.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,paddingTop: 50, paddingLeft: 28, paddingRight: 28)
    }
    
    func createAvatar(imageName: String) -> UIImageView {
        let iv = UIImageView()
        iv.image = UIImage(named: imageName)
        iv.setDimensions(height: view.frame.width / 4.24, width: view.frame.width / 4.24)
        return iv
    }
}
