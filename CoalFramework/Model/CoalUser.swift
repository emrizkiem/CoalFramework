//
//  CoalUser.swift
//  CoalFramework
//
//  Created by ArifRachman on 13/08/24.
//

import Foundation

struct CoalUser: Codable {
  var accessToken: String?
  var refreshToken: String?
  var data: UserData?
  
  func save() {
    CoalPersistent.shared.setCodable(key: .generalUser, value: self)
  }
  
  static func clear() {
    CoalPersistent.shared.delete(key: .generalUser)
  }
  
  static var currentUser: CoalUser? {
    return CoalPersistent.shared.getCodable(key: .generalUser, type: CoalUser.self)
  }
}

struct UserData: Codable {
  let email: String
  let username: String
  let fullname: String
  let mobileNumber: String
}
