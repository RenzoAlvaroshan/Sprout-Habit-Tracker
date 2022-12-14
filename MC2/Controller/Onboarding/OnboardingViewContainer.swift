//
//  OnboardingTesting.swift
//  MC2
//
//  Created by Stephen Giovanni Saputra on 13/06/22.

import UIKit
import SwiftUI
import Firebase

class OnboardingViewContainer: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    //MARK: - Properties
    private let onboardingManager = OnboardingManager()
    
    var pages = [UIViewController]()
    let initialPage = 0
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = .arcadiaGreen
        pageControl.pageIndicatorTintColor = .arcadiaGray
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage
        pageControl.backgroundStyle = .minimal
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }()
    
    let yourAttributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.poppinsMedium(size: 15),
        .underlineStyle: NSUnderlineStyle.single.rawValue
    ]
    
    private lazy var skipButton: UIButton = {
        
        let attributeString = NSMutableAttributedString(
            string: "Skip",
            attributes: yourAttributes
        )
        
        let button = UIButton(type: .system)
        button.setAttributedTitle(attributeString, for: .normal)
        button.setTitleColor(UIColor.arcadiaGreen, for: .normal)
        button.addTarget(self, action: #selector(handleSkipButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var getStartedButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Get Started", for: .normal)
        button.titleLabel?.font = UIFont.poppinsSemiBold(size: 15)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleNavigationButton), for: .touchUpInside)
        button.backgroundColor = .white
        button.isEnabled = false
        return button
    }()
    
    //MARK: - Lifecycle
    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented!")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        
        configureUI()
    }
    
    //MARK: - Selectors
    @objc func handleNavigationButton() {
        
        updateFlag()
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }

        let rootVC = LoginController()
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
        
        present(navVC, animated: true)
    }
    
    
    @objc func handleSkipButton() {
        
        print("DEBUG Skip Button...")
        
        let lastPage = pages.count - 1
        pageControl.currentPage = lastPage
        getStartedButton.isEnabled = true
        skipButton.isEnabled = false
        UIView.animate(withDuration: 0.3) {
            self.getStartedButton.backgroundColor = UIColor.arcadiaGreen
            self.skipButton.setTitleColor(.white, for: .normal)
        }
        
        goToSpecificPage(index: lastPage, ofViewControllers: pages)
    }
    
    //MARK: - Helpers
    private func updateFlag() {
        onboardingManager.setOnboardingSeen()
    }
    
    func configureUI() {
        
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(skipButton)
        skipButton.anchor(top: view.topAnchor, right: view.rightAnchor, paddingTop: UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0 > 20 ? 80 : 60, paddingRight: 20)
        
        let page1 = OnboardingViewController(
            imageName: "onboarding1",
            titleText: "Welcome to Sprout",
            subtitleText: "We help you to keep on track to build your child???s eco-friendly habit."
        )
        
        let page2 = OnboardingViewController(
            imageName: "onboarding2",
            titleText: "Challenge Your Kids",
            subtitleText: " Build an eco-friendly habits in a fun and rewarding way."
        )
        
        let page3 = OnboardingViewController(
            imageName: "onboarding3",
            titleText: "Get Notified!",
            subtitleText: "We???ll send a notification as a reminder so you don???t miss a beat."
        )
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
        
        view.addSubview(pageControl)
        pageControl.anchor(top: skipButton.bottomAnchor, paddingTop: view.frame.height / 1.4)
        pageControl.centerX(inView: view)
        
        view.addSubview(getStartedButton)
        getStartedButton.centerX(inView: view)
        getStartedButton.anchor(bottom: view.bottomAnchor, paddingBottom: UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0 > 20 ? 80 : 50)
        getStartedButton.setDimensions(height: 50, width: view.frame.width - 48)
    }
    
    func goToSpecificPage(index: Int, ofViewControllers pages: [UIViewController]) {
        setViewControllers([pages[index]], direction: .forward, animated: true, completion: nil)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        if currentIndex == 0 {
            return nil               // wrap last
        } else {
            return pages[currentIndex - 1]  // go previous
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        if currentIndex < pages.count - 1 {
            return pages[currentIndex + 1]  // go next
        } else {
            return nil              // wrap first
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }
        
        pageControl.currentPage = currentIndex
        
        if currentIndex > 1 {
            getStartedButton.isEnabled = true
            skipButton.isEnabled = false
            UIView.animate(withDuration: 0.2) {
                self.getStartedButton.backgroundColor = UIColor.arcadiaGreen
                self.skipButton.setTitleColor(.white, for: .normal)
            }
        }
    }
}
