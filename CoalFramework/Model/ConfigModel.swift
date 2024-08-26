//
//  ConfigModel.swift
//  CoalFramework
//
//  Created by ArifRachman on 22/08/24.
//

import Foundation

public struct ConfigModel: Codable {
  let project: ConfigProject?
  let pages: ConfigPages?
  
  func save() {
    CoalPersistent.shared.setCodable(key: .coalConfig, value: self)
  }
  
  static func clear() {
    CoalPersistent.shared.delete(key: .coalConfig)
  }
  
  static var currentConfig: ConfigModel? {
    return CoalPersistent.shared.getCodable(key: .coalConfig, type: ConfigModel.self)
  }
}

public struct ConfigProject: Codable {
  let name: String
  let description: String
}

public struct ConfigPages: Codable {
  let login: ConfigPage?
  let home: ConfigPage?
}

public struct ConfigPage: Codable {
  let header: ConfigHeader?
  let form: ConfigForm?
}

public struct ConfigHeader: Codable {
  let title: String?
  let description: String?
  let image: String?
}

public struct ConfigForm: Codable {
  let username: ConfigField?
  let password: ConfigField?
  let submit: ConfigField?
}

public struct ConfigField: Codable {
  let label: String?
  let placeholder: String?
}
