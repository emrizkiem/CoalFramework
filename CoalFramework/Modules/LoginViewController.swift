//
//  LoginViewController.swift
//  CoalFramework
//
//  Created by ArifRachman on 08/08/24.
//

import UIKit

public class LoginFactory {
  private static let defaultLogoImage = UIImage.logo
  private static let defaultBackgroundColor: UIColor = .white
  
  public static func createLoginPage(backgroundColor: UIColor? = nil, logo: UIImage? = nil) -> LoginViewController {
    let logoImage = logo ?? defaultLogoImage
    let backgroundColor = backgroundColor ?? defaultBackgroundColor
    let config = ConfigModel.currentConfig?.pages?.login
    return LoginViewController(config: config, backgroundColor: backgroundColor, logo: logoImage)
  }
}

public protocol LoginNavigationDelegate: AnyObject {
  func handleLoginSuccess(isLoggedIn: Bool)
}

public class LoginViewController: CoalViewController {
  
  private let logoImageView = UIImageView()
  public weak var delegate: LoginNavigationDelegate?
  
  private lazy var titleLabel: CoalLabel = {
    return CoalLabel(fontSize: 26, weight: .bold, text: "Login")
  }()
  
  private lazy var subtitleLabel: CoalLabel = {
    return CoalLabel(fontSize: 16, weight: .regular, text: "Please enter your username and password")
  }()
  
  private lazy var usernameField: CoalTextField = {
    return CoalTextField(labelText: "Username", placeholder: "Enter your username", contentType: .username)
  }()
  
  private lazy var passwordField: CoalTextField = {
    return CoalTextField(labelText: "Password", placeholder: "Enter your password", contentType: .password, isPassword: true)
  }()
  
  private lazy var submitButton: CoalButton = {
    return CoalButton(title: "SUBMIT", titleColor: .white, backgroundColor: .gray)
  }()
  
  private lazy var registerButton: CoalButton = {
    return CoalButton(title: "REGISTER NOW", titleColor: .gray, backgroundColor: .white, borderWidth: 1, borderColor: UIColor.gray, cornerRadius: 8)
  }()
  
  public init(config: ConfigPage?, backgroundColor: UIColor, logo: UIImage?) {
    super.init(backgroundColor: backgroundColor)
    setupConfig(config: config, logo: logo)
  }
  
  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override public func setupView() {
    [logoImageView, titleLabel, subtitleLabel, usernameField, passwordField, submitButton, registerButton].forEach {
      view.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
    registerButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
    
    setupConstraints()
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
      logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      logoImageView.widthAnchor.constraint(equalToConstant: 125),
      logoImageView.heightAnchor.constraint(equalToConstant: 125),
      
      titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
      titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      
      subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
      subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      
      usernameField.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 20),
      usernameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      usernameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      
      passwordField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 20),
      passwordField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      passwordField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      
      submitButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 40),
      submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      submitButton.heightAnchor.constraint(equalToConstant: 50),
      
      registerButton.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 10),
      registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      registerButton.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
  
  private func setupConfig(config: ConfigPage?, logo: UIImage?) {
    if let logoURLString = config?.header?.image, let logoURL = URL(string: logoURLString) {
      logoImageView.loadImage(from: logoURL, placeholder: logo)
    } else {
      logoImageView.image = logo
    }
    
    logoImageView.contentMode = .scaleAspectFit
    logoImageView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(logoImageView)
    
    if let description = config?.header?.description {
      subtitleLabel.text = description
    }
    
    if let username = config?.form?.username?.label,
       let placehorder = config?.form?.username?.placeholder {
      usernameField.updateTextField(labelText: username, placeholder: placehorder, type: .username)
    }
    
    if let password = config?.form?.password?.label,
       let placeholder = config?.form?.password?.placeholder {
      passwordField.updateTextField(labelText: password, placeholder: placeholder, type: .password)
    }
    
    if let submit = config?.form?.submit?.label {
      submitButton.button.setTitle(submit, for: .normal)
    }
  }
  
  @objc private func submitTapped() {
    if let delegate = delegate {
      delegate.handleLoginSuccess(isLoggedIn: true)
    } else {
      CoalNavigator.shared.showHomePage(backgroundColor: .white)
    }
  }
  
  @objc private func registerTapped() {
    print("Register tapped")
  }
}
