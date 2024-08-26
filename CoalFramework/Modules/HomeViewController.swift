//
//  HomeViewController.swift
//  CoalFramework
//
//  Created by ArifRachman on 08/08/24.
//

import UIKit

public class HomeFactory {
  public static func createHomePage(backgroundColor: UIColor, userName: String) -> HomeViewController {
    return HomeViewController(backgroundColor: backgroundColor, userName: userName)
  }
}

public class HomeViewController: CoalViewController {
  private let userName: String
  private let cardTitle: String
  private let cardSubtitle: String
  private let cardContent: String
  
  private lazy var welcomeLabel: CoalLabel = {
    let label = CoalLabel(fontSize: 24, weight: .bold, text: "Welcome, \(userName)")
    return label
  }()
  
  private lazy var coalCardView: CoalCardView = {
    let view = CoalCardView()
    view.updateCardView(title: cardTitle,
                      subtitle: cardSubtitle,
                      content: cardContent,
                      backgroundColor: .lightGray,
                      textColor: .black)
    return view
  }()
  
  public init(backgroundColor: UIColor, userName: String, cardTitle: String = "Status", cardSubtitle: String = "Active", cardContent: String = "Registered at 08/08/2024") {
    self.userName = userName
    self.cardTitle = cardTitle
    self.cardSubtitle = cardSubtitle
    self.cardContent = cardContent
    super.init(backgroundColor: backgroundColor)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public override func setupNavigationBar() {
    setNavigationBar(type: .titleAndLogout(title: nil))
  }
  
  public override func rightNavigationBarButtonTapped(sender: UIBarButtonItem?) {
    CoalNotifications.userDidLogout.post()
  }
  
  override public func setupView() {
    super.setupView()
    view.addSubview(welcomeLabel)
    view.addSubview(coalCardView)
    setupConstraints()
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
      welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      
      coalCardView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 40),
      coalCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      coalCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
    ])
  }
  
  public func updateCard(backgroundColor: UIColor, labelColor: UIColor, cardHeight: CGFloat = 100) {
    coalCardView.updateCardView(title: cardTitle,
                              subtitle: cardSubtitle,
                              content: cardContent,
                              backgroundColor: backgroundColor,
                              textColor: labelColor,
                              cardHeight: cardHeight)
  }
}

extension HomeViewController: CoalTabInfoProviding {
  public func coalTabInfo() -> CoalTabInfo {
    return CoalTabInfo(title: "Home", icon: UIImage.home)
  }
}
