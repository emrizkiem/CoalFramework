//
//  CoalButtonView.swift
//  CoalFramework
//
//  Created by ArifRachman on 04/09/24.
//

import SwiftUI
import ThemeLGN

struct CoalButtonView: View {
  let field: ConfigField
  var isDisabled: Bool? = nil
  
  var body: some View {
    LGNSolidButton(title: field.label ?? "BUTTON", defaultBtnColor: Color.redButton)
      .disableInteraction(isDisabled == true)
      .variant(size: .medium, responsive: true)
      .padding(.top, 10)
  }
}
