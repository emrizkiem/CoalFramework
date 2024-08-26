//
//  CoalTextField.swift
//  CoalFramework
//
//  Created by M. Rizki Maulana on 15/08/24.
//

import UIKit

public class CoalTextField: UIView {
  
  private lazy var label: CoalLabel = {
    return CoalLabel(fontSize: 15, weight: .regular)
  }()
  
  private lazy var textField: UITextField = {
    let textField = UITextField()
    textField.borderStyle = .roundedRect
    textField.backgroundColor = .white
    textField.textColor = .black
    textField.font = UIFont.systemFont(ofSize: 15)
    textField.autocorrectionType = .no
    return textField
  }()
  
  private lazy var toggleButton: UIButton = {
    let button = UIButton(type: .custom)
    button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
    button.tintColor = .gray
    return button
  }()
  
  private lazy var forgotPasswordLabel: CoalLabel = {
    let label = CoalLabel(fontSize: 14, weight: .regular, text: "Forgot Password?", textColor: .black)
    label.isUserInteractionEnabled = true
    return label
  }()
  
  private var isPassword: Bool = false
  
  public init(labelText: String, placeholder: String, isPassword: Bool = false) {
    super.init(frame: .zero)
    
    self.label.text = labelText
    self.isPassword = isPassword
    
    textField.placeholder = placeholder
    setupView()
    
    if isPassword {
      setupPasswordToggle()
      setupForgotPasswordLabel()
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupView() {
    addSubview(label)
    addSubview(textField)
    
    label.translatesAutoresizingMaskIntoConstraints = false
    textField.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: topAnchor),
      label.leadingAnchor.constraint(equalTo: leadingAnchor),
      label.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
      textField.leadingAnchor.constraint(equalTo: leadingAnchor),
      textField.trailingAnchor.constraint(equalTo: trailingAnchor),
      textField.bottomAnchor.constraint(equalTo: bottomAnchor),
      textField.heightAnchor.constraint(equalToConstant: 45)
    ])
  }
  
  private func setupConstraints() {
    
  }
  
  private func setupPasswordToggle() {
    textField.isSecureTextEntry = true
    toggleButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
    
    textField.rightView = toggleButton
    textField.rightViewMode = .always
    
    toggleButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
    let rightPadding: CGFloat = 8
    let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 30 + rightPadding, height: 30))
    rightPaddingView.addSubview(toggleButton)
    textField.rightView = rightPaddingView
  }
  
  private func setupForgotPasswordLabel() {
    addSubview(forgotPasswordLabel)
    forgotPasswordLabel.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      forgotPasswordLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 8),
      forgotPasswordLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
    ])
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(forgotPasswordTapped))
    forgotPasswordLabel.addGestureRecognizer(tapGesture)
  }
  
  @objc private func togglePasswordVisibility() {
    textField.isSecureTextEntry.toggle()
    let imageName = textField.isSecureTextEntry ? "eye.slash" : "eye"
    toggleButton.setImage(UIImage(systemName: imageName), for: .normal)
  }
  
  @objc private func forgotPasswordTapped() {
    print("Forgot password tapped")
  }
}
