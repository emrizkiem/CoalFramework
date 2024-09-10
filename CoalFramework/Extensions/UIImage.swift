//
//  UIImage.swift
//  CoalFramework
//
//  Created by ArifRachman on 08/08/24.
//

import UIKit 

public extension UIImage {
  private static var frameworkBundle: Bundle {
    return Bundle(for: CoalViewController.self)
  }
  
  static let logo = UIImage(named: "CoalLogo", in: frameworkBundle, compatibleWith: nil)
  static let logout = UIImage(named: "icLogout", in: frameworkBundle, compatibleWith: nil)
  static let home = UIImage(named: "icHome", in: frameworkBundle, compatibleWith: nil)
  static let about = UIImage(named: "icAbout", in: frameworkBundle, compatibleWith: nil)
  
  static let eyeOn = UIImage(named: "icEyeOn", in: frameworkBundle, compatibleWith: nil)
  static let eyeOff = UIImage(named: "icEyeOff", in: frameworkBundle, compatibleWith: nil)
  static let icInfo = UIImage(systemName: "info.circle")
}

public extension UIImage {
  func resize(to size: CGSize) -> UIImage? {
    UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
    draw(in: CGRect(origin: .zero, size: size))
    let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return resizedImage
  }
}
