//
//  ActivityCellCardView.swift
//  MC2
//
//  Created by Suherda Dwi Santoso on 23/06/22.
//

import UIKit

class ActivityCellCardView: UIView {
    

    // MARK: - Properties
    
    var activityName: UILabel = {
        var activityName = UILabel()
        activityName.numberOfLines = 0
        activityName.font = UIFont.poppinsBold(size: 17)
        activityName.adjustsFontSizeToFitWidth = true
        return activityName
    }()
    
     var categoryName: UILabel = {
        var categoryName = UILabel()
        categoryName.layer.borderWidth = 1.5
        categoryName.layer.borderColor = UIColor.arcadiaGreen.cgColor
        categoryName.layer.backgroundColor = UIColor.white.cgColor
        categoryName.layer.cornerRadius = 15
        categoryName.layer.masksToBounds = true
        categoryName.numberOfLines = 0
        categoryName.font = UIFont.poppinsRegular(size: 12)
        categoryName.adjustsFontSizeToFitWidth = true

        categoryName.setDimensions(height: 30, width: 120)
        categoryName.textAlignment = NSTextAlignment.center
        return categoryName
    }()
    
    var checkImg: UIImageView = {
        var checkImg = UIImageView()
        checkImg.image = UIImage(named: "checkmark.circle.fill")
        checkImg.clipsToBounds = true
        checkImg.tintColor = .systemGray4
        return checkImg
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
        layer.cornerRadius = 20
        
        addSubview(activityName)
        activityName.anchor(top: topAnchor,left: leftAnchor,paddingTop: 10, paddingLeft: 25)

        addSubview(categoryName)
        categoryName.anchor(top: activityName.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, paddingTop: 5, paddingLeft: 25, paddingBottom: 15)
        
        addSubview(checkImg)
        checkImg.anchor(right: rightAnchor, paddingRight: 20)
        checkImg.centerY(inView: self)
        checkImg.anchor( width: 32, height: 32)
        
    }
    
    func set(activity: Activity) {
        activityName.text = activity.activityName
        categoryName.text = activity.category
    }
}
