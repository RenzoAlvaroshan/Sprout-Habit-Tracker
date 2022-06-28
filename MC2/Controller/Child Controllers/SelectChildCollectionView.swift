//
//  ChildColledtionSelectionView.swift
//  ChildCollection
//
//  Created by Suherda Dwi Santoso on 27/06/22.
//

import UIKit
import Firebase

private let reuseIdentifier = "SelectChildCVCell"

class SelectChildCollectionView: UIViewController {
    
    //MARK: - Properties

    var child: [Child]?
    
    let sceneDelegate = UIApplication.shared.connectedScenes.first
    
    private var collectionView: UICollectionView!
    
    private lazy var roundedRectangel: UIView = {
        let rect = UIView()
        rect.setDimensions(height: UIScreen.main.bounds.height / 1.7, width: UIScreen.main.bounds.width)
        rect.layer.cornerRadius = 33
        rect.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        rect.backgroundColor = .white
        return rect
    }()
    
    let addAttributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.poppinsRegular(size: 16),
        .foregroundColor: UIColor.white,
    ]
    
    let addAttributes1: [NSAttributedString.Key: Any] = [
        .font: UIFont.poppinsRegular(size: 16),
        .foregroundColor: UIColor.arcadiaGreen,
    ]
    
    private lazy var chooseChildButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Choose Child", for: .normal)
        button.backgroundColor = .arcadiaGreen
        button.titleLabel?.font = UIFont.poppinsSemiBold(size: 15)
        button.layer.cornerRadius = 10
        button.setTitleColor(UIColor.white, for: .normal)
        button.setDimensions(height: 48, width: view.frame.width - 40)
        button.addTarget(self, action: #selector(handleChooseChild), for: .touchUpInside)
        return button
    }()
    
    private lazy var cancelChildButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.titleLabel?.font = UIFont.poppinsSemiBold(size: 15)
        button.layer.borderWidth = 1.5
        button.setTitleColor(UIColor.arcadiaGreen, for: .normal)
        button.layer.borderColor = UIColor.arcadiaGreen.cgColor
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.setDimensions(height: 48, width: view.frame.width - 40)
        button.addTarget(self, action: #selector(cancelButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var chooseChildTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsBold(size: 18)
        label.text = "Choose Child"
        label.textColor = .arcadiaGreen
        return label
    }()
    
    private var previousSelectedCell: SelectChildCVCell?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureWhiteBG()
        showLoader(true)
        Task.init(operation: {
            guard let uid = Auth.auth().currentUser?.uid else { return }
            let childData = try await Service.fetchAllChild(uid: uid)
            self.child = childData
            showLoader(false)
            configureUI()
        })
    }

    //MARK: - Selectors
    @objc func handleChooseChild() {
        if let scene: SceneDelegate = (self.sceneDelegate?.delegate as? SceneDelegate)
        {
            scene.setToMain()
        }
    }
    
    @objc func cancelButton() {
        self.dismiss(animated: true)
    }
    
    //MARK: - Helpers
    
    func configureWhiteBG() {
        view.backgroundColor = .clear
        
        view.addSubview(roundedRectangel)
        roundedRectangel.anchor(left: view.leftAnchor, bottom: view.bottomAnchor)
        
        view.addSubview(chooseChildTitle)
        chooseChildTitle.centerX(inView: view)
        chooseChildTitle.anchor(top: roundedRectangel.topAnchor, paddingTop: 30)
    }

    func configureUI() {
        
        configureCollectionView()
        
        let stack1 = UIStackView(arrangedSubviews: [chooseChildButton, cancelChildButton])
        stack1.axis = .vertical
        stack1.distribution = .fillProportionally
        stack1.spacing = 10
        
        view.addSubview(stack1)
//        chooseChildButton.anchor(top: view.bottomAnchor, paddingTop: 100)
        stack1.centerX(inView: roundedRectangel)
        stack1.anchor(top: collectionView.bottomAnchor, paddingTop: 20)
    }
    
    func configureCollectionView() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        // constrain
        layout.sectionInset = UIEdgeInsets(top: 7.5, left: 7.5, bottom: 7.5, right: 7.5)
        // collection item size
        layout.itemSize = CGSize(width: 165, height: 200)
        // scroll direction
        layout.scrollDirection = .horizontal
        
        // set the frame and layout
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        view.addSubview(collectionView)
        collectionView.register(SelectChildCVCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alwaysBounceVertical = false
        collectionView.backgroundColor = .white
        collectionView.anchor(top: chooseChildTitle.bottomAnchor, bottom: view.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 175, width: view.frame.width)
        collectionView.centerX(inView: roundedRectangel)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
    }
    
}

extension SelectChildCollectionView: UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return child?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SelectChildCVCell
        let items = child![indexPath.item]
        item.set(childSelect: items)
        item.backgroundColor = .white
        item.clipsToBounds = false
        return item
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        print("DEBUG: \(indexPath.item)")
        
        guard let currentSelectedCell = collectionView.cellForItem(at: indexPath) as? SelectChildCVCell
        else { return }
        
        previousSelectedCell?.onStateChanged(.normal)
        currentSelectedCell.onStateChanged(.selected)
        
        previousSelectedCell = currentSelectedCell
        
        Task.init {
            guard let uid = Auth.auth().currentUser?.uid else { return }
            let childUID = try await Service.fetchChildUID(uid:uid)
            UserDefaults.standard.set(indexPath.item, forKey: "childRef")
            let currentChildUid = childUID[UserDefaults.standard.integer(forKey: "childRef")]
            let childData = try await Service.fetchChildData(childUid: currentChildUid)
            
            UserDefaults.standard.set(currentChildUid, forKey: "childCurrentUid")
            UserDefaults.standard.set(childData.name, forKey: "childDataName")
            UserDefaults.standard.set(childData.profileImage, forKey: "childDataImage")
            UserDefaults.standard.set(childData.experience, forKey: "childDataExperience")
            
        }
        
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
