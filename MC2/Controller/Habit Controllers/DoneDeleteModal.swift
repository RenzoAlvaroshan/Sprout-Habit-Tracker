//
//  DoneDeleteModal.swift
//  MC2
//
//  Created by Suherda Dwi Santoso on 06/07/22.
//

import UIKit
import Firebase

protocol DoneDeleteModalDelegate: AnyObject {
    func handleReloadDataModal()
}

class DoneDeleteModal: UIViewController {
    
    //MARK: - Properties
    weak var delegate: DoneDeleteModalDelegate?
    
    var ref: Int = 0

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

       categoryName.setDimensions(height: 30, width: 120)
       categoryName.textAlignment = NSTextAlignment.center
       return categoryName
   }()
    
    var markAsDoneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Mark as done", for: .normal)
        button.backgroundColor = .arcadiaGreen
        button.titleLabel?.font = UIFont.poppinsSemiBold(size: 15)
        button.layer.cornerRadius = 10
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(handleMarkAsDone), for: .touchUpInside)
        return button
    }()
    
    var deleteTaskButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Delete task", for: .normal)
        button.titleLabel?.font = UIFont.poppinsSemiBold(size: 15)
        button.layer.borderWidth = 1.5
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.borderColor = UIColor.systemRed.cgColor
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 10
        button.setDimensions(height: 48, width: UIScreen.main.bounds.width - 40)
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
        alertOnTap()
    }
    
    @objc func deleteTask() {
        alertDelete()
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
        activityName.anchor(top: roundedRectangel.topAnchor, left: view.leftAnchor,right: view.rightAnchor, paddingTop: 30, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(categoryName)
        categoryName.anchor(top: activityName.bottomAnchor, left: view.leftAnchor, paddingTop: 0, paddingLeft: 32)
        
        let stack1 = UIStackView(arrangedSubviews: [markAsDoneButton, deleteTaskButton])
        stack1.axis = .vertical
        stack1.distribution = .fillProportionally
        stack1.spacing = 10
        
        view.addSubview(stack1)
        stack1.centerX(inView: roundedRectangel)
        stack1.anchor(top: categoryName.bottomAnchor, paddingTop: 80)
    }
    
    
    func alertOnTap() {
        let alert = UIAlertController(title: "Mark this task as done?", message: "Make sure your child implement the task correctly", preferredStyle: UIAlertController.Style.alert)
        alert.view.tintColor = UIColor.arcadiaGreen
        
        let action = UIAlertAction(title: "Done", style: UIAlertAction.Style.default) { [self] _ in
            print("DEBUG: \(ref)")
            Service.updateActivityState(ref: self.ref)
            { error in
                print("DEBUG: error is \(String(describing: error))")
            }
            alertConfirmation()
        }
        
        alert.addAction(action)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    func alertConfirmation() {
        let alert = UIAlertController(title: "Task Completed!", message: "", preferredStyle: UIAlertController.Style.alert)
        alert.view.tintColor = UIColor.arcadiaGreen
        
        alert.addAction(UIAlertAction(title: "Got It!", style: UIAlertAction.Style.default, handler: { [self]_ in
            
            delegate?.handleReloadDataModal()
            dismiss(animated: true)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func alertDelete() {
        let alert = UIAlertController(title: "Delete this task?", message: "Are you sure you want to delete this task?", preferredStyle: UIAlertController.Style.alert)
        alert.view.tintColor = UIColor.arcadiaGreen
        
        let action = UIAlertAction(title: "Delete", style: UIAlertAction.Style.default) { [self] _ in
            
            // service delete disini
            Service.deleteActivityData(ref: ref)
            { error in
                print("DEBUG: error is \(String(describing: error))")
            }
            delegate?.handleReloadDataModal()
            dismiss(animated: true)
        }
        
        alert.addAction(action)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
}

