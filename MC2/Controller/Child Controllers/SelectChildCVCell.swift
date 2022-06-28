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
    var nameTapped = false
    var tapChild: String = ""
    
    var childImg: UIImageView = {
        let childImg = UIImageView()
        childImg.contentMode = .scaleAspectFit
        childImg.clipsToBounds = true
        childImg.setDimensions(height: 150, width: 150)
        
        return childImg
    }()
    
    private lazy var childName: UIButton = {
        let childName = UIButton()
        childName.setTitle("Water", for: .normal)
        childName.setTitleColor(UIColor.black, for: .normal)
        childName.titleLabel?.font = UIFont.poppinsMedium(size: 18)
        childName.titleLabel?.textAlignment = .center
        childName.addTarget(self, action: #selector(handleName), for: .touchUpInside)
        childName.isEnabled = false
        childName.setDimensions(height: 30, width: 240)
        return childName
    }()
    
    func configureColletionItems() {
        
        layer.backgroundColor = UIColor.white.cgColor
        layer.cornerRadius = frame.width / 4
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = frame.width / 4
    }

    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        let stack = UIStackView(arrangedSubviews: [childImg, childName])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 5
        
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

extension SelectChildCVCell: ColoringDelegate
{
    func onStateChanged(_ state: ColoringCommonState)
    {
        UIView.animate(withDuration: 0.3) { [unowned self] in
            let background: UIColor = state == .selected ? .arcadiaGreen : .clear
            let foreground: UIColor = state == .selected ? .white : .black
            
            self.contentView.backgroundColor = background
            childName.setTitleColor(foreground, for: .normal)
        }
    }
}
