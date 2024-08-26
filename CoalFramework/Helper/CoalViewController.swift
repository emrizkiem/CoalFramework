//
//  CoalViewController.swift
//  CoalFramework
//
//  Created by ArifRachman on 08/08/24.
//

import UIKit

open class CoalViewController: UIViewController {
  
  public var backgroundColor: UIColor
  
  public init(backgroundColor: UIColor) {
    self.backgroundColor = backgroundColor
    super.init(nibName: nil, bundle: nil)
  }
  
  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = backgroundColor
    
    setupView()
    setupNavigationBar()
  }
  
  open func setupView() {}
  public func setupNavigationBar() {}
}
