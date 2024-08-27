//
//  CoalLabel.swift
//  CoalFramework
//
//  Created by ArifRachman on 12/08/24.
//

import UIKit

public class CoalLabel: UILabel {
  public init(fontSize: CGFloat, weight: UIFont.Weight = .regular, text: String? = nil, textColor: UIColor = .black) {
    super.init(frame: .zero)
    self.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
    self.text = text
    self.textColor = textColor
    self.numberOfLines = 0
    self.translatesAutoresizingMaskIntoConstraints = false
    setupView()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupView()
  }
  
  public func setupView() {}
}
