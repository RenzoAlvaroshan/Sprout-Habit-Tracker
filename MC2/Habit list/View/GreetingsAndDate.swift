//
//  GreetingsAndDate.swift
//  MC2
//
//  Created by Suherda Dwi Santoso on 15/06/22.
//

import UIKit

class GreetingsAndDate: UIView {

    // MARK: - Properties
    
    private lazy var greetings: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsBold(size: 29)
        label.text = "Good Morning"
        label.textColor = .white
        return label
    }()
    
    private lazy var dayAndDate: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsRegular(size: 18)
        label.text = "Wednesday, 8 June 2022"
        label.textColor = .white
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



    // MARK: - Helpers

    func configureUI() {
  
        addSubview(greetings)
        greetings.anchor(top: topAnchor, left: leftAnchor, paddingTop: 0, paddingLeft: 25)
        
        addSubview(dayAndDate)
        dayAndDate.anchor(top: greetings.bottomAnchor, left: leftAnchor, paddingTop: 0, paddingLeft: 25)
        
    }
}
