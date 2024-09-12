//
//  Navigator.swift
//  CoalFramework
//
//  Created by ArifRachman on 08/08/24.
//

import UIKit
import SwiftUI

public class CoalNavigator {
  public static let shared = CoalNavigator()
  private var tabBarController: CoalTabBarController?
  private let config: CoalConfig
  private var logoName: String?
  
  private init() {
    self.config = CoalConfig.shared
  }
  
  public func setRootViewController(viewController: UIViewController, animated: Bool = true) {
    guard let window = config.window else {
      fatalError("Window is not set")
    }
    
    if let tabBarController = viewController as? CoalTabBarController {
      self.tabBarController = tabBarController
      self.tabBarController?.addDefaultTabs()
    }
    
    if animated {
      UIView.transition(with: window, duration: config.animationDuration, options: [config.transition], animations: {
        window.rootViewController = viewController
      })
    } else {
      window.rootViewController = viewController
    }
    window.makeKeyAndVisible()
  }
  
  public func setSwiftUIView<Content: View>(swiftUIView: Content, backgroundColor: UIColor? = nil) {
    let hostingController = UIHostingController(rootView: swiftUIView)
    
    if let backgroundColor = backgroundColor {
      hostingController.view.backgroundColor = backgroundColor
    }
    
    setRootViewController(viewController: hostingController, animated: false)
  }
  
  public func showSplashScreen(backgroundColor: UIColor? = nil, logo: String? = nil, completion: (() -> Void)? = nil) {
    var logoImage: UIImage?
    if let logoName = logo {
      logoImage = UIImage(named: logoName)
      self.logoName = logoName
    }
    
    let splashscreenVC = SplashscreenFactory.createSplashscreen(backgroundColor: backgroundColor, logo: logoImage)
    setRootViewController(viewController: splashscreenVC, animated: false)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + config.splashScreenDuration) {
      self.setRootViewController(viewController: splashscreenVC, animated: true)
      DispatchQueue.main.asyncAfter(deadline: .now() + self.config.animationDuration) {
        let initialRootVC = self.config.window?.rootViewController
        if self.config.window?.rootViewController === initialRootVC {
          let isLoggedIn = false
          self.showInitialPage(isLoggedIn: isLoggedIn, logo: logo)
        }
        completion?()
      }
    }
  }
  
  public func showLoginPage(backgroundColor: UIColor = .white, logo: String? = nil) {
    let loginView = LoginView(config: ConfigModel.currentConfig, headerImageName: logo, backgroundColor: Color(backgroundColor))
    setSwiftUIView(swiftUIView: loginView, backgroundColor: backgroundColor)
  }
  
  public func showRegisterPage(backgroundColor: UIColor = .white) {
    let registerView = RegisterView(config: ConfigModel.currentConfig, backgroundColor: Color(backgroundColor))
    setSwiftUIView(swiftUIView: registerView, backgroundColor: backgroundColor)
  }
  
  public func showHomePage(backgroundColor: UIColor, userName: String = "") {
    let tabBarController = CoalTabBarController(userName: userName)
    self.tabBarController = tabBarController
    setRootViewController(viewController: tabBarController, animated: true)
  }
  
  public func showAboutPage(backgroundColor: UIColor) {
    let aboutVC = AboutFactory.createAboutPage(backgroundColor: backgroundColor)
    setRootViewController(viewController: aboutVC, animated: true)
  }
  
  public func showInitialPage(isLoggedIn: Bool, userName: String = "", logo: String? = nil) {
    let logoToUse = logo ?? self.logoName
    if isLoggedIn {
      showHomePage(backgroundColor: .black, userName: userName)
    } else {
      showLoginPage(backgroundColor: .white, logo: logoToUse)
    }
  }
  
  public func addDynamicTab(viewController: UIViewController, atIndex index: Int? = nil) {
    tabBarController?.addTab(viewController: viewController, atIndex: index)
  }
  
  public func removeTab(atIndex index: Int) {
    tabBarController?.removeTab(atIndex: index)
  }
  
  public func updateTab(atIndex index: Int, withTitle title: String, image: UIImage? = nil) {
    tabBarController?.updateTab(atIndex: index, withTitle: title, image: image)
  }
  
  public func updateHomeStatusCard(backgroundColor: UIColor, labelColor: UIColor, cardHeight: CGFloat = 100) {
    if let homeViewController = getViewController(ofType: HomeViewController.self) {
      homeViewController.updateCard(backgroundColor: backgroundColor, labelColor: labelColor, cardHeight: cardHeight)
    }
  }
  
  private func getViewController<T: UIViewController>(ofType type: T.Type) -> T? {
    guard let navController = tabBarController?.viewControllers?.first(where: {
      ($0 as? UINavigationController)?.topViewController is T
    }) as? UINavigationController else {
      return nil
    }
    return navController.topViewController as? T
  }
  
  public func selectTab(atIndex index: Int) {
    guard let tabBarController = self.tabBarController else {
      print("TabBarController is not set.")
      return
    }
    
    guard index >= 0 && index < (tabBarController.viewControllers?.count ?? 0) else {
      print("Index is out of bounds.")
      return
    }
    
    tabBarController.selectedIndex = index
  }
}
