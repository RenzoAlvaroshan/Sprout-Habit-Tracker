//
//  DoneDeleteModal.swift
//  MC2
//
//  Created by Suherda Dwi Santoso on 06/07/22.
//

import UIKit
import Firebase
import SwiftUI

class DoneDeleteModal: UIViewController {
    
    //MARK: - Properties

    let sceneDelegate = UIApplication.shared.connectedScenes.first
        
    private lazy var roundedRectangel: UIView = {
        let rect = UIView()
        rect.setDimensions(height: UIScreen.main.bounds.height / 2, width: UIScreen.main.bounds.width)
        rect.layer.cornerRadius = 33
        rect.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        rect.backgroundColor = .white
        return rect
    }()
    
    var activityName: UILabel = {
        var activityName = UILabel()
        activityName.text = "Turn of the sink while brushing your teeth"
        activityName.numberOfLines = 2
        activityName.lineBreakMode = NSLineBreakMode.byWordWrapping
        activityName.contentMode = .scaleToFill
        activityName.font = UIFont.poppinsBold(size: 26)
        activityName.setDimensions(height: 100, width: UIScreen.main.bounds.width - 40)
//        activityName.adjustsFontSizeToFitWidth = true
        return activityName
    }()
    
    var categoryName: UILabel = {
       var categoryName = UILabel()
       categoryName.layer.borderWidth = 1.5
       categoryName.layer.borderColor = UIColor.arcadiaGreen.cgColor
       categoryName.layer.backgroundColor = UIColor.white.cgColor
       categoryName.layer.cornerRadius = 15
       categoryName.layer.masksToBounds = true
       categoryName.numberOfLines = 0
       categoryName.font = UIFont.poppinsRegular(size: 14)
       categoryName.adjustsFontSizeToFitWidth = true
       categoryName.text = "Water"

       categoryName.setDimensions(height: 30, width: 120)
       categoryName.textAlignment = NSTextAlignment.center
       return categoryName
   }()
    
    private lazy var markAsDoneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Mark as done", for: .normal)
        button.isEnabled = false
        button.backgroundColor = .arcadiaGreen
        button.titleLabel?.font = UIFont.poppinsSemiBold(size: 15)
        button.layer.cornerRadius = 10
        button.setTitleColor(UIColor.white, for: .normal)
        button.setDimensions(height: 48, width: view.frame.width - 40)
        button.addTarget(self, action: #selector(handleMarkAsDone), for: .touchUpInside)
        return button
    }()
    
    private lazy var deleteTaskButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Delete task", for: .normal)
        button.titleLabel?.font = UIFont.poppinsSemiBold(size: 15)
        button.layer.borderWidth = 1.5
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.borderColor = UIColor.systemRed.cgColor
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 10
        button.setDimensions(height: 48, width: view.frame.width - 40)
        button.addTarget(self, action: #selector(deleteTask), for: .touchUpInside)
        return button
    }()
    
    private lazy var blackBox: UIView = {
        let rect = UIView()
        rect.setDimensions(height: 5, width: UIScreen.main.bounds.width / 4)
        rect.layer.cornerRadius = 2
//        rect.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        rect.backgroundColor = .black
        return rect
    }()
    
    private var previousSelectedCell: SelectChildCVCell?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureWhiteBG()
        configureUI()
    }

    //MARK: - Selectors
    @objc func handleMarkAsDone() {
        if let scene: SceneDelegate = (self.sceneDelegate?.delegate as? SceneDelegate)
        {
            scene.setToMain()
        }
    }
    
    @objc func deleteTask() {
        self.dismiss(animated: true)
    }
    
    //MARK: - Helpers
    
    func configureWhiteBG() {
        view.backgroundColor = .clear
        
        view.addSubview(roundedRectangel)
        roundedRectangel.anchor(left: view.leftAnchor, bottom: view.bottomAnchor)
        
        view.addSubview(blackBox)
        blackBox.centerX(inView: view)
        blackBox.anchor(top: roundedRectangel.topAnchor, paddingTop: 10)
    }

    func configureUI() {
        view.addSubview(activityName)
        activityName.anchor(top: roundedRectangel.topAnchor, left: view.leftAnchor, paddingTop: 30, paddingLeft: 20)
        
        view.addSubview(categoryName)
        categoryName.anchor(top: activityName.bottomAnchor, left: view.leftAnchor, paddingTop: 0, paddingLeft: 20)
                
        let stack1 = UIStackView(arrangedSubviews: [markAsDoneButton, deleteTaskButton])
        stack1.axis = .vertical
        stack1.distribution = .fillProportionally
        stack1.spacing = 10
        
        view.addSubview(stack1)
//        chooseChildButton.anchor(top: view.bottomAnchor, paddingTop: 100)
        stack1.centerX(inView: roundedRectangel)
        stack1.anchor(top: categoryName.bottomAnchor, paddingTop: 60)
    }
    
}

