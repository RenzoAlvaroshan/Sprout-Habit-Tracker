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
        cellCardView.setupShadow(opacity: 0.2, radius: 5, offset: CGSize(width: 1, height: 1), color: .arcadiaGreen)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
