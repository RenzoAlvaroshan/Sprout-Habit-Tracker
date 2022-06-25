//
//  SelectChildView.swift
//  MC2
//
//  Created by Renzo Alvaroshan on 24/06/22.
//

import UIKit

class SelectChildView {
    
    struct BGConstants {
        static let backgroundAlphaTo: CGFloat = 0.6
    }
    
    //MARK: - Properties
    
    private let backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .black
        backgroundView.alpha = 0
        return backgroundView
    }()
    
    private let alertView: UIView = {
        let alert = UIView()
        alert.backgroundColor = .white
        alert.layer.masksToBounds = true
        alert.layer.cornerRadius = 12
        return alert
    }()
    
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
//        iv.layer.cornerRadius = frame.width / 5.2
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private lazy var childProfile02: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "circle.plus.custom")
        iv.setDimensions(height: 93, width: 93)
//        iv.layer.cornerRadius = frame.width / 5.2
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
    
    private var myTargetView: UIView?
    
    //MARK: - Selectors
    
    @objc func handleAddChild() {
        print("CHILD ADDED")
    }
    
    //MARK: - Helpers
    
    func showChildPicker(viewController: UIViewController) {
        guard let targetView = viewController.view else {
            return
        }
        
        myTargetView = targetView
        
        backgroundView.frame = targetView.bounds
        targetView.addSubview(backgroundView)
        
        targetView.addSubview(alertView)
        alertView.centerX(inView: targetView)
        alertView.centerY(inView: targetView)
        alertView.anchor(width: targetView.frame.size.width-80, height: 400)
//        alertView.frame = CGRect(x: 40,y: 300,width: targetView.frame.size.width-80,height: 300)
        
        targetView.addSubview(selectChildTitle)
        selectChildTitle.centerX(inView: targetView)
        selectChildTitle.anchor(top: alertView.topAnchor, paddingTop: 12)
        
        // MARK: - child stack / collection view
        
        let childStack01 = UIStackView(arrangedSubviews: [childProfile01 ,childName01])
        childStack01.axis = .vertical
        
        targetView.addSubview(childStack01)
        childStack01.anchor(top: selectChildTitle.bottomAnchor, left: alertView.leftAnchor, paddingLeft: 12)

        let childStack02 = UIStackView(arrangedSubviews: [childProfile02 ,childName02])
        childStack02.axis = .vertical

        targetView.addSubview(childStack02)
        childStack02.anchor(top: selectChildTitle.bottomAnchor, left: alertView.rightAnchor, paddingTop: 8, paddingLeft: 18)

        let stack = UIStackView(arrangedSubviews: [childStack01, childStack02])
        stack.axis = .horizontal
        stack.spacing = 24
        
        targetView.addSubview(stack)
        stack.centerX(inView: alertView)
        stack.anchor(top: selectChildTitle.bottomAnchor, paddingTop: 16)
        
        // MARK: - Done button
        
        targetView.addSubview(addChildButton)
        addChildButton.centerX(inView: targetView)
        addChildButton.anchor(top: stack.bottomAnchor, paddingTop: 16)
        addChildButton.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        
        // MARK: - Animate
        UIView.animate(withDuration: 0.5, animations: {
            self.backgroundView.alpha = BGConstants.backgroundAlphaTo
        }, completion: {done in
            if done {
                UIView.animate(withDuration: 0.5, animations: {
                    self.alertView.layer.opacity = 1
                    self.backgroundView.layer.opacity = 1
                    self.selectChildTitle.layer.opacity = 1
                    self.childName01.layer.opacity = 1
                    self.childName02.layer.opacity = 1
                    self.childProfile01.layer.opacity = 1
                    self.childProfile02.layer.opacity = 1
                    self.addChildButton.layer.opacity = 1
                })
            }
        })
    }
    
    @objc func dismissAlert() {
        
        guard let targetView = myTargetView else {
            return
        }
        UIView.animate(withDuration: 0.5, animations: {
            UIView.animate(withDuration: 0.5, animations: {
                self.backgroundView.alpha = 0
                
                self.alertView.layer.opacity = 0
                self.backgroundView.layer.opacity = 0
                self.selectChildTitle.layer.opacity = 0
                self.childName01.layer.opacity = 0
                self.childName02.layer.opacity = 0
                self.childProfile01.layer.opacity = 0
                self.childProfile02.layer.opacity = 0
                self.addChildButton.layer.opacity = 0
            }, completion: {done in
                if done {
                    self.alertView.removeFromSuperview()
                    self.backgroundView.removeFromSuperview()
                    self.selectChildTitle.removeFromSuperview()
                    self.childName01.removeFromSuperview()
                    self.childName02.removeFromSuperview()
                    self.childProfile01.removeFromSuperview()
                    self.childProfile02.removeFromSuperview()
                    self.addChildButton.removeFromSuperview()
                }
            })
        })
    }
}
