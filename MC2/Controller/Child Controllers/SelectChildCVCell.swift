//
//  SelectChildCVCell.swift
//  MC2
//
//  Created by Kevin Harijanto on 26/06/22.
//

import UIKit

//protocol TweetCellDelegate: AnyObject {
//    func handleProfileImageTapped(_ cell: TweetCell)
//}

class SelectChildCVCell: UICollectionViewCell {
    
    // MARK: - Properties
//    var tweet: Tweet? {
//        didSet{ configure() }
//    }
    var nameTapped = false
    var tapChild: String = ""


//    weak var delegate: TweetCellDelegate?
    
    var childImg: UIImageView = {
        let childImg = UIImageView()
        childImg.contentMode = .scaleAspectFit
        childImg.clipsToBounds = true
//        childImg.setDimensions(height: 90 , width: 90)
//        childImg.layer.cornerRadius = 90 / 2
        childImg.backgroundColor = .arcadiaGreen
        
//        let tap = UITapGestureRecognizer(target: childImg.self, action: #selector(handleProfileImageTapped))
//        childImg.addGestureRecognizer(tap)
//        childImg.isUserInteractionEnabled = true
        
        return childImg
    }()
    
    private lazy var childName: UIButton = {
        let childName = UIButton()
        childName.backgroundColor = .white
        childName.layer.borderWidth = 1
        childName.layer.borderColor = UIColor.arcadiaGreen.cgColor
        childName.layer.cornerRadius = 10
        childName.layer.shadowOpacity = 0.14
        childName.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        childName.setDimensions(height: 30 , width: 100)
        childName.setTitle("Water", for: .normal)
        childName.setTitleColor(UIColor.black, for: .normal)
        childName.titleLabel?.font = UIFont.poppinsMedium(size: 18)
        childName.titleLabel?.textAlignment = .center
        childName.addTarget(self, action: #selector(handleName), for: .touchUpInside)
        return childName
    }()
    
    func configureColletionItems() {
        
        layer.backgroundColor = UIColor.white.cgColor
        layer.cornerRadius = frame.width / 4
//        layer.borderWidth = 2
//        layer.borderColor = UIColor.arcadiaGreen.cgColor
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = frame.width / 4
//        contentView.layer.borderWidth = 2
//        contentView.layer.borderColor = UIColor.arcadiaGreen.cgColor
        
    }

    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        let stack = UIStackView(arrangedSubviews: [childImg, childName])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 12
        
        contentView.addSubview(stack)
        stack.centerX(inView: contentView)
        stack.centerY(inView: contentView)
        
        configureColletionItems()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc func handleName() {
        print("DEBUG: name tapped")
        nameTapped = !nameTapped
        if nameTapped && nameTapped == true {
            tapChild = childName.currentTitle!
            
            childName.backgroundColor = .arcadiaGreen
            childName.setTitleColor(UIColor.white, for: .normal)
        }
        else {
            childName.backgroundColor = .white
            childName.setTitleColor(UIColor.black, for: .normal)
        }
    }
    
    @objc func handleProfileImageTapped() {
        print("BUTTON DEBUG")
        nameTapped = !nameTapped
        if nameTapped {
//            tapChild = childName.text!
            
            childName.backgroundColor = .arcadiaGreen2
            childName.layer.borderColor = UIColor.arcadiaGreen.cgColor
            childName.layer.borderWidth = 2
        }
        
    }
    
    
    // MARK: - Helpers
    
    func set(childSelect: Child) {
        let viewmodel = ChildViewModel(imageData: childSelect.profileImage)
        childImg.image = UIImage(named: viewmodel.profileImageChild)
        childName.setTitle(childSelect.name, for: .normal)
    }
}
