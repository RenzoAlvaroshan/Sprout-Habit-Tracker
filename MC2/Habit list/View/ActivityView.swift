//
//  ActivityView.swift
//  MC2
//
//  Created by Suherda Dwi Santoso on 15/06/22.
//


import UIKit

protocol ActivityViewDelegate: AnyObject {
    func handleAddActivity()
}

class ActivityView: UIView {

    // MARK: - Properties
    
    weak var delegate: ActivityViewDelegate?
    
    private lazy var activityListTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsBold(size: 24)
        label.text = "My Child's Goals"
        label.textColor = .black
        return label
    }()
    
    let addAttributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.poppinsRegular(size: 16),
        .foregroundColor: UIColor.arcadiaGreen,
    ]
    
    private lazy var addActivity: UIButton = {
        
        let attributeString = NSMutableAttributedString(
            string: "Add",
            attributes: addAttributes
        )

        let button = UIButton(type: .system)
        button.setAttributedTitle(attributeString, for: .normal)
        button.setTitleColor(UIColor.arcadiaGreen2, for: .normal)
        button.addTarget(self, action: #selector(handleAddActivy), for: .touchUpInside)
        return button
    }()
    
    private lazy var rewardListSubTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsRegular(size: 14)
        label.text = "1/4 Task Completed"
        label.textColor = .systemGray
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

    @objc func handleAddActivy() {
        delegate?.handleAddActivity()
    }


    // MARK: - Helpers

    func configureUI() {
        backgroundColor = .white
        
        layer.cornerRadius = 33
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        addSubview(activityListTitle)
        activityListTitle.anchor(top: topAnchor, left: leftAnchor, paddingTop: 125, paddingLeft: 25)
        
        addSubview(addActivity)
        addActivity.anchor(top: topAnchor, left: leftAnchor, paddingTop: 125, paddingLeft: 330)
        
        addSubview(rewardListSubTitle)
        rewardListSubTitle.anchor(top: activityListTitle.bottomAnchor, left: leftAnchor, paddingTop: 5, paddingLeft: 25)
        
    }
}
