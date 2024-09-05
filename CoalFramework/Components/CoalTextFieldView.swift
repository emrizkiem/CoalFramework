//
//  CoalTextFieldView.swift
//  CoalFramework
//
//  Created by ArifRachman on 04/09/24.
//

import SwiftUI
import LegionUI

struct CoalTextFieldView: View {
  let field: ConfigField
  @Binding var value: String
  @Binding var isSecure: Bool
  
  var body: some View {
    VStack(alignment: .leading) {
      OutlineTxtField(
        titleKey: LocalizedStringKey(field.placeholder ?? ""),
        text: $value,
        label: field.label ?? ""
      )
      .setSecured($isSecure)
      .padding(.top, 10)
    }
  }
}
