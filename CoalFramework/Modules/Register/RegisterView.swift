//
//  RegisterView.swift
//  CoalFramework
//
//  Created by M. Rizki Maulana on 09/09/24.
//

import SwiftUI
import LegionUI
import ThemeLGN

struct RegisterView: View {
  @StateObject private var viewModel: RegisterViewModel
  private let backgroundColor: Color
  
  init(config: ConfigModel? = nil, backgroundColor: Color = .white) {
    _viewModel = StateObject(wrappedValue: RegisterViewModel(config: config))
    self.backgroundColor = backgroundColor
  }
  
  var body: some View {
    NavigationView {
      VStack {
        bottomSheetView
      }
      .padding(.top, 24)
    }
    .navigationBarBackButtonHidden(true)
  }
  
  private var bottomSheetView: some View {
    LGNBottomSheet(isShowing: .constant(true), dragable: false) {
      VStack(alignment: .leading, spacing: 5) {
        RegisterHeaderView(configHeader: viewModel.configHeader)
        if let form = viewModel.formFields {
          RegisterFormView(form: form, viewModel: viewModel)
          RegisterButtonView(form: form)
        }
        Spacer()
        RegisterFooterView()
      }
      .padding(.horizontal, 20)
    }
  }
}

struct RegisterHeaderView: View {
  let configHeader: ConfigHeader?
  
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(configHeader?.title ?? CoalString.register)
        .lgnHeading5()
      Text(configHeader?.description ?? CoalString.registerDescription)
        .lgnBodySmallRegular()
    }
    .padding(.top, 20)
  }
}

struct RegisterFormView: View {
  let form: [ConfigField]
  @ObservedObject var viewModel: RegisterViewModel
  
  var body: some View {
    VStack(spacing: 12) {
      ForEach(form.filter { $0.type != .submit }) { field in
        CoalTextFieldView(
          field: field,
          value: viewModel.binding(for: field),
          isSecure: viewModel.bindingSecure(for: field)
        )
      }
    }
    .padding(.vertical, 10)
  }
}

struct AgreementView: View {
  @Binding var isAgreed: Bool
  
  var body: some View {
    HStack(alignment: .center, spacing: 4) {
      Checkbox(
        defaultIsChecked: isAgreed,
        size: .medium,
        onToggleChange: { isChecked in
          isAgreed = isChecked
        }
      )
      Text("I agree to")
        .LGNBodySmall(color: .black)
      if #available(iOS 16.0, *) {
        Text("Term & Condition")
          .LGNBodySmall(color: .blue)
          .underline()
      }
      Text("and")
        .LGNBodySmall(color: .black)
      if #available(iOS 16.0, *) {
        Text("Privacy Policy")
          .LGNBodySmall(color: .blue)
          .underline()
      }
    }
    .padding(.horizontal, 10)
  }
}

struct RegisterButtonView: View {
  let form: [ConfigField]
  @State private var isAgreed = false
  
  var body: some View {
    VStack(spacing: 10) {
      AgreementView(isAgreed: $isAgreed)
      
      ForEach(form.filter { $0.type == .submit }) { field in
        CoalButtonView(field: field, isDisabled: !isAgreed)
          .padding(.vertical, 10)
      }
    }
  }
}

struct RegisterFooterView: View {
  var body: some View {
    VStack {
      Spacer()
      HStack(spacing: 2) {
        Spacer()
        Text(CoalString.alreadyHaveAccount)
          .LGNBodySmall(color: LGNColor.tertiary500)
        NavigationLink(destination: LoginView()) {
          Text(CoalString.loginTitle)
            .LGNBodySmall(color: Color.LGNTheme.secondary500)
        }
        Spacer()
      }
      .padding(.bottom, 24)
    }
  }
}

//struct RegisterView_Previews: PreviewProvider {
//  static var previews: some View {
//    RegisterView()
//  }
//}
