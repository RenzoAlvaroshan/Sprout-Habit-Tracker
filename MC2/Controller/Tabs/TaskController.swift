//
//  TaskController.swift
//  MC2
//
//  Created by Suherda Dwi Santoso on 15/06/22.
//

import UIKit
import Firebase

class TaskController: UIViewController{
    
    //MARK: - Properties
    var controller = AddHabitController()
    let controllerModal = DoneDeleteModal()
    
    let sceneDelegate = UIApplication.shared.connectedScenes.first
    
    var activity: [Activity]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    var ref: Int = 0
    
    private let activityProgressView = ActivityProgressView()
    private let greetingsAndDate = GreetingsAndDate()
    private let taskProgressXPCircle = TaskProgressXPCircle()
    private let taskCircularXP = TaskCircularXPView()
    private let doneDeleteModal = DoneDeleteModal()
    
    private lazy var roundedRectangel: UIView = {
        let rect = UIView()
        rect.setDimensions(height: view.frame.height / 1.51, width: view.frame.width)
        rect.layer.cornerRadius = 33
        rect.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        rect.backgroundColor = .white
        return rect
    }()
    
//    weak var delegate: ActivityViewDelegate?
    
    private lazy var activityListTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsBold(size: 24)
        label.text = "Child’s To Do List"
        label.textColor = .black
        return label
    }()
    
    let addAttributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.poppinsRegular(size: 16),
        .foregroundColor: UIColor.arcadiaGreen,
    ]
    
    private lazy var addActivity: UIButton = {
        
        let attributeString = NSMutableAttributedString(
            string: "Add",
            attributes: addAttributes
        )

        let button = UIButton(type: .system)
        button.setAttributedTitle(attributeString, for: .normal)
        button.setTitleColor(UIColor.arcadiaGreen2, for: .normal)
        button.addTarget(self, action: #selector(handleAddActivity), for: .touchUpInside)
        return button
    }()
    
    private lazy var rewardListSubTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsRegular(size: 14)
        label.text = "1/4 Task Completed"
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var emptyStateImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "emptyState")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = .systemGray3 // will add more icon
        iv.setDimensions(height: view.frame.width / 1.35, width: view.frame.width / 1.35)
        return iv
    }()
    
    private let background: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "TabBarBG")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private var tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controller.delegate = self
        controllerModal.delegate = self
        view.backgroundColor = .arcadiaGreen
        
        view.addSubview(background)
        background.centerX(inView: view)
        background.centerY(inView: view)
        background.setDimensions(height: view.frame.height, width: view.frame.width)
        
        view.addSubview(roundedRectangel)
        roundedRectangel.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor)
        configureUI()

        Task.init {
            let currentChildUid = UserDefaults.standard.string(forKey: "childCurrentUid")
            let activityArray = try await Service.fetchActivity(childUid: currentChildUid!)
            self.activity = activityArray
            let numberOfTask = activity!.count as Int
            let numberOfTaskCompleted = activity!.filter { $0.isFinished == true }.count
            rewardListSubTitle.text = "\(numberOfTaskCompleted)/\(numberOfTask) Task Completed"
            
            if numberOfTask == 0 {
                view.addSubview(emptyStateImage)
                emptyStateImage.centerX(inView: view)
                emptyStateImage.anchor(
                    top: rewardListSubTitle.bottomAnchor,
                    paddingTop: 0
                )
            } else {
                configureTableView()
            }
        }
    }
    

    //MARK: - Selectors
    
    @objc func handleAddActivity() {
        
        if activity!.filter({ $0.isFinished == true }).count == (activity!.count as Int) &&
            (activity!.count as Int) != 0 {
            
            let alert = UIAlertController(title: "Daily Mission Complete!", message: "Come Back Tomorrow", preferredStyle: .alert)
            alert.view.tintColor = .arcadiaGreen
            
            let action = UIAlertAction(title: "OK", style: .cancel)
            alert.addAction(action)
            
            self.present(alert, animated: true)
            
        } else {
            controller.modalPresentationStyle = .popover
            present(controller, animated: true)
        }
    }
    
    //MARK: - Helpers

    func configureUI() {
        
        let stack = UIStackView(arrangedSubviews: [activityListTitle, addActivity])
        stack.axis = .horizontal
        stack.spacing = 110
        
        view.addSubview(stack)
        stack.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: view.frame.height / 2.7, paddingLeft: 20)
        
        view.addSubview(rewardListSubTitle)
        rewardListSubTitle.anchor(top: activityListTitle.bottomAnchor, left: view.leftAnchor, paddingTop: 5, paddingLeft: 20)
        
        view.addSubview(greetingsAndDate)
        greetingsAndDate.setDimensions(height: view.frame.height / 8, width: view.frame.width)
        greetingsAndDate.anchor(top: view.topAnchor, paddingTop: 75, paddingLeft: 20)

        
        view.addSubview(activityProgressView)
        activityProgressView.setDimensions(height: view.frame.height / 6, width: view.frame.height / 2.7)
        activityProgressView.centerX(inView: view)
        activityProgressView.anchor(top: view.topAnchor, paddingTop: 155)
        activityProgressView.setupShadow(opacity: 0.2, radius: 5, offset: CGSize(width: 1, height: 1), color: .arcadiaGreen)
        
        view.addSubview(taskProgressXPCircle)
        taskProgressXPCircle.setDimensions(height: view.frame.height / 7, width: view.frame.height / 7)
        taskProgressXPCircle.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: 165, paddingLeft: 50)
        
        view.addSubview(taskCircularXP)
        taskCircularXP.centerX(inView: taskProgressXPCircle)
        taskCircularXP.centerY(inView: taskProgressXPCircle)
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        self.tableView.rowHeight = 100
        tableView.backgroundColor = .clear
        
        tableView.register(ActivityViewCell.self, forCellReuseIdentifier: "ActivityViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.anchor(top: activityProgressView.bottomAnchor,bottom: view.bottomAnchor, paddingTop: 95, width: view.frame.width)
        tableView.centerX(inView: view)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.layer.masksToBounds = true
        tableView.layer.shadowColor = UIColor.arcadiaGreen.cgColor
        tableView.layer.shadowOpacity = 0.2
        tableView.layer.shadowRadius = 5
        tableView.layer.shadowOffset = .init(width: 1, height: 1)
    }
}

