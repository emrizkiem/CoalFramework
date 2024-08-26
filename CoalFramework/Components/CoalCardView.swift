//
//  CoalCardView.swift
//  CoalFramework
//
//  Created by ArifRachman on 12/08/24.
//

import UIKit

public class CoalCardView: UIView {
  
  private lazy var titleLabel: CoalLabel = {
    return CoalLabel(fontSize: 18, weight: .bold)
  }()
  
  private lazy var subtitleLabel: CoalLabel = {
    return CoalLabel(fontSize: 18, weight: .bold)
  }()
  
  private lazy var contentLabel: CoalLabel = {
    return CoalLabel(fontSize: 18, weight: .bold)
  }()
  
  private lazy var stackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel, contentLabel])
    stackView.axis = .vertical
    stackView.spacing = 5
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  private var heightConstraint: NSLayoutConstraint?
  
  public var cardHeight: CGFloat = 100 {
    didSet {
      heightConstraint?.constant = cardHeight
    }
  }
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupView()
  }
  
  private func setupView() {
    self.backgroundColor = .lightGray
    self.layer.cornerRadius = 10
    self.translatesAutoresizingMaskIntoConstraints = false
    
    addSubview(stackView)
    setupConstraints()
  }
  
  private func setupConstraints() {
    heightConstraint = heightAnchor.constraint(equalToConstant: cardHeight)
    heightConstraint?.isActive = true
    
    NSLayoutConstraint.activate([
      stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
      stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
      stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
    ])
  }
  
  public func updateCardView(
    title: String,
    subtitle: String,
    content: String,
    backgroundColor: UIColor,
    textColor: UIColor,
    cardHeight: CGFloat = 100,
    cornerRadius: CGFloat = 10
  ) {
    titleLabel.text = title
    subtitleLabel.text = subtitle
    contentLabel.text = content
    
    titleLabel.textColor = textColor
    subtitleLabel.textColor = textColor
    contentLabel.textColor = textColor
    
    self.backgroundColor = backgroundColor
    self.layer.cornerRadius = cornerRadius
    self.cardHeight = cardHeight
  }
}
