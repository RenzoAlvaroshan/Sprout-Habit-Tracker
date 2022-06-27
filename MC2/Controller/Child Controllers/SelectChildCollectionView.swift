//
//  ChildColledtionSelectionView.swift
//  ChildCollection
//
//  Created by Suherda Dwi Santoso on 27/06/22.
//

import UIKit
//protocol ActivityViewDelegate: AnyObject {
//    func handleAddActivityPush()
//}
private let reuseIdentifier = "ChildCell"


class ChildCollectionSelectionView: UIViewController {
    
    //MARK: - Properties
//    let controller = AddHabitController()
//
//    var activity: [Activity]? {
//        didSet {
//            tableView.reloadData()
//        }
//    }
    
    
    private var collectionView: UICollectionView!
    var selection: [childSelection] = []
    
    private lazy var roundedRectangel: UIView = {
        let rect = UIView()
        rect.setDimensions(height: UIScreen.main.bounds.height / 1.51, width: UIScreen.main.bounds.width)
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
    
//    weak var delegate: ActivityViewDelegate?
    
    private lazy var chooseChildButton: UIButton = {
        
        let attributeString = NSMutableAttributedString(
            string: "Choose Child",
            attributes: addAttributes
        )

        let button = UIButton(type: .system)
        button.setAttributedTitle(attributeString, for: .normal)
        button.backgroundColor = .arcadiaGreen
        button.layer.cornerRadius = 8
        button.setDimensions(height: 40, width: view.frame.width - 40)
//        button.addTarget(self, action: #selector(handleAddActivity), for: .touchUpInside)
        return button
    }()
    
    private lazy var cancelChildButton: UIButton = {
        
        let attributeString = NSMutableAttributedString(
            string: "Cancel",
            attributes: addAttributes1
        )

        let button = UIButton(type: .system)
        button.setAttributedTitle(attributeString, for: .normal)
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.arcadiaGreen.cgColor
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.setDimensions(height: 40, width: view.frame.width - 40)
//        button.addTarget(self, action: #selector(handleAddActivity), for: .touchUpInside)
        return button
    }()
    
    private lazy var chooseChildTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsBold(size: 18)
        label.text = "Choose Child"
        label.textColor = .white
        return label
    }()
    
    //MARK: - Lifecycle
//
//    override func loadView() {
//        // create a layout to be used
//        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        // make sure that there is a slightly larger gap at the top of each row
//        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
//        // set a standard item size of 60 * 60
//        layout.itemSize = CGSize(width: 60, height: 60)
//        // the layout scrolls horizontally
//        layout.scrollDirection = .horizontal
//        // set the frame and layout
//        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        // set the view to be this UICollectionView
//        self.view = collectionView
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selection = fetchData()
        configureUI()
    }

    //MARK: - Selectors
    
    
    //MARK: - Helpers

    func configureUI() {
        view.backgroundColor = .arcadiaGreen
        
        view.addSubview(chooseChildTitle)
        chooseChildTitle.centerX(inView: view)
        chooseChildTitle.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 88)
        
        view.addSubview(roundedRectangel)
        roundedRectangel.anchor(left: view.leftAnchor, bottom: view.bottomAnchor)
        
        configureCollectionView()
        
        let stack1 = UIStackView(arrangedSubviews: [chooseChildButton, cancelChildButton])
        stack1.axis = .vertical
        stack1.distribution = .fillProportionally
        stack1.spacing = 10
        
        view.addSubview(stack1)
//        chooseChildButton.anchor(top: view.bottomAnchor, paddingTop: 100)
        stack1.centerX(inView: roundedRectangel)
        stack1.anchor(top: collectionView.bottomAnchor, paddingTop: 40)
    }
    
    func configureCollectionView() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        // contstrain
        layout.sectionInset = UIEdgeInsets(top: 7.5, left: 7.5, bottom: 7.5, right: 7.5)
        // collection item size
        layout.itemSize = CGSize(width: 105, height: 140)
        // scroll direction
        layout.scrollDirection = .vertical
        
        // set the frame and layout
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        view.addSubview(collectionView)
        collectionView.register(childCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .white
        collectionView.anchor(top: view.topAnchor, bottom: view.bottomAnchor, paddingTop: 310, paddingLeft: 0, paddingBottom: 230, width: view.frame.width - 40)
        collectionView.centerX(inView: roundedRectangel)
        collectionView.showsVerticalScrollIndicator = false
    }
    
}

extension ChildCollectionSelectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selection.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! childCell
        let items = selection[indexPath.item]
        item.set(childSelect: items)
        item.backgroundColor = .white
        item.clipsToBounds = false
        return item
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension ChildCollectionSelectionView {
    func fetchData() -> [childSelection] {
        let child1 = childSelection(childImg: UIImage(#imageLiteral(resourceName: "ava2_m")), childName: "Kevin")
        let child2 = childSelection(childImg: UIImage(#imageLiteral(resourceName: "ava1_m")), childName: "Esge")
        let child3 = childSelection(childImg: UIImage(#imageLiteral(resourceName: "ava3_m")), childName: "Renzo")
        let child4 = childSelection(childImg: UIImage(#imageLiteral(resourceName: "ava3_f")), childName: "Vica")
        let child5 = childSelection(childImg: UIImage(#imageLiteral(resourceName: "ava1_f")), childName: "Eufra")
        let child6 = childSelection(childImg: UIImage(#imageLiteral(resourceName: "ava2_f")), childName: "Suhe")

        return [child1,child2,child3,child4,child5,child6]
    }
}

import SwiftUI

extension UIViewController {
    // enable preview for UIKit
    // source: https://fluffy.es/xcode-previews-uikit/
    @available(iOS 13, *)
    private struct Preview: UIViewControllerRepresentable {
        // this variable is used for injecting the current view controller
        let viewController: UIViewController
        
        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
            //
        }
    }
    
    @available(iOS 13, *)
    func showPreview() -> some View {
        Preview(viewController: self)
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct ViewController_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        ChildCollectionSelectionView().showPreview()
    }
}
#endif
