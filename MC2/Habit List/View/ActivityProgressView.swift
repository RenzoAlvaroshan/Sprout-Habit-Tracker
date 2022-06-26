//
//  ActivityActivityProgressView.swift
//  MC2
//
//  Created by Suherda Dwi Santoso on 15/06/22.
//

import UIKit

class ActivityProgressView: UIView {
    

    // MARK: - Properties
    
    private lazy var streakTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsBold(size: 18)
        label.text = "5 Days Streak!"
        label.textColor = .black
        return label
    }()
    
    private lazy var experienceTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsRegular(size: 15)
        let xp = UserDefaults.standard.integer(forKey: "childDataExperience")
        let xpDisplayed = xp%100 // ganti pembagi disini
        label.text = "\(xpDisplayed) / 100 XP"
        label.textColor = .black
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
        backgroundColor = .white
        layer.cornerRadius = 33
        
        addSubview(streakTitle)
        streakTitle.anchor(top: topAnchor, left: leftAnchor, paddingTop: 45, paddingLeft: 140)
        
        addSubview(experienceTitle)
        experienceTitle.anchor(top: streakTitle.bottomAnchor, left: leftAnchor, paddingTop: 5, paddingLeft: 140)
        
       
        
    }
}
