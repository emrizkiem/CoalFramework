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
  private let backgroundColor: Color
  private let headerImageName: String?
  
  init(config: ConfigModel? = nil, headerImageName: String? = nil, backgroundColor: Color = .white) {
    _viewModel = StateObject(wrappedValue: LoginViewModel(config: config))
    self.headerImageName = headerImageName
    self.backgroundColor = backgroundColor
  }
  
  var body: some View {
    VStack(alignment: .leading) {
      HeaderView(configHeader: viewModel.configHeader, localImageName: headerImageName)
      
      if let form = viewModel.formFields {
        FormView(form: form, viewModel: viewModel)
        ButtonView(form: form)
      }
    }
    .padding(.horizontal, 20)
    .background(backgroundColor)
    .edgesIgnoringSafeArea(.all)
  }
}

struct HeaderView: View {
  let configHeader: ConfigHeader?
  let localImageName: String?
  
  var body: some View {
    VStack(spacing: 8) {
      HeaderImageView(localImageName: localImageName, remoteImageURL: configHeader?.image)
        .frame(width: 125, height: 125)
      
      if let title = configHeader?.title {
        Text(configHeader?.title ?? "login_title")
          .LGNHeading4(color: .black)
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.top, 20)
      }
      
      if let description = configHeader?.description {
        Text(description)
          .LGNHeading6(color: .black)
          .frame(maxWidth: .infinity, alignment: .leading)
      }
    }
  }
}

struct HeaderImageView: View {
  let localImageName: String?
  let remoteImageURL: String?
  
  var body: some View {
    if let remoteImageURL = remoteImageURL, let url = URL(string: remoteImageURL) {
      AsyncImage(url: url) { image in
        image
          .resizable()
          .scaledToFit()
      } placeholder: {
        ProgressView()
      }
    } else if let imageName = localImageName, let image = UIImage(named: imageName) {
      Image(uiImage: image)
        .resizable()
        .scaledToFit()
    } else if let defaultImage = UIImage.logo {
      Image(uiImage: defaultImage)
        .resizable()
        .scaledToFit()
    }
  }
}

struct FormView: View {
  let form: [ConfigField]
  @ObservedObject var viewModel: LoginViewModel
  
  var body: some View {
    VStack {
      ForEach(form.indices, id: \.self) { index in
        let field = form[index]
        
        if field.type != .button {
          CoalTextFieldView(
            field: field,
            value: viewModel.binding(for: field),
            isSecure: viewModel.bindingSecure(for: field)
          )
        }
      }
    }
    .padding(.vertical, 10)
  }
}

struct ButtonView: View {
  let form: [ConfigField]
  
  var body: some View {
    VStack {
      HStack {
        Spacer()
        LGNAnchorText(title: "forgot_password")
      }
      
      ForEach(form.indices, id: \.self) { index in
        let field = form[index]
        
        if field.type == .button {
          CoalButtonView(field: field)
        }
      }
    }
  }
}

struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    LoginView(backgroundColor: .white)
  }
}
