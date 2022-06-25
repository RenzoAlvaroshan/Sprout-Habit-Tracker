//
//  TaskController.swift
//  MC2
//
//  Created by Suherda Dwi Santoso on 15/06/22.
//

import UIKit
import Firebase

//protocol ActivityViewDelegate: AnyObject {
//    func handleAddActivityPush()
//}

class TaskController: UIViewController{
    
    //MARK: - Properties
    let controller = AddHabitController()
    
    let uid = Auth.auth().currentUser?.uid
    var childRef = 0 // ganti disini
    
    var child: [Child]? {
        didSet {
            configure()
        }
    }
    
    var activity: [Activity]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    private let activityProgressView = ActivityProgressView()
    private let greetingsAndDate = GreetingsAndDate()
    private let taskProgressXPCircle = TaskProgressXPCircle()
    private let taskCircularXP = TaskCircularXPView()
    
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
        label.text = "My Child's Goals"
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
    
    private var tableView = UITableView()
    
    private let alert = UIAlertController(title: "Mark this task as done?", message: "Make sure your child implement the task correctly!", preferredStyle: UIAlertController.Style.alert)
    
    private let alert2 = UIAlertController(title: "Task Completed!", message: "", preferredStyle: UIAlertController.Style.alert)
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controller.delegate = self
        
        fetchActivityData()
        
        configureUI()
        configureTableView()
            
        alertOnTap()
        alertConfirmation()
    }
    

    //MARK: - Selectors
    
    @objc func handleAddActivity() {
        controller.modalPresentationStyle = .popover
        present(controller, animated: true)
    }
    
    //MARK: - Helpers
    func fetchActivityData() {
        
        Service.fetchActivity(uid: uid!, childRef: childRef,completion: { activity in
            self.activity = activity
        })
    }
    
    func configure() {
    }
    
    func configureUI() {
        view.backgroundColor = .arcadiaGreen
        
        view.addSubview(roundedRectangel)
        roundedRectangel.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor)
        
        let stack = UIStackView(arrangedSubviews: [activityListTitle, addActivity])
        stack.axis = .horizontal
        stack.spacing = 110
        
        view.addSubview(stack)
        stack.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: view.frame.height / 2.7, paddingLeft: 20)
        
        view.addSubview(rewardListSubTitle)
        rewardListSubTitle.anchor(top: activityListTitle.bottomAnchor, left: view.leftAnchor, paddingTop: 5, paddingLeft: 25)
        
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
        self.tableView.rowHeight = 110
        tableView.register(ActivityViewCell.self, forCellReuseIdentifier: "ActivityViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.anchor(top: activityProgressView.bottomAnchor,bottom: view.bottomAnchor, paddingTop: 95, width: view.frame.width - 20)
        tableView.centerX(inView: view)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
//        tableView.backgroundColor = .systemPink
    }
    
    func alertOnTap() {
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: { [self]_ in
            present(alert2, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
    }
    
    func alertConfirmation() {
        self.alert2.addAction(UIAlertAction(title: "Got It!", style: UIAlertAction.Style.default, handler: nil))
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
//        print("DEBUG: activity: \(activity)")
        cell.cellCardView.set(activity: activity![indexPath.section])
        cell.backgroundColor = .white
        cell.clipsToBounds = false
        return cell
    }
    
    // Fungsi jika user tap
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        print("Hello \(indexPath.section)")
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //Nambahin footer & bikin jd clear
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    //Tinggi footer
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
}

extension TaskController: AddHabitControllerDelegate {
    func handleReloadData() {
        fetchActivityData()
        tableView.reloadData()
    }
}
