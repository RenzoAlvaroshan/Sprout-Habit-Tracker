//
//  AddActivityController.swift
//  MC2
//
//  Created by Renzo Alvaroshan on 14/06/22.
//

import UIKit

class AddHabitController: UIViewController {
    
    //MARK: - Properties
    
    var waterTapped = false
    var electrictyTapped = false
    var plantingTapped = false
    var garbageTapped = false
    
    var matiinKeranAirTapped = false
    var matiinKeranAirTapped2 = false
    
    private lazy var roundedRectangel: UIView = {
        let rect = UIView()
        rect.setDimensions(height: view.frame.height / 1.28, width: view.frame.width)
        rect.layer.cornerRadius = 33
        rect.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        rect.backgroundColor = .white
        return rect
    }()
    
    private lazy var addHabitTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsBold(size: 18)
        label.text = "Add Habit"
        label.textColor = .white
        return label
    }()
    
    private lazy var circleView: UIView = {
        let circle = UIView()
        circle.setDimensions(height: view.frame.height / 5.5, width: view.frame.height / 5.5)
        circle.layer.cornerRadius = view.frame.height / 5.5 / 2
        circle.backgroundColor = .white
        return circle
    }()
    
    private lazy var habitIcon: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "water") // will add more icon
        iv.setDimensions(height: view.frame.width / 4.5, width: view.frame.width / 4.5)
        return iv
    }()
    
    private lazy var categoryTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsBold(size: 18)
        label.text = "Category"
        label.textColor = .black
        return label
    }()
    
    private lazy var waterButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.shadowOpacity = 0.14
        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        button.setDimensions(height: view.frame.width / 8.6, width: view.frame.width / 2.33)
        button.setTitle("Water", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.poppinsMedium(size: 14)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(handleWater), for: .touchUpInside)
        return button
    }()
    
    private lazy var electricityButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.shadowOpacity = 0.14
        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        button.setDimensions(height: view.frame.width / 8.6, width: view.frame.width / 2.33)
        button.setTitle("Electricity", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.poppinsMedium(size: 14)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(handleElectricity), for: .touchUpInside)
        return button
    }()
    
    private lazy var plantingButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.shadowOpacity = 0.14
        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        button.setDimensions(height: view.frame.width / 8.6, width: view.frame.width / 2.33)
        button.setTitle("Planting", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.poppinsMedium(size: 14)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(handlePlanting), for: .touchUpInside)
        return button
    }()
    
    private lazy var garbageButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.shadowOpacity = 0.14
        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        button.setDimensions(height: view.frame.width / 8.6, width: view.frame.width / 2.33)
        button.setTitle("Garbage", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.poppinsMedium(size: 14)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(handleGarbage), for: .touchUpInside)
        return button
    }()
    
    private lazy var taskTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsBold(size: 18)
        label.text = "Task"
        label.textColor = .black
        return label
    }()
    
    private lazy var matiinKeranAirButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.shadowOpacity = 0.14
        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        button.setDimensions(height: view.frame.width / 8.6, width: view.frame.width / 1.16)
        button.setTitle("Matiin keran air", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.poppinsMedium(size: 14)
        button.titleLabel?.textAlignment = .left
        button.addTarget(self, action: #selector(matiinKeranAir), for: .touchUpInside)
        return button
    }()
    
    private lazy var matiinKeranAirButton2: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.shadowOpacity = 0.14
        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        button.setDimensions(height: view.frame.width / 8.6, width: view.frame.width / 1.16)
        button.setTitle("Matiin keran air", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.poppinsMedium(size: 14)
        button.titleLabel?.textAlignment = .left
        button.addTarget(self, action: #selector(matiinKeranAir2), for: .touchUpInside)
        return button
    }()
    
    private lazy var addCustomTextField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.poppinsMedium(size: 14)
        tf.layer.borderColor = UIColor.systemGray.cgColor
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 10
        tf.layer.shadowOpacity = 0.14
        tf.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        tf.placeholder = "Add custom habit.."
        tf.setDimensions(height: view.frame.width / 8.6, width: view.frame.width / 1.16)
        tf.textAlignment = .center
        return tf
    }()
    
    private lazy var addGoalButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .arcadiaGreen
        button.layer.cornerRadius = 10
        button.layer.shadowOpacity = 0.14
        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        button.setDimensions(height: view.frame.width / 8.6, width: view.frame.width / 1.16)
        button.setTitle("Add Goal", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.poppinsMedium(size: 14)
        button.titleLabel?.textAlignment = .left
        button.addTarget(self, action: #selector(handleAddGoal), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
//        configureTapButton()
        addCustomTextField.delegate = self
    }
    
    //MARK: - Selectors
    
    @objc func handleWater() {
        print("DEBUG: Water tapped")
        waterTapped = !waterTapped
        if waterTapped {
            waterButton.backgroundColor = .arcadiaGreen2
            waterButton.setTitleColor(UIColor.white, for: .normal)

        } else {
            waterButton.backgroundColor = .white
            waterButton.setTitleColor(UIColor.black, for: .normal)
        }
        
        electrictyTapped = false
    }
    
    @objc func handleElectricity() {
        print("DEBUG: Electricity tapped")
        electrictyTapped = !electrictyTapped
        if electrictyTapped {
            electricityButton.backgroundColor = .arcadiaGreen2
            electricityButton.setTitleColor(UIColor.white, for: .normal)

        } else {
            electricityButton.backgroundColor = .white
            electricityButton.setTitleColor(UIColor.black, for: .normal)
        }
        
        waterTapped = false
    }
    
    @objc func handlePlanting() {
        print("DEBUG: Planting tapped..")
        plantingTapped = !plantingTapped
        if plantingTapped {
            plantingButton.backgroundColor = .arcadiaGreen2
            plantingButton.setTitleColor(UIColor.white, for: .normal)

        } else {
            plantingButton.backgroundColor = .white
            plantingButton.setTitleColor(UIColor.black, for: .normal)
        }
    }
    
    @objc func handleGarbage() {
        print("DEBUG: Garbage tapped..")
        garbageTapped = !garbageTapped
        if garbageTapped {
            garbageButton.backgroundColor = .arcadiaGreen2
            garbageButton.setTitleColor(UIColor.white, for: .normal)

        } else {
            garbageButton.backgroundColor = .white
            garbageButton.setTitleColor(UIColor.black, for: .normal)
        }
    }
    
    @objc func matiinKeranAir() {
        print("DEBUG: Matiin keran air..")
        matiinKeranAirTapped = !matiinKeranAirTapped
        if matiinKeranAirTapped {
            matiinKeranAirButton.backgroundColor = .arcadiaGreen2
            matiinKeranAirButton.setTitleColor(UIColor.white, for: .normal)

        } else {
            matiinKeranAirButton.backgroundColor = .white
            matiinKeranAirButton.setTitleColor(UIColor.black, for: .normal)
        }
    }
    
    @objc func matiinKeranAir2() {
        print("DEBUG: Matiin keran air..")
        matiinKeranAirTapped2 = !matiinKeranAirTapped2
        if matiinKeranAirTapped2 {
            matiinKeranAirButton2.backgroundColor = .arcadiaGreen2
            matiinKeranAirButton2.setTitleColor(UIColor.white, for: .normal)

        } else {
            matiinKeranAirButton2.backgroundColor = .white
            matiinKeranAirButton2.setTitleColor(UIColor.black, for: .normal)
        }
    }
    
    @objc func handleAddGoal() {
        print("Add goal tapped..")
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .arcadiaGreen
        
        view.addSubview(roundedRectangel)
        roundedRectangel.anchor(left: view.leftAnchor, bottom: view.bottomAnchor)
        
        view.addSubview(addHabitTitle)
        addHabitTitle.centerX(inView: view)
        addHabitTitle.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 8)
        
        view.addSubview(circleView)
        circleView.centerX(inView: view)
        circleView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 48)
        
        circleView.addSubview(habitIcon)
        habitIcon.centerX(inView: circleView)
        habitIcon.centerY(inView: circleView)
        
        view.addSubview(categoryTitle)
        categoryTitle.anchor(top: circleView.bottomAnchor, left: view.leftAnchor, paddingLeft: 20)
        
        view.addSubview(waterButton)
        waterButton.anchor(top: categoryTitle.bottomAnchor, left: view.leftAnchor, paddingTop: 8, paddingLeft: 20)
        
        view.addSubview(electricityButton)
        electricityButton.anchor(top: categoryTitle.bottomAnchor, left: waterButton.rightAnchor, paddingTop: 8, paddingLeft: 10)
        
        view.addSubview(plantingButton)
        plantingButton.anchor(top: waterButton.bottomAnchor, left: view.leftAnchor, paddingTop: 8, paddingLeft: 20)
        
        view.addSubview(garbageButton)
        garbageButton.anchor(top: electricityButton.bottomAnchor, left: plantingButton.rightAnchor, paddingTop: 8, paddingLeft: 10)
        
        view.addSubview(taskTitle)
        taskTitle.anchor(top: plantingButton.bottomAnchor, left: view.leftAnchor, paddingTop: 20, paddingLeft: 20)
        
        view.addSubview(matiinKeranAirButton)
        matiinKeranAirButton.anchor(top: taskTitle.bottomAnchor, left: view.leftAnchor, paddingTop: 16, paddingLeft: 20)
        
        view.addSubview(matiinKeranAirButton2)
        matiinKeranAirButton2.anchor(top: matiinKeranAirButton.bottomAnchor, left: view.leftAnchor, paddingTop: 12, paddingLeft: 20)
        
        view.addSubview(addCustomTextField)
        addCustomTextField.anchor(top: matiinKeranAirButton2.bottomAnchor, left: view.leftAnchor, paddingTop: 12, paddingLeft: 20)
        
        view.addSubview(addGoalButton)
        addGoalButton.anchor(top: addCustomTextField.bottomAnchor, left: view.leftAnchor, paddingTop: view.frame.width / 4.875, paddingLeft: 20)
    }
}

extension AddHabitController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
