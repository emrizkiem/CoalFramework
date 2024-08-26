//
//  UIImageView.swift
//  CoalFramework
//
//  Created by ArifRachman on 23/08/24.
//

import UIKit

public extension UIImageView {
  func loadImage(from url: URL, placeholder: UIImage? = nil, completion: ((Bool) -> Void)? = nil) {
    self.image = placeholder
    
    let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
      guard let self = self, error == nil, let data = data, let image = UIImage(data: data) else {
        DispatchQueue.main.async {
          completion?(false)
        }
        return
      }
      DispatchQueue.main.async {
        self.image = image
        completion?(true)
      }
    }
    task.resume()
  }
}

