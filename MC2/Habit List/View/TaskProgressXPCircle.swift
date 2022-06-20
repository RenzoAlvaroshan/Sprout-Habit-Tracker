//
//  TaskProgressXPCircle.swift
//  MC2
//
//  Created by Suherda Dwi Santoso on 20/06/22.
//

import UIKit

class TaskProgressXPCircle: UIView {
    

    // MARK: - Properties
    

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
        layer.cornerRadius = UIScreen.main.bounds.height / 14
    }
}

