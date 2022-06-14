//
//  OnboardingViewController.swift
//  MC2
//
//  Created by Stephen Giovanni Saputra on 13/06/22.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    // MARK: - Properties
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsSemiBold(size: 24)
        label.textColor = .black
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsRegular(size: 18)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    //MARK: - Lifecycle
    init(imageName: String, titleText: String, subtitleText: String) {
        
        super.init(nibName: nil, bundle: nil)
        imageView.image = UIImage(named: imageName)
        titleLabel.text = titleText
        subtitleLabel.text = subtitleText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented!")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Selectors
    
    //MARK: - Helpers
    func configureUI() {
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        
        view.addSubview(stackView)
        stackView.anchor(top: view.topAnchor, paddingTop: 100)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            imageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0 > 20 ? 1 : 0.75),
            
            subtitleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: subtitleLabel.trailingAnchor, multiplier: 2),
        ])
    }
}
