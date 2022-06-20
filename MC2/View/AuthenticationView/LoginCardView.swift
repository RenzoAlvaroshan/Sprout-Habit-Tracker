//
//  LoginCardView.swift
//  MC2
//
//  Created by Renzo Alvaroshan on 09/06/22.
//

import UIKit

protocol LoginCardViewDelegate: AnyObject {
    func handleShowRegistration()
    func handleLoginButton()
}

class LoginCardView: UIView {
    
    //MARK: - Properties
    
    weak var delegate: LoginCardViewDelegate?
    
    private var viewModel = LoginViewModel()
    
    private lazy var loginTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsSemiBold(size: 19)
        label.text = "Log In to Your Account"
        label.textColor = .arcadiaGreen
        return label
    }()
    
    let emailTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Email Address")
        tf.autocapitalizationType = .none
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Password")
        tf.isSecureTextEntry = true
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
    
    let yourAttributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.poppinsRegular(size: 15),
        .foregroundColor: UIColor.arcadiaGreen2,
        .underlineStyle: NSUnderlineStyle.single.rawValue
    ]
    
    private lazy var forgotPasswordButton: UIButton = {
        
        let attributeString = NSMutableAttributedString(
            string: "Forgot Password?",
            attributes: yourAttributes
        )

        let button = UIButton(type: .system)
        button.setAttributedTitle(attributeString, for: .normal)
        button.setTitleColor(UIColor.arcadiaGreen2, for: .normal)
        button.addTarget(self, action: #selector(handleForgotPassword), for: .touchUpInside)
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.titleLabel?.font = UIFont.poppinsSemiBold(size: 15)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleLoginButton), for: .touchUpInside)
        button.backgroundColor = .systemGray
        button.isEnabled = false
        return button
    }()
    
    private lazy var loginAsGuardianButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In as a Guardian", for: .normal)
        button.titleLabel?.font = UIFont.poppinsSemiBold(size: 15)
        button.setTitleColor(UIColor.arcadiaGreen, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleLoginAsGuardianButton), for: .touchUpInside)
        button.backgroundColor = .arcadiaGray
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.arcadiaGreen.cgColor
        button.isEnabled = false
        return button
    }()
    
    private lazy var goToRegistrationButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account? ", attributes: [.foregroundColor: UIColor.fontGray, .font: UIFont.poppinsRegular(size: 16)])
        attributedTitle.append(NSAttributedString(string: "Sign Up", attributes: [.foregroundColor: UIColor.arcadiaGreen, .font: UIFont.poppinsBold(size: 16)]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowRegistration), for: .touchUpInside)
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
    
    @objc func handleLoginButton() {
        delegate?.handleLoginButton()
    }
    
    @objc func handleLoginAsGuardianButton() {
        
    }
    
    @objc func handleForgotPassword() {
        
    }
    
    @objc func handleShowRegistration() {
        delegate?.handleShowRegistration()
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
    
    
    //MARK: - Helpers
    
    func checkFormStatus() {
        if viewModel.formIsValid == true {
            loginButton.isEnabled = true
            UIView.animate(withDuration: 0.3) {
                self.loginButton.backgroundColor = UIColor.arcadiaGreen
            }
        } else {
            loginButton.isEnabled = false
            UIView.animate(withDuration: 0.3) {
                self.loginButton.backgroundColor = UIColor.systemGray
            }
        }
    }
    
    func configureUI() {
        backgroundColor = .arcadiaGray
        
        layer.cornerRadius = 33
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        addSubview(loginTitle)
        loginTitle.centerX(inView: self)
        loginTitle.anchor(top: topAnchor, paddingTop: 30)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, forgotPasswordButton, loginButton, loginAsGuardianButton])
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fillEqually
        stack.setCustomSpacing(25, after: forgotPasswordButton)

        emailContainerView.setDimensions(height: 54, width: frame.width * 0.8)
        passwordContainerView.setDimensions(height: 54, width: frame.width * 0.8)

        addSubview(stack)
        stack.centerX(inView: self)
        stack.anchor(top: loginTitle.bottomAnchor, left: leftAnchor ,paddingTop: 30, paddingLeft: 28)
        
        addSubview(goToRegistrationButton)
        goToRegistrationButton.anchor(left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor, paddingLeft: 32, paddingBottom: UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0 > 20 ? 50 : 20, paddingRight: 32)
    }
    
    func configureTextFieldObservers() {
        
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        self.addGestureRecognizer(tap)
    }
}

extension LoginCardView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
