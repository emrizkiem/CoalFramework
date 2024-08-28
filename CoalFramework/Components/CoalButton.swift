//
//  CoalButton.swift
//  CoalFramework
//
//  Created by M. Rizki Maulana on 15/08/24.
//

import UIKit

public class CoalButton: UIView {
  
  public lazy var button: UIButton = {
    let button = UIButton(type: .system)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    button.clipsToBounds = true
    return button
  }()
  
  public init(title: String, titleColor: UIColor, backgroundColor: UIColor, borderWidth: CGFloat = 0, borderColor: UIColor? = nil, cornerRadius: CGFloat = 8) {
    super.init(frame: .zero)
    button.setTitle(title, for: .normal)
    button.setTitleColor(titleColor, for: .normal)
    button.backgroundColor = backgroundColor
    button.layer.borderWidth = borderWidth
    button.layer.borderColor = borderColor?.cgColor
    button.layer.cornerRadius = cornerRadius
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupView() {
    addSubview(button)
    button.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      button.topAnchor.constraint(equalTo: topAnchor),
      button.leadingAnchor.constraint(equalTo: leadingAnchor),
      button.trailingAnchor.constraint(equalTo: trailingAnchor),
      button.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
  
  public func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
    button.addTarget(target, action: action, for: controlEvents)
  }
}
