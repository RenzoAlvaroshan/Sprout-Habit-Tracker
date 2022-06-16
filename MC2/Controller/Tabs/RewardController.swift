//
//  RewardController.swift
//  MC2
//
//  Created by Kevin Harijanto on 10/06/22.
//
import UIKit

class RewardController: UIViewController{
    
    //MARK: - Properties
    
    private let rewardView = RewardView()
    private let progressView = ProgressView()
    private let circularXP = CircularXPView()
    
    private var tableView = UITableView()
    var rewards: [Reward] = []
    
    private let alert = UIAlertController(title: "Claim the Reward", message: "Your child will experience the reward of a task completed.", preferredStyle: UIAlertController.Style.alert)
    
    private let alert2 = UIAlertController(title: "Reward Claimed!", message: "", preferredStyle: UIAlertController.Style.alert)
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        rewards = fetchData()
        configureTableView()
        
        alertOnTap()
        alertConfirmation()
    }

    //MARK: - Selectors
    
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .arcadiaGreen
        
        view.addSubview(rewardView)
        rewardView.setDimensions(height: view.frame.height * 0.75, width: view.frame.width)
        rewardView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
        view.addSubview(progressView)
        progressView.setDimensions(height: view.frame.height / 4.9, width: view.frame.height / 4.9)
        progressView.centerX(inView: view)
        progressView.anchor(top: view.topAnchor, paddingTop: 90)
        
        view.addSubview(circularXP)
        circularXP.centerX(inView: view)
        circularXP.centerY(inView: progressView)
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.register(RewardCell.self, forCellReuseIdentifier: "RewardCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.anchor(top: progressView.bottomAnchor,bottom: view.bottomAnchor,paddingTop: 115, width: view.frame.width-40)
        tableView.centerX(inView: view)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
//        tableView.backgroundColor = .systemPink
    }
    
    func alertOnTap() {
        alert.addAction(UIAlertAction(title: "Claim", style: UIAlertAction.Style.default, handler: { [self]_ in
            present(alert2, animated: true, completion: nil)
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
    }
    
    func alertConfirmation() {
        self.alert2.addAction(UIAlertAction(title: "Got It!", style: UIAlertAction.Style.default, handler: nil))
    }
}

extension RewardController: UITableViewDataSource, UITableViewDelegate {
    // Banyak row dalam 1 section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // Banyak section
    func numberOfSections(in tableView: UITableView) -> Int {
        return rewards.count
    }
    
    // Isi dari cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RewardCell", for: indexPath) as! RewardCell
        let reward = rewards[indexPath.section]
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

extension RewardController {
    func fetchData() -> [Reward] {
        let reward1 = Reward(levelName: "Level 1", rewardName: "Petik buah 1",checkLock: UIImage(systemName: "lock.fill")!)
        let reward2 = Reward(levelName: "Level 2", rewardName: "Petik buah 2",checkLock: UIImage(systemName: "lock.fill")!)
        let reward3 = Reward(levelName: "Level 3", rewardName: "Petik buah 3",checkLock: UIImage(systemName: "lock.fill")!)
        let reward4 = Reward(levelName: "Level 4", rewardName: "Petik buah 4",checkLock: UIImage(systemName: "lock.fill")!)
        let reward5 = Reward(levelName: "Level 5", rewardName: "Petik buah 5",checkLock: UIImage(systemName: "lock.fill")!)
        let reward6 = Reward(levelName: "Level 6", rewardName: "Petik buah 6",checkLock: UIImage(systemName: "lock.fill")!)
        
        return [reward1,reward2,reward3,reward4,reward5,reward6]
    }
}
