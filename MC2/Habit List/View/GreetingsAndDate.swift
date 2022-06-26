//
//  GreetingsAndDate.swift
//  MC2
//
//  Created by Suherda Dwi Santoso on 15/06/22.
//

import UIKit
import Firebase

class GreetingsAndDate: UIView {

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

        configureUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors



    // MARK: - Helpers

    func configureUI() {
        
        greetings.text = "Hello, " + UserDefaults.standard.string(forKey: "childDataName")!
        
        let mytime = Date()
        let format = DateFormatter()
        format.timeStyle = .none
        format.dateStyle = .long
        let currentDate = format.string(from: mytime)
        
        format.dateFormat = "EEEE"
        let dayInWeek = format.string(from: mytime)

        dayAndDate.text = "\(dayInWeek), \(currentDate)"
  
        addSubview(greetings)
        greetings.anchor(top: topAnchor, left: leftAnchor, paddingTop: 0, paddingLeft: 25)
        
        addSubview(dayAndDate)
        dayAndDate.anchor(top: greetings.bottomAnchor, left: leftAnchor, paddingTop: 0, paddingLeft: 25)
    }
    
}
