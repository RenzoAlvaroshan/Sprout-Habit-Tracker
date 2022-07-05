//
//  TaskProgressXPCircle.swift
//  MC2
//
//  Created by Suherda Dwi Santoso on 20/06/22.
//

import UIKit

class TaskProgressXPCircle: UIView {
    

    // MARK: - Properties
    private lazy var levelTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsSemiBold(size: 13)
        label.textColor = .black
        label.text = "Level"
        return label
    }()
    
    private lazy var level: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsBold(size: 25)
        label.textColor = .black
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
        backgroundColor = .white
//        layer.cornerRadius = UIScreen.main.bounds.height / 14
        
        let stack = UIStackView(arrangedSubviews: [levelTitleLabel, level])
        stack.alignment = .center
        stack.spacing = -3
        stack.axis = .vertical
        
        addSubview(stack)
        stack.centerX(inView: self)
        stack.centerY(inView: self)
        let xp = UserDefaults.standard.integer(forKey: "childDataExperience")
        let levelnow = xp / 100 + 1
        let currentLevel = String(levelnow)
        level.text = currentLevel
    }
}