extension TaskController: UITableViewDataSource, UITableViewDelegate {
    // Banyak row dalam 1 section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // Banyak section
    func numberOfSections(in tableView: UITableView) -> Int {
        return activity?.count ?? 0
    }
    
    // Isi dari cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityViewCell", for: indexPath) as! ActivityViewCell
        cell.cellCardView.set(activity: activity![indexPath.section])
        cell.backgroundColor = .white
        cell.selectionStyle = .none
        cell.clipsToBounds = false
        return cell
    }
    
    // Fungsi jika user tap
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ref = indexPath.section
        tableView.deselectRow(at: indexPath, animated: true)
        
        controllerModal.activityName.text = activity![ref].activityName
        controllerModal.categoryName.text = activity![ref].category
        controllerModal.ref = self.ref
        
        // change button color and tappable if already finished
        if activity![ref].isFinished == false{
            controllerModal.markAsDoneButton.isEnabled = true
            controllerModal.markAsDoneButton.backgroundColor = .arcadiaGreen
        } else{
            controllerModal.markAsDoneButton.isEnabled = false
            controllerModal.markAsDoneButton.backgroundColor = .systemGray3
        }
        
        // change button color and tappable if already all finished
        if activity!.filter({ $0.isFinished == true }).count == (activity!.count as Int) && (activity!.count as Int) != 0
        {
            controllerModal.deleteTaskButton.isEnabled = false
        }
        
        controllerModal.modalPresentationStyle = .pageSheet
        if let sheet = controllerModal.sheetPresentationController
        {
            sheet.detents = [.medium()]
        }
        present(controllerModal, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let alert = UIAlertController(title: "Delete this task?", message: "Are you sure you want to delete this task?", preferredStyle: UIAlertController.Style.alert)
            alert.view.tintColor = UIColor.arcadiaGreen
            
            let action = UIAlertAction(title: "Delete", style: UIAlertAction.Style.default) { [self] _ in
                
                tableView.beginUpdates()
                
                Service.deleteActivityData(ref: ref)
                { error in
                    print("DEBUG: error is \(String(describing: error))")
                }
                tableView.deleteRows(at: [indexPath], with: .left)
                tableView.deleteSections(IndexSet(integer: indexPath.section), with: .left)
                activity?.remove(at: indexPath.section)
                handleReloadDataModal()
                
                tableView.endUpdates()
            }
            
            alert.addAction(action)
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
            
            self.present(alert, animated: true)
        }
    }
}

extension TaskController: AddHabitControllerDelegate {
    func handleReloadData() {
        //remove image
        emptyStateImage.removeFromSuperview()
        Task.init {
            let currentChildUid = UserDefaults.standard.string(forKey: "childCurrentUid")
            let activityArray = try await Service.fetchActivity(childUid: currentChildUid!)
            self.activity = activityArray
            let numberOfTask = activity!.count as Int
            let numberOfTaskCompleted = activity!.filter { $0.isFinished == true }.count
            rewardListSubTitle.text = "\(numberOfTaskCompleted)/\(numberOfTask) Task Completed"
            configureTableView()
            tableView.reloadData()
        }
    }
}

extension TaskController: DoneDeleteModalDelegate {
    func handleReloadDataModal() {
        let currentChildUid = UserDefaults.standard.string(forKey: "childCurrentUid")

        Task.init {
            let activityArray = try await Service.fetchActivity(childUid: currentChildUid!)
            self.activity = activityArray
            let numberOfTask = activity!.count as Int
            let numberOfTaskCompleted = activity!.filter { $0.isFinished == true }.count
            rewardListSubTitle.text = "\(numberOfTaskCompleted)/\(numberOfTask) Task Completed"
            
            if activity!.filter({ $0.isFinished == true }).count == (activity!.count as Int) &&
                (activity!.count as Int) != 0
            {
                print("DEBUG: Selesai semua")
                
                let experience = UserDefaults.standard.integer(forKey: "childDataExperience") + 30
                Service.updateExperience(experience: experience)
                { error in
                    print("DEBUG: error is \(String(describing: error))")
                }
                UserDefaults.standard.set(experience, forKey: "childDataExperience")
            }
            
            configureTableView()
            if let scene: SceneDelegate = (self.sceneDelegate?.delegate as? SceneDelegate)
            {
                scene.setToMain()
            }
        }
    }
}

// tambah Exp


