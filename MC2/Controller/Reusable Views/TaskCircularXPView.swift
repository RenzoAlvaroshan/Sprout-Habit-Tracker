//
//  TaskCircularXPView.swift
//  MC2
//
//  Created by Suherda Dwi Santoso on 20/06/22.
//

import UIKit

class TaskCircularXPView: UIView {

    //MARK: - Properties
    
    let foregroundLayer = CAShapeLayer()
    let backgroundLayer = CAShapeLayer()
    let gradient = CAGradientLayer()
    
    let size = 180
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        backgroundColor = .clear
        
        let circularPath = UIBezierPath(
            arcCenter: center,
            radius: (CGFloat(size) / 4),
            startAngle: -CGFloat.pi / 2,
            endAngle: (-CGFloat.pi / 2) + 2 * CGFloat.pi,
            clockwise: true)
        
        // Progress Bar
        backgroundLayer.path = circularPath.cgPath
        backgroundLayer.lineWidth = 10
        backgroundLayer.strokeColor = UIColor.systemGray6.cgColor
        backgroundLayer.lineCap = CAShapeLayerLineCap.square
        backgroundLayer.fillColor = UIColor.clear.cgColor
        
        layer.addSublayer(backgroundLayer)
        
        foregroundLayer.path = circularPath.cgPath
        foregroundLayer.lineWidth = 10
        foregroundLayer.strokeColor = UIColor.arcadiaYellow.cgColor
        foregroundLayer.lineCap = CAShapeLayerLineCap.round
        foregroundLayer.fillColor = UIColor.clear.cgColor
        foregroundLayer.strokeEnd = 0
        
        layer.addSublayer(foregroundLayer)
        
        playAnimation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Helpers
    func playAnimation() {
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        let experience = UserDefaults.standard.integer(forKey: "childDataExperience") // ganti disini
        let experienceLabel = Double(experience%100) / 100.0 // ganti pembagi per level
        basicAnimation.toValue = experienceLabel
        basicAnimation.duration = 2
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        basicAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        foregroundLayer.add(basicAnimation, forKey: "basicAnimation")
    }
}
