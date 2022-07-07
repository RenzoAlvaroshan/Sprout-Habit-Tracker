//
//  RewardCellCardView.swift
//  MC2
//
//  Created by Suherda Dwi Santoso on 23/06/22.
//

import UIKit

class RewardCellCardView: UIView {
    

    // MARK: - Properties
    
    var levelName: UILabel = {
        var levelName = UILabel()
        levelName.numberOfLines = 0
        levelName.font = UIFont.poppinsBold(size: 15)
        levelName.adjustsFontSizeToFitWidth = true
        return levelName
    }()
    
     var rewardName: UILabel = {
        var rewardName = UILabel()
         rewardName.numberOfLines = 0
        rewardName.font = UIFont.poppinsRegular(size: 14)
        rewardName.adjustsFontSizeToFitWidth = false
        return rewardName
    }()
    
    var checkLock: UIImageView = {
        var checkLock = UIImageView()
        checkLock.clipsToBounds = true
        checkLock.tintColor = .arcadiaGreen
        return checkLock
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
        layer.cornerRadius = 15
        
        addSubview(levelName)
        levelName.anchor(top: topAnchor,left: leftAnchor,paddingTop: 15, paddingLeft: 20)

        addSubview(rewardName)
        rewardName.anchor(top: levelName.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, paddingTop: 5, paddingLeft: 20, paddingBottom: 15)
        
        addSubview(checkLock)
        checkLock.anchor(right: rightAnchor, paddingRight: 20)
        checkLock.centerY(inView: self)
        checkLock.anchor(width: 25, height: 25)
        
    }
    
    func set(reward: RewardList) {
        levelName.text = reward.levelName
        rewardName.text = reward.rewardName
        checkLock.image = reward.checkLock
    }
}
