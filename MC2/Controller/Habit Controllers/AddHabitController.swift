//
//  AddActivityController.swift
//  MC2
//
//  Created by Renzo Alvaroshan on 14/06/22.
//

import UIKit
import Firebase

protocol AddHabitControllerDelegate: AnyObject {
    func handleReloadData()
}

class AddHabitController: UIViewController {
    
    //MARK: - Properties
    
    weak var delegate: AddHabitControllerDelegate?
    
    var activity = [Activity]()
    var tapButton: String = "Water"
    var activities = [String]()
    var childUID = [String]()
    
    var waterTapped = true
    var electrictyTapped = false
    var plantingTapped = false
    var garbageTapped = false
    
    var matiinKeranAirTapped = false
    var matiinKeranAirTapped2 = false
    
    let sceneDelegate = UIApplication.shared.connectedScenes.first
    
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
        button.backgroundColor = .arcadiaGreen2
        button.layer.cornerRadius = 10
        button.layer.shadowOpacity = 0.14
        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        button.setDimensions(height: view.frame.width / 8.6, width: (view.frame.width / 2) - 24)
        button.setTitle("Water", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
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
        button.setDimensions(height: view.frame.width / 8.6, width: (view.frame.width / 2) - 24)
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
        button.setDimensions(height: view.frame.width / 8.6, width: (view.frame.width / 2) - 24)
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
        button.setDimensions(height: view.frame.width / 8.6, width: (view.frame.width / 2) - 24)
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
    
    private lazy var habitButton01: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.shadowOpacity = 0.14
        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        button.setDimensions(height: view.frame.width / 8.6, width: view.frame.width - 40)
        button.setTitle("Turn off tap while brushing teeth", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.poppinsMedium(size: 14)
        button.titleLabel?.textAlignment = .left
        button.addTarget(self, action: #selector(matiinKeranAir), for: .touchUpInside)
        return button
    }()
    
    private lazy var habitButton02: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.shadowOpacity = 0.14
        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        button.setDimensions(height: view.frame.width / 8.6, width: view.frame.width - 40)
        button.setTitle("Take quick showers", for: .normal)
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
        tf.setDimensions(height: view.frame.width / 8.6, width: view.frame.width - 40)
        tf.textAlignment = .center
        return tf
    }()
    
    private lazy var addGoalButton: AppButton = {
        let button = AppButton(type: .system)
        button.backgroundColor = .systemGray3
        button.layer.cornerRadius = 10
        button.layer.shadowOpacity = 0.14
        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        button.setDimensions(height: view.frame.width / 8.6, width: view.frame.width / 1.16)
        button.setTitle("Add Goal", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.poppinsMedium(size: 14)
        button.titleLabel?.textAlignment = .left
        button.addTarget(self, action: #selector(handleAddGoal), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = ""

        addCustomTextField.delegate = self
        configureUI()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        addCustomTextField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
    }
    
    //MARK: - Selectors
    
    @objc func handleWater() {
        waterTapped = !waterTapped
        if waterTapped {
            tapButton = "Water"
            
            waterButton.backgroundColor = .arcadiaGreen2
            waterButton.setTitleColor(UIColor.white, for: .normal)
            habitIcon.image = UIImage(named: "water")
            
            electricityButton.backgroundColor = .white
            electricityButton.setTitleColor(UIColor.black, for: .normal)
            
            plantingButton.backgroundColor = .white
            plantingButton.setTitleColor(UIColor.black, for: .normal)
            
            garbageButton.backgroundColor = .white
            garbageButton.setTitleColor(UIColor.black, for: .normal)
            
            electrictyTapped = false
            plantingTapped = false
            garbageTapped = false
            
            habitButton01.setTitle("Turn off tap while brushing teeth", for: .normal)
            habitButton02.setTitle("Take quick showers", for: .normal)
            
            deselectHabit()
        }
    }
    
    @objc func handleElectricity() {
        electrictyTapped = !electrictyTapped
        if electrictyTapped {
            tapButton = "Electricity"
            
            electricityButton.backgroundColor = .arcadiaGreen2
            electricityButton.setTitleColor(UIColor.white, for: .normal)
            habitIcon.image = UIImage(named: "electric")
            
            waterButton.backgroundColor = .white
            waterButton.setTitleColor(UIColor.black, for: .normal)
            
            plantingButton.backgroundColor = .white
            plantingButton.setTitleColor(UIColor.black, for: .normal)
            
            garbageButton.backgroundColor = .white
            garbageButton.setTitleColor(UIColor.black, for: .normal)
            
            waterTapped = false
            plantingTapped = false
            garbageTapped = false
            
            habitButton01.setTitle("Turn the lights off during the day", for: .normal)
            habitButton02.setTitle("Turn the AC off when not using", for: .normal)
            
            deselectHabit()
        }
    }
    
    @objc func handlePlanting() {
        plantingTapped = !plantingTapped
        if plantingTapped {
            tapButton = "Planting"
            
            plantingButton.backgroundColor = .arcadiaGreen2
            plantingButton.setTitleColor(UIColor.white, for: .normal)
            habitIcon.image = UIImage(named: "plant")
            
            waterButton.backgroundColor = .white
            waterButton.setTitleColor(UIColor.black, for: .normal)
            
            electricityButton.backgroundColor = .white
            electricityButton.setTitleColor(UIColor.black, for: .normal)
            
            garbageButton.backgroundColor = .white
            garbageButton.setTitleColor(UIColor.black, for: .normal)
            
            electrictyTapped = false
            plantingTapped = false
            garbageTapped = false
            
            habitButton01.setTitle("Cleaning the plant leaves", for: .normal)
            habitButton02.setTitle("Water the plans using watering can", for: .normal)
            
            deselectHabit()
        }
    }
    
    @objc func handleGarbage() {
        garbageTapped = !garbageTapped
        if garbageTapped {
            tapButton = "Garbage"
            
            garbageButton.backgroundColor = .arcadiaGreen2
            garbageButton.setTitleColor(UIColor.white, for: .normal)
            habitIcon.image = UIImage(named: "garbage")
            
            waterButton.backgroundColor = .white
            waterButton.setTitleColor(UIColor.black, for: .normal)
            
            electricityButton.backgroundColor = .white
            electricityButton.setTitleColor(UIColor.black, for: .normal)
            
            plantingButton.backgroundColor = .white
            plantingButton.setTitleColor(UIColor.black, for: .normal)
            
            electrictyTapped = false
            plantingTapped = false
            waterTapped = false
            
            habitButton01.setTitle("Sort the garbage", for: .normal)
            habitButton02.setTitle("Refilling reusable water bottles", for: .normal)
            
            deselectHabit()
        }
    }
    
    @objc func matiinKeranAir() {
        matiinKeranAirTapped = !matiinKeranAirTapped
        if matiinKeranAirTapped {
            habitButton01.backgroundColor = .arcadiaGreen2
            habitButton01.setTitleColor(UIColor.white, for: .normal)
            
            activities.removeAll()
            activities.append((habitButton01.titleLabel?.text)!)
            
            matiinKeranAirTapped2 = false
            
            habitButton02.backgroundColor = .white
            habitButton02.setTitleColor(UIColor.black, for: .normal)
            
            addCustomTextField.text = ""
            
            checkForm()
        } else {
            
            activities.removeAll()
            
            habitButton01.backgroundColor = .white
            habitButton01.setTitleColor(UIColor.black, for: .normal)
            
            checkForm()
        }
    }
    
    @objc func matiinKeranAir2() {
        matiinKeranAirTapped2 = !matiinKeranAirTapped2
        if matiinKeranAirTapped2 {
            habitButton02.backgroundColor = .arcadiaGreen2
            habitButton02.setTitleColor(UIColor.white, for: .normal)
            
            activities.removeAll()
            activities.append((habitButton02.titleLabel?.text)!)
            
            matiinKeranAirTapped = false
            
            habitButton01.backgroundColor = .white
            habitButton01.setTitleColor(UIColor.black, for: .normal)
            
            addCustomTextField.text = ""
            
            checkForm()
        } else {
            
            activities.removeAll()
            
            habitButton02.backgroundColor = .white
            habitButton02.setTitleColor(UIColor.black, for: .normal)
            
            checkForm()
        }
    }
    
    @objc func handleAddGoal() {
        
        print(activities)
        print(tapButton)
        
        let model = Activity(dictionary: ["activityName" : activities.last, "category": tapButton, "isFinished": false])

        let currentChildUid = UserDefaults.standard.object(forKey: "childCurrentUid")

        Service.saveActivity(activity: model, childId: currentChildUid as! String) { error, activityId  in
            if let error = error {
                print("ERROR is \(error.localizedDescription)")
            }
        }

        showAlert()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            
            let keyboardHeight = keyboardFrame.cgRectValue.height
            let bottomSpacing = self.view.frame.height - (addGoalButton.frame.origin.y + addGoalButton.frame.height)
            self.view.frame.origin.y -= keyboardHeight - bottomSpacing + 70
        }
    }
    
    @objc func keyboardWillHide() {
        self.view.frame.origin.y = 0
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func showAlert() {
        
        let alert = UIAlertController(title: "Sucessfully Added!", message: "Your new task has been successfully added!", preferredStyle: UIAlertController.Style.alert)
        alert.view.tintColor = UIColor.arcadiaGreen
        
        let action = UIAlertAction(title: "Done", style: UIAlertAction.Style.cancel) { _ in
            
            self.delegate?.handleReloadData()
            self.dismiss(animated: true)
        }
        
        alert.addAction(action)
        
        self.present(alert, animated: true)
    }
    
    func checkForm() {
        
        if activities.count == 0 && addCustomTextField.text == "" {
            addGoalButton.isEnabled = false
            UIView.animate(withDuration: 0.3) {
                self.addGoalButton.backgroundColor = UIColor.systemGray3
            }
        } else {
            addGoalButton.isEnabled = true
            UIView.animate(withDuration: 0.3) {
                self.addGoalButton.backgroundColor = UIColor.arcadiaGreen
            }
        }
    }
    
    func deselectHabit() {
        
        activities.removeAll()
        
        habitButton01.backgroundColor = .white
        habitButton01.setTitleColor(UIColor.black, for: .normal)
        matiinKeranAirTapped = false
        
        habitButton02.backgroundColor = .white
        habitButton02.setTitleColor(UIColor.black, for: .normal)
        matiinKeranAirTapped2 = false
        
        addCustomTextField.text = ""
        
        checkForm()
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .arcadiaGreen
        
        view.addSubview(roundedRectangel)
        roundedRectangel.anchor(left: view.leftAnchor, bottom: view.bottomAnchor)
        
        view.addSubview(addHabitTitle)
        addHabitTitle.centerX(inView: view)
        addHabitTitle.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 25)
        
        view.addSubview(circleView)
        circleView.centerX(inView: view)
        circleView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 63)
        
        circleView.addSubview(habitIcon)
        habitIcon.centerX(inView: circleView)
        habitIcon.centerY(inView: circleView)
        
        view.addSubview(categoryTitle)
        categoryTitle.anchor(top: circleView.bottomAnchor, left: view.leftAnchor, paddingLeft: 20)
        
        view.addSubview(waterButton)
        waterButton.anchor(top: categoryTitle.bottomAnchor, left: view.leftAnchor, paddingTop: 8, paddingLeft: 20)
        
        view.addSubview(electricityButton)
        electricityButton.anchor(top: categoryTitle.bottomAnchor, right: view.rightAnchor, paddingTop: 8, paddingRight: 20)
        
        view.addSubview(plantingButton)
        plantingButton.anchor(top: waterButton.bottomAnchor, left: view.leftAnchor, paddingTop: 8, paddingLeft: 20)
        
        view.addSubview(garbageButton)
        garbageButton.anchor(top: electricityButton.bottomAnchor, right: view.rightAnchor, paddingTop: 8, paddingRight: 20)
        
        view.addSubview(taskTitle)
        taskTitle.anchor(top: plantingButton.bottomAnchor, left: view.leftAnchor, paddingTop: 20, paddingLeft: 20)
        
        view.addSubview(habitButton01)
        habitButton01.anchor(top: taskTitle.bottomAnchor, left: view.leftAnchor, paddingTop: 16, paddingLeft: 20)
        habitButton01.centerX(inView: view)
        
        view.addSubview(habitButton02)
        habitButton02.anchor(top: habitButton01.bottomAnchor, left: view.leftAnchor, paddingTop: 12, paddingLeft: 20)
        habitButton02.centerX(inView: view)
        
        view.addSubview(addCustomTextField)
        addCustomTextField.anchor(top: habitButton02.bottomAnchor, left: view.leftAnchor, paddingTop: 12, paddingLeft: 20)
        addCustomTextField.centerX(inView: view)
        
        view.addSubview(addGoalButton)
        addGoalButton.anchor(top: addCustomTextField.bottomAnchor, left: view.leftAnchor, paddingTop: view.frame.width / 4.875, paddingLeft: 20)
        addGoalButton.centerX(inView: view)
    }
}

extension AddHabitController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        habitButton01.backgroundColor = .white
        habitButton01.setTitleColor(UIColor.black, for: .normal)
        matiinKeranAirTapped = false

        habitButton02.backgroundColor = .white
        habitButton02.setTitleColor(UIColor.black, for: .normal)
        matiinKeranAirTapped2 = false

        activities.removeAll()
        
        if addCustomTextField.text != "" {
            activities.append(addCustomTextField.text!)
        }
        
        checkForm()
        
        return textField.resignFirstResponder()
    }
    
    @objc func textFieldEditingChanged(_ textField: UITextField) {
        addGoalButton.isEnabled = textField.text != nil && textField.text!.isEmpty == false
        
        habitButton01.backgroundColor = .white
        habitButton01.setTitleColor(UIColor.black, for: .normal)
        matiinKeranAirTapped = false

        habitButton02.backgroundColor = .white
        habitButton02.setTitleColor(UIColor.black, for: .normal)
        matiinKeranAirTapped2 = false

        activities.removeAll()
        
        if addCustomTextField.text != "" {
            activities.append(addCustomTextField.text!)
        }
        
        checkForm()
    }
}

