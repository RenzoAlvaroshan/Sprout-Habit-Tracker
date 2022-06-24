//
//  SelectChildView.swift
//  MC2
//
//  Created by Renzo Alvaroshan on 24/06/22.
//

import UIKit

class SelectChildView: UIView {
    
    //MARK: - Properties
    
    private lazy var selectChildTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsSemiBold(size: 20)
        label.text = "Which child do you \n want to focus on?"
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var childProfile01: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "ava1_f")
        iv.setDimensions(height: 93, width: 93)
        iv.layer.cornerRadius = frame.width / 5.2
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private lazy var childProfile02: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "circle.plus.custom")
        iv.setDimensions(height: 93, width: 93)
        iv.layer.cornerRadius = frame.width / 5.2
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private lazy var childName01: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsMedium(size: 20)
        label.text = "Karen"
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var childName02: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsMedium(size: 20)
        label.text = "Add Child"
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var addChildButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .arcadiaGreen
        button.setTitle("Ok", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.poppinsSemiBold(size: 14)
        button.layer.cornerRadius = 12
        button.setDimensions(height: 45, width: 120)
        button.addTarget(self, action: #selector(handleAddChild), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    @objc func handleAddChild() {
        print("CHILD ADDED")
    }
    
    //MARK: - Helpers
    
    func configureUI() {
//        frame.size = CGSize(width: frame.width / 1.147, height: frame.width / 1.175)
        backgroundColor = .white
        
        addSubview(selectChildTitle)
        selectChildTitle.centerX(inView: self)
        selectChildTitle.anchor(top: topAnchor, paddingTop: 12)
        
        let childStack01 = UIStackView(arrangedSubviews: [childProfile01 ,childName01])
        childStack01.axis = .vertical
        
        addSubview(childStack01)
        childStack01.anchor(top: selectChildTitle.bottomAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 12)
        
        let childStack02 = UIStackView(arrangedSubviews: [childProfile02 ,childName02])
        childStack02.axis = .vertical
        
        addSubview(childStack02)
        childStack02.anchor(top: selectChildTitle.bottomAnchor, left: childStack01.rightAnchor, paddingTop: 8, paddingLeft: 18)
        
        let stack = UIStackView(arrangedSubviews: [childStack01, childStack02])
        stack.axis = .horizontal
        stack.spacing = 24
        
        addSubview(stack)
        stack.centerX(inView: self)
        stack.anchor(top: selectChildTitle.bottomAnchor, paddingTop: 16)
        
        addSubview(addChildButton)
        addChildButton.centerX(inView: self)
        addChildButton.anchor(top: stack.bottomAnchor, paddingTop: 16)
    }
    
}
