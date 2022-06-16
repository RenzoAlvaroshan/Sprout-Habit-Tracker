//
//  RewardView.swift
//  MC2
//
//  Created by Kevin Harijanto on 10/06/22.
//
import UIKit

class RewardView: UIView {

    // MARK: - Properties
    
    private lazy var experienceTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsRegular(size: 19)
        label.text = "110 / 200 XP"
        label.textColor = .black
        return label
    }()
    
    private lazy var rewardListTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsBold(size: 24)
        label.text = "Reward List"
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
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        addSubview(experienceTitle)
        experienceTitle.centerX(inView: self)
        experienceTitle.anchor(top: topAnchor, paddingTop: 75)
        
        addSubview(rewardListTitle)
        rewardListTitle.anchor(top: experienceTitle.bottomAnchor, left: leftAnchor, paddingTop: 20, paddingLeft: 25)
        
    }
}
