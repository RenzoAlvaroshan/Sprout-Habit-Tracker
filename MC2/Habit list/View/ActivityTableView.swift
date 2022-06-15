//
//  ActivityTableView.swift
//  MC2
//
//  Created by Suherda Dwi Santoso on 15/06/22.
//

import UIKit

class ActivityTableView: UIViewController {
    
    private var tableView = UITableView()
    var rewards: [Activity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        rewards = fetchData()
        configureTableView()
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.register(ActivityViewCell.self, forCellReuseIdentifier: "ActivityViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 80
        tableView.anchor(bottom: view.bottomAnchor,paddingTop: 10, width: UIScreen.main.bounds.size.width-40)
        tableView.centerX(inView: view)
        tableView.backgroundColor = .systemPink
    }
}

extension ActivityTableView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rewards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityViewCell", for: indexPath) as! ActivityViewCell
        let reward = rewards[indexPath.row]
        cell.set(reward: reward)
        
//        cell.backgroundColor = .arcadiaGreen
        return cell
    }
}
