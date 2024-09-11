//
//  CoalString.swift
//  CoalFramework
//
//  Created by ArifRachman on 10/09/24.
//

import Foundation

struct CoalString {
  static let bundle = Bundle(for: CoalConfig.self)
  
  static func localized(forKey key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: nil, bundle: bundle, value: "", comment: "")
    return String(format: format, arguments: args)
  }
  
  static let loginTitle = localized(forKey: "login_title")
  static let loginDescription = localized(forKey: "login_description")
  static let forgotUsernameOrPassword = localized(forKey: "forgot_username_password")
  static let doNotHaveAccount = localized(forKey: "dont_have_account")
  static let register = localized(forKey: "register")
  static let haveAccountProblem = localized(forKey: "have_account_problem")
  static let contactUs = localized(forKey: "contact_us")
  static let registerDescription = localized(forKey: "register_description")
  static let termCondition = localized(forKey: "term_condition")
  static let alreadyHaveAccount = localized(forKey: "already_have_account")
  static let zonePhone = localized(forKey: "zone_phone")
}
