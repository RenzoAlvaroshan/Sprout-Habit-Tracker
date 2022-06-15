//
//  ActivityViewCell.swift
//  MC2
//
//  Created by Suherda Dwi Santoso on 15/06/22.
//

import UIKit

class ActivityViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    var activityName = UILabel()
    var categoryName = UILabel()
    var checkImg = UIImageView()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(activityName)
        addSubview(categoryName)
        addSubview(checkImg)
        
        configureActivityName()
        configureCategoryName()
        configureCell()
        configureImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func set(reward: Activity) {
        activityName.text = reward.activityName
        categoryName.text = reward.categoryName
        checkImg.image = reward.checkImg
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
    
    func configureActivityName() {
        activityName.numberOfLines = 0
        activityName.font = UIFont.poppinsBold(size: 18)
        activityName.adjustsFontSizeToFitWidth = true
        activityName.anchor(top: topAnchor,left: leftAnchor,paddingTop: 10, paddingLeft: 25)
    }
    
    func configureCategoryName() {
        categoryName.backgroundColor = .arcadiaGreen2
        categoryName.numberOfLines = 0
        categoryName.font = UIFont.poppinsRegular(size: 18)
        categoryName.adjustsFontSizeToFitWidth = true
        categoryName.anchor(top: activityName.bottomAnchor,left: leftAnchor,bottom: bottomAnchor, paddingLeft: 25, paddingBottom: 15)
    }
    
    func configureImage() {
        checkImg.clipsToBounds = true
        checkImg.tintColor = .systemGray4
        checkImg.anchor(right: rightAnchor, paddingRight: 20)
        checkImg.centerY(inView: self)
        checkImg.anchor( width: 32, height: 32)
    }
    
}
