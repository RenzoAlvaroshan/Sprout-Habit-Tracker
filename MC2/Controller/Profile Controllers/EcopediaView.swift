//
//  EcopediaView.swift
//  MC2
//
//  Created by Suherda Dwi Santoso on 06/07/22.
//

import Firebase
import UIKit
import SwiftUI

class EcopediaView: UIViewController {
    
    //MARK: - Properties
    
    var child: [Child]? {
        didSet {
            configure()
        }
    }
    
    let sceneDelegate = UIApplication.shared.connectedScenes.first
    
    
    private lazy var ecopedia: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsBold(size: 18)
        label.text = "Ecopedia"
        label.textColor = .white
        return label
    }()
    
    private let backImg: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "chevron.backward")
        iv.contentMode = .scaleAspectFill
        iv.tintColor = .white
        iv.setDimensions(height: 18, width: 18)
        return iv
    }()
    
    let yourAttributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.poppinsMedium(size: 18)/*,
        .underlineStyle: NSUnderlineStyle.single.rawValue */
    ]
    
    private lazy var backButton: AppButton = {
        
        let attributeString = NSMutableAttributedString(
            string: "Back",
            attributes: yourAttributes
        )
        
        let button = AppButton(type: .system)
        button.setAttributedTitle(attributeString, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var roundedRectangel: UIView = {
        let rect = UIView()
        rect.setDimensions(height: view.frame.height / 1.17, width: view.frame.width)
        rect.layer.cornerRadius = 33
        rect.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        rect.backgroundColor = .white
        return rect
    }()
    
    private lazy var rectangle: UIView = {
        let rect = UIView()
        rect.setDimensions(height: view.frame.height / 10.3, width: view.frame.width / 1.14)
        rect.backgroundColor = .arcadiaGray
        rect.layer.cornerRadius = 16
        return rect
    }()
    
    private lazy var ecopediaTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsBold(size: 24)
        label.text = "Ecopedia"
        label.textColor = .black
        return label
    }()
    
    private lazy var ecopediaSubtitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsSemiBold(size: 14)
        label.text = "Enhance your eco-habits with Ecopedia"
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var eco1: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsSemiBold(size: 18)
        label.text = "Plastic Bottles Craft DIY"
        return label
    }()
    
    private lazy var eco1Sub: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsRegular(size: 14)
        label.text = "Video duration: 8 mins"
        return label
    }()
    
    private lazy var eco2: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsSemiBold(size: 18)
        label.text = "Newspaper Craft DIY"
        return label
    }()
    
    private lazy var eco2Sub: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsRegular(size: 14)
        label.text = "Video duration: 8 mins"
        return label
    }()
    
    private lazy var eco3: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsSemiBold(size: 18)
        label.text = "Grow Your Own Plant"
        return label
    }()
    
    private lazy var eco3Sub: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsRegular(size: 14)
        label.text = "Video duration: 8 mins"
        return label
    }()
    
    private lazy var eco4: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsSemiBold(size: 18)
        label.text = "Plastic Bottles Craft DIY"
        return label
    }()
    
    private lazy var eco4Sub: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsRegular(size: 14)
        label.text = "Video duration: 8 mins"
        return label
    }()
    
    private let background: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "TabBarBG")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
        
    
    //MARK: - Selectors

    @objc func handleBackButton() {
        self.dismiss(animated: true)
    }
    
    //MARK: - Helper
    
    func configure() {
        
    }
    
    func configureUI() {

        view.backgroundColor = .arcadiaGreen
        
        view.addSubview(background)
        background.centerX(inView: view)
        background.centerY(inView: view)
        background.setDimensions(height: view.frame.height, width: view.frame.width)
        
        view.addSubview(ecopedia)
        ecopedia.anchor(top: view.topAnchor, paddingTop: 70)
        ecopedia.centerX(inView: view)
        
        let stack00 = UIStackView(arrangedSubviews: [backImg, backButton])
        stack00.axis = .horizontal
        stack00.spacing = 5
        
        view.addSubview(stack00)
        stack00.anchor(top:view.topAnchor, left: view.leftAnchor, paddingTop: 75, paddingLeft: 15)
        
        view.addSubview(roundedRectangel)
        roundedRectangel.anchor(left: view.leftAnchor, bottom: view.bottomAnchor)
        
        let stack0 = UIStackView(arrangedSubviews: [ecopediaTitle, ecopediaSubtitle])
        stack0.axis = .vertical
        stack0.setDimensions(height: view.frame.height / 10.3, width: view.frame.width / 1.14)
        
        view.addSubview(stack0)
        stack0.anchor(top: roundedRectangel.topAnchor, left: view.leftAnchor, paddingTop: 30, paddingLeft: 15)
        stack0.spacing = 10
        stack0.isLayoutMarginsRelativeArrangement = true
        stack0.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 0)
        
        let stack1 = UIStackView(arrangedSubviews: [eco1, eco1Sub])
        stack1.axis = .vertical
        stack1.setDimensions(height: view.frame.height / 10.3, width: view.frame.width / 1.14)
        stack1.backgroundColor = .arcadiaGray
        stack1.layer.cornerRadius = 16
        
        view.addSubview(stack1)
        stack1.centerX(inView: view)
        stack1.anchor(top: stack0.bottomAnchor, paddingTop: 10)
        stack1.spacing = UIStackView.spacingUseSystem - 1
        stack1.isLayoutMarginsRelativeArrangement = true
        stack1.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 0)
        
//        let tap1 = UITapGestureRecognizer(target: self, action: #selector())
//        stack1.addGestureRecognizer(tap1)
//        stack1.isUserInteractionEnabled = true
        
        
        let stack2 = UIStackView(arrangedSubviews: [eco2, eco2Sub])
        stack2.axis = .vertical
        stack2.setDimensions(height: view.frame.height / 10.3, width: view.frame.width / 1.14)
        stack2.backgroundColor = .arcadiaGray
        stack2.layer.cornerRadius = 16
        
        view.addSubview(stack2)
        stack2.centerX(inView: view)
        stack2.anchor(top: stack1.bottomAnchor, paddingTop: 16)
        stack2.spacing = UIStackView.spacingUseSystem - 1
        stack2.isLayoutMarginsRelativeArrangement = true
        stack2.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 0)
        
//        let tap2 = UITapGestureRecognizer(target: self, action: #selector())
//        stack2.addGestureRecognizer(tap2)
//        stack2.isUserInteractionEnabled = true
        
        
        let stack3 = UIStackView(arrangedSubviews: [eco3, eco3Sub])
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

//        let tap3 = UITapGestureRecognizer(target: self, action: #selector())
//        stack3.addGestureRecognizer(tap3)
//        stack3.isUserInteractionEnabled = true
        
        
        let stack4 = UIStackView(arrangedSubviews: [eco4, eco4Sub])
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
        
//        let tap4 = UITapGestureRecognizer(target: self, action: #selector())
//        stack4.addGestureRecognizer(tap4)
//        stack4.isUserInteractionEnabled = true
    }
}

