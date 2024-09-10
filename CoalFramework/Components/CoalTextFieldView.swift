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
  
  private var isPasswordField: Bool {
    field.type == .password
  }
  
  private var secureButton: some View {
    Button(action: {
      isSecure.toggle()
    }) {
      Image(uiImage: isSecure ? UIImage.eyeOff! : UIImage.eyeOn!)
    }
  }
  
  var body: some View {
    VStack(alignment: .leading) {
      OutlineTxtField(
        titleKey: LocalizedStringKey(field.placeholder ?? ""),
        text: $value,
        label: field.label ?? ""
      )
      .setSecured($isSecure)
      .setRightView(isPasswordField ? secureButton : nil)
      .padding(.top, 10)
    }
  }
}
