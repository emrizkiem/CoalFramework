//
//  AboutViewController.swift
//  CoalFramework
//
//  Created by ArifRachman on 08/08/24.
//

import UIKit

public class AboutFactory {
  public static func createAboutPage(backgroundColor: UIColor) -> AboutViewController {
    return AboutViewController(backgroundColor: backgroundColor)
  }
}

public class AboutViewController: CoalViewController {
  private let coalLabel: CoalLabel = {
    return CoalLabel(fontSize: 20, weight: .bold, text: "Welcome to AboutViewController")
  }()
  
  public override func setupView() {
    super.setupView()
    view.addSubview(coalLabel)
    
    NSLayoutConstraint.activate([
      coalLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      coalLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }
}

extension AboutViewController: CoalTabInfoProviding {
  public func coalTabInfo() -> CoalTabInfo {
    return CoalTabInfo(title: "About", icon: UIImage.about)
  }
}
