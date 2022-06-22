//
//  AuthPopUpView.swift
//  MC2
//
//  Created by Stephen Giovanni Saputra on 20/06/22.
//

import UIKit

class AuthPopUpView: UIView {
    
    // MARK: - Properties
    private lazy var popUpLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsRegular(size: 14)
        label.textColor = .white
        label.text = "Oops, wrong email or password!"
        label.backgroundColor = UIColor.systemRed
        label.textAlignment = .left
        return label
    }()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        backgroundColor = .systemRed
        
        addSubview(popUpLabel)
        popUpLabel.centerY(inView: self)
//        popUpLabel.centerX(inView: self)
        popUpLabel.anchor(left: leftAnchor, paddingLeft: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    //MARK: - Helpers
    
}
