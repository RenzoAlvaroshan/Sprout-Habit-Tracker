//
//  Utilities.swift
//  MC2
//
//  Created by Renzo Alvaroshan on 09/06/22.
//

import UIKit

class Utilities {
    
    func inputContainerView(withImage image: UIImage, textField: UITextField) -> UIView {
        let view = UIView()
        let iv = UIImageView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 14
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        iv.image = image
        view.addSubview(iv)
        iv.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, paddingLeft: 12, paddingBottom: 12)
        iv.contentMode = .scaleAspectFit
        iv.setDimensions(height: 24, width: 24)
        
        view.addSubview(textField)
        textField.anchor(left: iv.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 12, paddingBottom: 12)
        
        return view
    }
    
    func buttonContainerView(input1: String, input2: String) -> UIView {
        let view = UIView()
        
        view.backgroundColor = .arcadiaGray
        view.setDimensions(height: view.frame.height / 10, width: view.frame.width * 0.8)
        
        let title = UILabel()
        title.text = input1
        title.font = UIFont.poppinsSemiBold(size: 16)
        //        title.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: 12, paddingLeft: 12)
        
        let subtitle = UILabel()
        subtitle.text = input2
        subtitle.font = UIFont.poppinsRegular(size: 14)
        //        subtitle.anchor(top: title.bottomAnchor, left: view.leftAnchor, paddingTop: 8, paddingLeft: 12)
        
        return view
    }
    
    func textField(withPlaceholder placeholder: String) -> UITextField {
        let tf = UITextField()
        tf.textColor = .arcadiaGreen
        tf.font = UIFont.poppinsRegular(size: 15)
        tf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray3, .font: UIFont.poppinsRegular(size: 15)])
        return tf
    }
    
    func attributedButton(_ firstPart: String, _ secondPart: String) -> UIButton {
        let button = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: firstPart, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white])
        
        attributedTitle.append(NSAttributedString(string: secondPart, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        return button
    }
    
    func vibrate(for type: UINotificationFeedbackGenerator.FeedbackType){
        DispatchQueue.main.async {
            let notificationGenerator = UINotificationFeedbackGenerator()
            notificationGenerator.prepare()
            notificationGenerator.notificationOccurred(type)
        }
    }
}
