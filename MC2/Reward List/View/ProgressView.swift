//
//  ProgressView.swift
//  MC2
//
//  Created by Kevin Harijanto on 10/06/22.
//
import UIKit

class ProgressView: UIView {
    

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
        layer.cornerRadius = 86
    }
}
