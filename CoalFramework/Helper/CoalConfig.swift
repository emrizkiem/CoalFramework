//
//  CoalConfig.swift
//  CoalFramework
//
//  Created by ArifRachman on 08/08/24.
//

import UIKit
import LegionUI
import ThemeLGN

public class CoalConfig {
  public static let shared = CoalConfig()
  
  private init() {
    if let config = ConfigModel.currentConfig {
      updateConfig(with: config)
    } else {
      fetchConfig()
    }
  }

  public var transition: UIView.AnimationOptions = .transitionCrossDissolve
  public var animationDuration: TimeInterval = 0.5
  public var splashScreenDuration: TimeInterval = 2.0
  
  public var window: UIWindow?
  private let network = NetworkManager.shared
  
  public func configure(window: UIWindow?, transition: UIView.AnimationOptions = .transitionCrossDissolve, animationDuration: TimeInterval = 0.5, splashScreenDuration: TimeInterval = 2.0) {
    self.transition = transition
    self.animationDuration = animationDuration
    self.splashScreenDuration = splashScreenDuration
    self.window = window
    LGN.configure()
  }
  
  public func fetchConfig() {
    network.request(endpoint: CoalAPI.getConfig, responseType: ConfigModel.self) { result in
      switch result {
      case .success(let config):
        self.updateConfig(with: config)
      case .failure(let error):
        self.handleFetchError(error)
      }
    }
  }
  
  private func updateConfig(with config: ConfigModel) {
    config.save()
  }
  
  private func handleFetchError(_ error: ApiError) {
    switch error {
    default:
      print("Error: \(error.localizedDescription)")
    }
  }
}
