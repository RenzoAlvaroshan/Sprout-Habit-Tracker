//
//  TaskController.swift
//  MC2
//
//  Created by Suherda Dwi Santoso on 15/06/22.
//

import UIKit

class TaskControllerSuhe: UIViewController{
    
    //MARK: - Properties
    
    private let activityView = ActivityView()
    private let activityProgressView = ActivityProgressView()
    private let greetingsAndDate = GreetingsAndDate()
    private let taskProgressXPCircle = TaskProgressXPCircle()
    private let taskCircularXP = TaskCircularXPView()
    
    private var tableView = UITableView()
    var activities: [Activity] = []
    
    private let alert = UIAlertController(title: "Mark this task as done?", message: "Make sure your child implement the task correctly!", preferredStyle: UIAlertController.Style.alert)
    
    private let alert2 = UIAlertController(title: "Task Completed!", message: "", preferredStyle: UIAlertController.Style.alert)
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        activities = fetchData()
        configureTableView()
        
        alertOnTap()
        alertConfirmation()
        
        activityView.delegate = self
    }

    //MARK: - Selectors
    
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .arcadiaGreen
        
        view.addSubview(greetingsAndDate)
        greetingsAndDate.setDimensions(height: view.frame.height / 8, width: view.frame.width)
        greetingsAndDate.anchor(top: view.topAnchor, paddingTop: 90, paddingLeft: 20)
        
        view.addSubview(activityView)
        activityView.setDimensions(height: view.frame.height * 0.75, width: view.frame.width)
        activityView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
        view.addSubview(activityProgressView)
        activityProgressView.setDimensions(height: view.frame.height / 6, width: view.frame.height / 2.7)
        activityProgressView.centerX(inView: view)
        activityProgressView.anchor(top: view.topAnchor, paddingTop: 170)
        activityProgressView.setupShadow(opacity: 0.3, radius: 5, offset: CGSize(width: 1, height: 1), color: .black)
        
        view.addSubview(taskProgressXPCircle)
        taskProgressXPCircle.setDimensions(height: view.frame.height / 7, width: view.frame.height / 7)
        taskProgressXPCircle.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: 180, paddingLeft: 50)
        
        view.addSubview(taskCircularXP)
        taskCircularXP.centerX(inView: taskProgressXPCircle)
        taskCircularXP.centerY(inView: taskProgressXPCircle)
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.register(ActivityViewCell.self, forCellReuseIdentifier: "ActivityViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.anchor(top: activityProgressView.bottomAnchor,bottom: view.bottomAnchor,paddingTop: 115, width: view.frame.width-40)
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

extension TaskControllerSuhe: UITableViewDataSource, UITableViewDelegate {
    // Banyak row dalam 1 section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // Banyak section
    func numberOfSections(in tableView: UITableView) -> Int {
        return activities.count
    }
    
    // Isi dari cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityViewCell", for: indexPath) as! ActivityViewCell
        let reward = activities[indexPath.section]
        cell.set(reward: reward)
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
        return 20
    }
}

extension TaskControllerSuhe {
    func fetchData() -> [Activity] {
        let activity1 = Activity(activityName: "Matiin lampu jam 1", categoryName: "Electricity",checkImg: UIImage(systemName: "checkmark.circle.fill")!)
        let activity2 = Activity(activityName: "Buang sampah", categoryName: "Garbage",checkImg: UIImage(systemName: "checkmark.circle.fill")!)
        let activity3 = Activity(activityName: "Siram tanaman", categoryName: "Planting",checkImg: UIImage(systemName: "checkmark.circle.fill")!)
        let activity4 = Activity(activityName: "Memisahkan sampah plastik", categoryName: "Garbage",checkImg: UIImage(systemName: "checkmark.circle.fill")!)
        let activity5 = Activity(activityName: "Mengurangi pengunaan AC", categoryName: "Electricity",checkImg: UIImage(systemName: "checkmark.circle.fill")!)
        let activity6 = Activity(activityName: "Tidur siang", categoryName: "MOLOR",checkImg: UIImage(systemName: "checkmark.circle.fill")!)
        
        return [activity1,activity2,activity3,activity4,activity5,activity6]
    }
}

extension TaskControllerSuhe: ActivityViewDelegate {
    func handleAddActivity() {
        let controller = AddHabitController()
        controller.modalPresentationStyle = .popover
        present(controller, animated: true)
    }
}
