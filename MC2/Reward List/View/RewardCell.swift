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
    
    let cellCardView = RewardCellCardView()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(cellCardView)
        cellCardView.setDimensions(height: 75, width: UIScreen.main.bounds.width - 40)
        cellCardView.centerX(inView: contentView)
        cellCardView.anchor(top: contentView.topAnchor, paddingTop: 5)
        cellCardView.setupShadow(opacity: 0.2, radius: 5, offset: CGSize(width: 1, height: 1), color: .arcadiaGreen)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
