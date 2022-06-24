//
//  TestingViewController.swift
//  MC2
//
//  Created by Renzo Alvaroshan on 24/06/22.
//

import UIKit

class TestingViewController: UIViewController {
    
    //MARK: - Properties
    
    var selectChildView = SelectChildView()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.addSubview(selectChildView)
        selectChildView.setDimensions(height: view.frame.width / 1.175, width: view.frame.width / 1.147)
        selectChildView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }
}
