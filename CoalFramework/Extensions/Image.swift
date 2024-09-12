//
//  Image.swift
//  CoalFramework
//
//  Created by ArifRachman on 13/08/24.
//

import SwiftUI

public extension Image {
  private static var frameworkBundle: Bundle {
    return Bundle(for: CoalViewController.self)
  }
  
  static let logo = Image("CoalLogo", bundle: frameworkBundle)
  static let eyeOn = Image("icEyeOn", bundle: frameworkBundle)
  static let eyeOff = Image("icEyeOff", bundle: frameworkBundle)
  static let icInfo = Image(systemName: "info.circle")
  static let mainBackground = Image("imgBackground", bundle: frameworkBundle)
}

public extension Image {
  func resized(to size: CGSize) -> some View {
    self
      .resizable()
      .frame(width: size.width, height: size.height)
  }
}
