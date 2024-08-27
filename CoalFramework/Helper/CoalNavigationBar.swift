//
//  CoalNavigationBar.swift
//  CoalFramework
//
//  Created by ArifRachman on 08/08/24.
//

import UIKit

public enum CoalNavigationBarType {
  case titleAndLogout(title: String?)
}

public protocol NavigationBarButtonHandler {
  func rightNavigationBarButtonTapped(sender: UIBarButtonItem?)
  func leftNavigationBarButtonTapped(sender: UIBarButtonItem?)
}

extension CoalViewController {
  private func setDefaultNavigationTheme() {
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.barTintColor  = .primaryColor
    navigationController?.interactivePopGestureRecognizer?.delegate = nil
    navigationController?.setNavigationBarHidden(false, animated: false)
  }
  
  private func setTransparentNavigationBar() {
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.barTintColor = .clear
    navigationController?.navigationBar.backgroundColor = .clear
    navigationController?.interactivePopGestureRecognizer?.delegate = nil
    navigationController?.navigationBar.isTranslucent = true
  }
  
  private func setNavigationBarCustomBackground(color: UIColor) {
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.barTintColor = .primaryColor
    navigationController?.navigationBar.backgroundColor = .clear
    navigationController?.interactivePopGestureRecognizer?.delegate = nil
  }
  
  func setNavigationBar(type: CoalNavigationBarType) {
    setDefaultNavigationTheme()
    
    switch type {
    case .titleAndLogout(let title):
      if let theTitle = title {
        let btnTitle = UIButton()
        btnTitle.setTitle(theTitle, for: .normal)
        btnTitle.setTitleColor(.black, for: .normal)
        btnTitle.titleLabel?.font = .boldSystemFont(ofSize: 16)
        navigationItem.titleView = btnTitle
        navigationItem.rightBarButtonItem = createLogoutButton()
      } else {
        setTransparentNavigationBar()
        navigationItem.rightBarButtonItem = createLogoutButton()
      }
    }
  }
  
  private func createLogoutButton() -> UIBarButtonItem {
    let logoutButton = UIBarButtonItem(image: UIImage.logout?.resize(to: CGSize(width: 22, height: 22)), style: .plain, target: self, action: #selector(self.rightNavigationBarButtonTapped(sender:)))
    logoutButton.tintColor = .black
    return logoutButton
  }
}

extension CoalViewController: NavigationBarButtonHandler {
  @objc open func rightNavigationBarButtonTapped(sender: UIBarButtonItem?) {
  }
  
  @objc open func leftNavigationBarButtonTapped(sender: UIBarButtonItem?) {
  }
}
