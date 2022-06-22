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
    let cellCardView = ActivityCellCardView()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(cellCardView)
        cellCardView.setDimensions(height: 100, width: UIScreen.main.bounds.width - 40)
        cellCardView.centerX(inView: contentView)
        cellCardView.anchor(top: contentView.topAnchor, paddingTop: 5)
        cellCardView.setupShadow(opacity: 0.3, radius: 5, offset: CGSize(width: 1, height: 1), color: .black)
//        addSubview(activityName)
//        addSubview(categoryName)
//        addSubview(checkImg)
//
//        configureActivityName()
//        configureCategoryName()
//        configureCell()
//        configureImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    // MARK: - Helpers
//
//    func set(activity: Activity) {
//        activityName.text = activity.activityName
//        categoryName.text = activity.categoryName
//        checkImg.image = activity.checkImg
//    }
//
//    func configureCell() {
//        layer.cornerRadius = frame.height / 2
//        layer.masksToBounds = true
//        layer.borderColor = UIColor.systemGray3.cgColor
//        layer.borderWidth = 0.4
//
//        layer.shadowRadius = 3
//        layer.shadowOpacity = 0.5
//        layer.shadowColor = UIColor.systemGray2.cgColor
//        layer.shadowOffset = CGSize(width: 0, height: 0)
//    }
//
//    func configureActivityName() {
//        activityName.numberOfLines = 0
//        activityName.font = UIFont.poppinsBold(size: 18)
//        activityName.adjustsFontSizeToFitWidth = true
//        activityName.anchor(top: topAnchor,left: leftAnchor,paddingTop: 10, paddingLeft: 25)
//    }
//
//    func configureCategoryName() {
//        categoryName.layer.borderWidth = 1.5
//        categoryName.layer.borderColor = UIColor.arcadiaGreen.cgColor
//        categoryName.layer.backgroundColor = UIColor.white.cgColor
//        categoryName.layer.cornerRadius = 15
//        categoryName.layer.masksToBounds = true
//        categoryName.numberOfLines = 0
//        categoryName.font = UIFont.poppinsRegular(size: 18)
//        categoryName.adjustsFontSizeToFitWidth = true
//        categoryName.anchor(top: activityName.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, paddingTop: 5, paddingLeft: 25, paddingBottom: 15)
//        categoryName.setDimensions(height: 30, width: 120)
//        categoryName.textAlignment = NSTextAlignment.center
//
//    }
//
//    func configureImage() {
//        checkImg.clipsToBounds = true
//        checkImg.tintColor = .systemGray4
//        checkImg.anchor(right: rightAnchor, paddingRight: 20)
//        checkImg.centerY(inView: self)
//        checkImg.anchor( width: 32, height: 32)
//    }
//
}
