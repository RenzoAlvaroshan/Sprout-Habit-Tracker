//
//  RegisterCardView.swift
//  MC2
//
//  Created by Renzo Alvaroshan on 10/06/22.
//

import UIKit

protocol RegisterCardViewDelegate: AnyObject {
    func handleShowLogin()
    func handleRegisterButton()
}

class RegisterCardView: UIView {
    
    //MARK: - Properties
    
    weak var delegate: RegisterCardViewDelegate?
    
    private var viewModel = LoginViewModel()
    
    private lazy var signUpLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsSemiBold(size: 19)
        label.text = "Sign Up a New Account"
        label.textColor = .arcadiaGreen
        return label
    }()
    
    let emailTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Email Address")
        tf.autocapitalizationType = .none
        tf.keyboardType = .emailAddress
        tf.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Password")
        tf.isSecureTextEntry = true
        tf.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
        return tf
    }()
    
    private lazy var emailContainerView: UIView = {
        let image = UIImage(named: "envelope.fill.arcadiaGreen")?.withRenderingMode(.alwaysOriginal)
        let view = Utilities().inputContainerView(withImage: image!, textField: emailTextField)
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let image = UIImage(named: "lock.fill.arcadiaGreen")?.withRenderingMode(.alwaysOriginal)
        let view = Utilities().inputContainerView(withImage: image!, textField: passwordTextField)
        return view
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont.poppinsSemiBold(size: 15)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleRegisterButton), for: .touchUpInside)
        button.backgroundColor = .systemGray3
        button.isEnabled = false
        return button
    }()
    
    private lazy var goToRegistrationButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Already have an account? ", attributes: [.foregroundColor: UIColor.fontGray, .font: UIFont.poppinsRegular(size: 16)])
        attributedTitle.append(NSAttributedString(string: "Log In", attributes: [.foregroundColor: UIColor.arcadiaGreen, .font: UIFont.poppinsBold(size: 16)]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureTextFieldObservers()
        configureUI()
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    @objc func handleRegisterButton() {
        delegate?.handleRegisterButton()
    }
    
    @objc func handleShowLogin() {
        delegate?.handleShowLogin()
    }
    
    @objc func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else {
            viewModel.password = sender.text
        }
        
        checkFormStatus()
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    @objc func tapDone(sender: Any) {
        self.endEditing(true)
    }
    
    func checkFormStatus() {
        if viewModel.formIsValid == true {
            loginButton.isEnabled = true
            loginButton.backgroundColor = UIColor.arcadiaGreen
        } else {
            loginButton.isEnabled = false
            loginButton.backgroundColor = UIColor.systemGray3
        }
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        backgroundColor = .arcadiaGray
        
        layer.cornerRadius = 33
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        addSubview(signUpLabel)
        signUpLabel.centerX(inView: self)
        signUpLabel.anchor(top: topAnchor, paddingTop: 30)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, loginButton])
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fillEqually
        stack.setCustomSpacing(90, after: passwordContainerView)

        emailContainerView.setDimensions(height: 54, width: frame.width * 0.8)
        passwordContainerView.setDimensions(height: 54, width: frame.width * 0.8)

        addSubview(stack)
        stack.centerX(inView: self)
        stack.anchor(top: signUpLabel.bottomAnchor, left: leftAnchor ,paddingTop: 30, paddingLeft: 28)
        
        addSubview(goToRegistrationButton)
        goToRegistrationButton.anchor(left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor, paddingLeft: 32, paddingBottom: UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0 > 20 ? 50 : 20 ,paddingRight: 32)
    }
    
    func configureTextFieldObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        self.addGestureRecognizer(tap)
    }
}

extension RegisterCardView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
