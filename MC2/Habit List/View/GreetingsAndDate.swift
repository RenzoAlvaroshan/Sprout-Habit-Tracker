//
//  GreetingsAndDate.swift
//  MC2
//
//  Created by Suherda Dwi Santoso on 15/06/22.
//

import UIKit
import Firebase

class GreetingsAndDate: UIView {
    
    var child: [Child]? {
        didSet {
            configure()
        }
    }

    // MARK: - Properties
    
    private lazy var greetings: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsBold(size: 29)
        label.textColor = .white
        return label
    }()
    
    private lazy var dayAndDate: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsRegular(size: 18)
        label.textColor = .white
        return label
    }()


    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        fetchChildrenData()
        configureUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors



    // MARK: - Helpers
    
    func fetchChildrenData() {
        let uid = Auth.auth().currentUser?.uid
        var childRef = UserDefaults.standard.object(forKey: "childRef")
        
        Service.fetchChildrenData(uid: uid!, childRef: childRef as! Int, completion: { child in
            self.child = child
        })
    }
    
    func configure() {
//        let childname = UserDefaults.standard.object(forKey: "childName") as! String
//        greetings.text = "Hello, " + childname
        greetings.text = "Hello, " + child![0].name
        
        let mytime = Date()
        let format = DateFormatter()
        format.timeStyle = .none
        format.dateStyle = .long
        let currentDate = format.string(from: mytime)
        
        format.dateFormat = "EEEE"
        let dayInWeek = format.string(from: mytime)

        dayAndDate.text = "\(dayInWeek), \(currentDate)"
    }

    func configureUI() {
  
        addSubview(greetings)
        greetings.anchor(top: topAnchor, left: leftAnchor, paddingTop: 0, paddingLeft: 25)
        
        addSubview(dayAndDate)
        dayAndDate.anchor(top: greetings.bottomAnchor, left: leftAnchor, paddingTop: 0, paddingLeft: 25)
    }
    
}
