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
        label.backgroundColor = UIColor.systemRed
        label.textAlignment = .left
        return label
    }()
    
    var messageBody: String = "" {
        didSet {
            popUpLabel.text = messageBody
        }
    }
    
    //MARK: - Lifecycle
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        commonInit()
    }
    
    override func awakeFromNib() {
        setupMessageBody()
    }
    
    private func commonInit() {
        backgroundColor = .systemRed
        addSubview(popUpLabel)
        popUpLabel.centerY(inView: self)
        popUpLabel.anchor(left: leftAnchor, paddingLeft: 12)
        
        setupMessageBody()
    }
    
    
    //MARK: - Selectors
    
    
    //MARK: - Helpers
    func setupMessageBody() {
        popUpLabel.text = messageBody
    }
}
