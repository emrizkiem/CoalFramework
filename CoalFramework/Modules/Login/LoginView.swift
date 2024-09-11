//
//  LoginView.swift
//  CoalFramework
//
//  Created by ArifRachman on 05/09/24.
//

import SwiftUI
import LegionUI
import ThemeLGN

struct LoginView: View {
  @StateObject private var viewModel: LoginViewModel
  private let headerImageName: String?
  private let backgroundColor: Color
  
  init(config: ConfigModel? = nil, headerImageName: String? = nil, backgroundColor: Color = .white) {
    _viewModel = StateObject(wrappedValue: LoginViewModel(config: config))
    self.headerImageName = headerImageName
    self.backgroundColor = backgroundColor
  }
  
  var body: some View {
    NavigationView {
      VStack(spacing: 40) {
        headerView
        Spacer()
        bottomSheetView
      }
      .background(Color.mainBackground)
    }
    .navigationBarBackButtonHidden(true)
  }
  
  private var headerView: some View {
    HeaderImageView(clientImageName: headerImageName, remoteImageURL: viewModel.configHeader?.image)
      .frame(width: 125, height: 125)
      .padding(.top, 60)
  }
  
  private var bottomSheetView: some View {
    LGNBottomSheet(isShowing: .constant(true), dragable: false) {
      VStack(alignment: .leading, spacing: 5) {
        HeaderView(configHeader: viewModel.configHeader)
        if let form = viewModel.formFields {
          FormView(form: form, viewModel: viewModel)
          ButtonView(form: form)
        }
        Spacer()
        FooterView()
      }
      .padding(.horizontal, 20)
    }
  }
}

struct HeaderView: View {
  let configHeader: ConfigHeader?
  
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(configHeader?.title ?? CoalString.loginTitle)
        .lgnHeading5()
      Text(configHeader?.description ?? CoalString.loginDescription)
        .lgnBodySmallRegular()
    }
    .padding(.top, 20)
  }
}

struct HeaderImageView: View {
  let clientImageName: String?
  let remoteImageURL: String?
  
  var body: some View {
    Group {
      if let urlString = remoteImageURL, let url = URL(string: urlString) {
        AsyncImage(url: url) { image in
          image.resizable().scaledToFit()
        } placeholder: {
          ProgressView()
        }
      } else if let imageName = clientImageName, let image = UIImage(named: imageName) {
        Image(uiImage: image)
          .resizable()
          .scaledToFit()
      } else {
        Image(uiImage: UIImage.logo!)
          .resizable()
          .scaledToFit()
      }
    }
  }
}

struct FormView: View {
  let form: [ConfigField]
  @ObservedObject var viewModel: LoginViewModel
  
  var body: some View {
    VStack(spacing: 12) {
      ForEach(form.filter { $0.type != .checkbox && $0.type != .submit }) { field in
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

struct ButtonView: View {
  let form: [ConfigField]
  
  var body: some View {
    VStack(spacing: 10) {
      HStack {
        Spacer()
        AnchorText(title: CoalString.forgotUsernameOrPassword, tintColor: Color.LGNTheme.secondary500)
          .variant(size: .small)
      }
      
      ForEach(form.filter { $0.type == .submit }) { field in
        CoalButtonView(field: field)
          .padding(.vertical, 10)
      }
      
      HStack(spacing: 2) {
        Text(CoalString.doNotHaveAccount)
          .LGNBodySmall(color: LGNColor.tertiary500)
        NavigationLink(destination: RegisterView()) {
          Text(CoalString.register)
            .LGNBodySmall(color: Color.LGNTheme.secondary500)
        }
      }
      .padding(.vertical, 10)
    }
  }
}

struct FooterView: View {
  var body: some View {
    VStack(spacing: 8) {
      HStack {
        Spacer()
        Image(uiImage: UIImage.icInfo!)
          .frame(width: 16, height: 16)
          .foregroundColor(LGNColor.tertiary500)
        Text(CoalString.haveAccountProblem)
          .LGNBodySmall(color: LGNColor.tertiary500)
        Spacer()
      }
      AnchorText(title: CoalString.contactUs, tintColor: Color.LGNTheme.secondary500)
        .variant(size: .small)
    }
  }
}

//struct LoginView_Previews: PreviewProvider {
//  static var previews: some View {
//    LoginView()
//  }
//}
