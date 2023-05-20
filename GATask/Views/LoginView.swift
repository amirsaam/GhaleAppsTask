//
//  LoginView.swift
//  GATask
//
//  Created by Amir Mohammadi on 2/26/1402 AP.
//

import SwiftUI
import Neumorphic

struct LoginView: View {

    @Binding var showLoginView: Bool

    @State private var userLogin = ""
    @State private var userPass = ""
    @State private var showLoginError = false

    var body: some View {
        ZStack {
            mainColor
                .edgesIgnoringSafeArea(.all)
            HStack {
                Spacer()
                VStack(spacing: 20) {
                    Spacer()
                    Logo()
                        .frame(width: uiWidth * 0.4)
                    Text("Welcome Back!")
                        .font(.title.bold().italic().monospaced())
                    VStack(spacing: 15) {
                        TextField("Username", text: $userLogin)
                        Divider()
                        SecureField("Password", text: $userPass)
                    }
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .frame(width: uiWidth * 0.7)
                    .padding(.top)
                    if showLoginError {
                        Text("Login failed! Check your details and try again.")
                            .font(.footnote)
                            .foregroundColor(.red)
                            .padding(.top)
                    }
                    Button {
                        Task {
                            UserVM.shared.userToken = await ContentAPI.shared.getAuthToken(
                                username: userLogin,
                                password: userPass
                            )
                            if UserVM.shared.userToken != nil {
                                showLoginView = false
                            } else {
                                withAnimation {
                                    showLoginError = true
                                }
                            }
                        }
                    } label: {
                        Text("Login")
                            .font(.headline.bold())
                            .textCase(.uppercase)
                            .frame(width: uiWidth * 0.65)
                    }
                    .softButtonStyle(
                        RoundedRectangle(cornerRadius: 10),
                        pressedEffect: .flat
                    )
                    .disabled(userLogin.isEmpty || userPass.isEmpty)
                    .padding(.top)
                    Text("Don't have an account? Join our [Waitlist](https://www.example.com)!")
                        .font(.subheadline)
                    Spacer()
                }
                Spacer()
            }
        }
        .foregroundColor(secondaryColor)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(showLoginView: .constant(true))
    }
}
