////
////  SelectChildCVCell.swift
////  MC2
////
////  Created by Kevin Harijanto on 26/06/22.
////
//
//import UIKit
//
//protocol TweetCellDelegate: AnyObject {
//    func handleProfileImageTapped(_ cell: TweetCell)
//}
//
//class TweetCell: UICollectionViewCell {
//    
//    // MARK: - Properties
//    var tweet: Tweet? {
//        didSet{ configure() }
//    }
//    
//    weak var delegate: TweetCellDelegate?
//    
//    private lazy var profileImageView: UIImageView = {
//        let iv = UIImageView()
//        iv.contentMode = .scaleAspectFit
//        iv.clipsToBounds = true
//        iv.setDimensions(width: 48, height: 48)
//        iv.layer.cornerRadius = 48 / 2
//        iv.backgroundColor = .twitterBlue
//        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(handleProfileImageTapped))
//        iv.addGestureRecognizer(tap)
//        iv.isUserInteractionEnabled = true
//        
//        return iv
//    }()
//    
//    private let captionLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 14)
//        label.numberOfLines = 0
//        label.text = "Some test caption"
//        return label
//    }()
//    
//    private lazy var commentButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setImage(UIImage(named: "comment"), for: .normal)
//        button.tintColor = .darkGray
//        button.setDimensions(width: 20, height: 20)
//        button.addTarget(self, action: #selector(handleCommentTapped), for: .touchUpInside)
//        return button
//    }()
//    
//    private lazy var retweetButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setImage(UIImage(named: "retweet"), for: .normal)
//        button.tintColor = .darkGray
//        button.setDimensions(width: 20, height: 20)
//        button.addTarget(self, action: #selector(handleRetweetTapped), for: .touchUpInside)
//        return button
//    }()
//    
//    private lazy var likeButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setImage(UIImage(named: "like"), for: .normal)
//        button.tintColor = .darkGray
//        button.setDimensions(width: 20, height: 20)
//        button.addTarget(self, action: #selector(handleLikeTapped), for: .touchUpInside)
//        return button
//    }()
//    
//    private lazy var shareButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setImage(UIImage(named: "share"), for: .normal)
//        button.tintColor = .darkGray
//        button.setDimensions(width: 20, height: 20)
//        button.addTarget(self, action: #selector(handleShareTapped), for: .touchUpInside)
//        return button
//    }()
//    
//    private let infoLabel = UILabel()
//    
//    // MARK: - Lifecycle
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        backgroundColor = .white
//        
//        addSubview(profileImageView)
//        profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 8)
//        
//        let stack = UIStackView(arrangedSubviews: [infoLabel, captionLabel])
//        stack.axis = .vertical
//        stack.distribution = .fillProportionally
//        stack.spacing = 4
//        
//        addSubview(stack)
//        stack.anchor(top:profileImageView.topAnchor, left: profileImageView.rightAnchor, right: rightAnchor, paddingLeft: 12, paddingRight: 12)
//        
//        infoLabel.font = UIFont.systemFont(ofSize: 14)
//        infoLabel.text = "Hanni Thenadiputto @nahneth"
//        
//        let actionStack = UIStackView(arrangedSubviews: [commentButton,retweetButton,likeButton,shareButton])
//        actionStack.axis = .horizontal
//        actionStack.spacing = 72
//        
//        addSubview(actionStack)
////        actionStack.centerX(inView: self)
//        actionStack.anchor(left: stack.leftAnchor,bottom: bottomAnchor, paddingBottom: 8)
//        
//        let underlineView = UIView()
//        underlineView.backgroundColor = .systemGroupedBackground
//        addSubview(underlineView)
//        underlineView.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 1)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    // MARK: - Selectors
//    
//    @objc func handleProfileImageTapped() {
//        delegate?.handleProfileImageTapped(self)
//    }
//    
//    @objc func handleCommentTapped() {
//        print("DEBUG: Comment tapped")
//    }
//    
//    @objc func handleRetweetTapped() {
//        print("DEBUG: RT tapped")
//    }
//    
//    @objc func handleLikeTapped() {
//        print("DEBUG: Like tapped")
//    }
//    
//    @objc func handleShareTapped() {
//        print("DEBUG: Share tapped")
//    }
//    
//    
//    // MARK: - Helpers
//    
//    func configure() {
//        guard let tweet = tweet else {return}
//        let viewModel = TweetViewModel(tweet: tweet)
//        
//        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
//        infoLabel.attributedText = viewModel.userInfoText
//        captionLabel.text = tweet.caption
//    }
//}
//
