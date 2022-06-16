//
//  TableViewCell.swift
//  MC2
//
//  Created by Kevin Harijanto on 13/06/22.
//
import UIKit

class RewardCell: UITableViewCell {
    
    // MARK: - Properties
    
    var levelName = UILabel()
    var rewardName = UILabel()
    var checkLock = UIImageView()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(levelName)
        addSubview(rewardName)
        addSubview(checkLock)
        
        configureLevelName()
        configureTaskName()
        configureCell()
        configureImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func set(reward: Reward) {
        levelName.text = reward.levelName
        rewardName.text = reward.rewardName
        checkLock.image = reward.checkLock
    }
    
    func configureCell() {
        layer.cornerRadius = frame.height / 2
        layer.masksToBounds = true
        layer.borderColor = UIColor.systemGray3.cgColor
        layer.borderWidth = 0.4
        
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.5
        layer.shadowColor = UIColor.systemGray2.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    func configureLevelName() {
        levelName.numberOfLines = 0
        levelName.font = UIFont.poppinsBold(size: 18)
        levelName.adjustsFontSizeToFitWidth = true
        levelName.anchor(top: topAnchor,left: leftAnchor,paddingTop: 10, paddingLeft: 25)
    }
    
    func configureTaskName() {
        rewardName.numberOfLines = 0
        rewardName.font = UIFont.poppinsRegular(size: 18)
        rewardName.adjustsFontSizeToFitWidth = true
        rewardName.anchor(top: levelName.bottomAnchor,left: leftAnchor,bottom: bottomAnchor, paddingLeft: 25, paddingBottom: 15)
    }
    
    func configureImage() {
        checkLock.clipsToBounds = true
        checkLock.tintColor = .arcadiaGreen
        checkLock.anchor(right: rightAnchor, paddingRight: 20)
        checkLock.centerY(inView: self)
        checkLock.anchor( width: 32, height: 32)
    }
    
}
