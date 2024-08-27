//
//  SplashscreenViewController.swift
//  CoalFramework
//
//  Created by ArifRachman on 08/08/24.
//

import UIKit

public class SplashscreenFactory {
  private static let defaultLogoImage = UIImage.logo
  private static let defaultBackgroundColor: UIColor = .white
  
  public static func createSplashscreen(backgroundColor: UIColor? = nil, logo: UIImage? = nil) -> SplashscreenViewController {
    let logoImage = logo ?? defaultLogoImage
    let backgroundColor = backgroundColor ?? defaultBackgroundColor
    return SplashscreenViewController(backgroundColor: backgroundColor, logo: logoImage)
  }
}

public class SplashscreenViewController: CoalViewController {
  
  private let logoImageView = UIImageView()
  
  public init(backgroundColor: UIColor, logo: UIImage?) {
    super.init(backgroundColor: backgroundColor)
    setupLogo(logo: logo)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupLogo(logo: UIImage?) {
    logoImageView.image = logo
    logoImageView.contentMode = .scaleAspectFit
    logoImageView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(logoImageView)
    
    NSLayoutConstraint.activate([
      logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      logoImageView.widthAnchor.constraint(equalToConstant: 200),
      logoImageView.heightAnchor.constraint(equalToConstant: 200)
    ])
  }
}
