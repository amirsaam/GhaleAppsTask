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
    let circleRadius: CGFloat = 100
    var body: some View {
        GeometryReader { geo in
            ZStack {
                mainColor
                    .edgesIgnoringSafeArea(.all)
                HStack {
                    Spacer()
                    VStack(spacing: 20) {
                        Spacer()
                        Logo()
                            .frame(width: geo.size.width * 0.4)
                        Text("Welcome Back!")
                            .font(.title.bold().italic().monospaced())
                        VStack(spacing: 15) {
                            TextField("Username", text: $userLogin)
                            Divider()
                            SecureField("Password", text: $userPass)
                        }
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)
                        .frame(width: geo.size.width * 0.7)
                        .padding(.top)
                        Button {
                            Task {
                                UserVM.shared.userToken = await ContentAPI.shared.getAuthToken(
                                    username: userLogin,
                                    password: userPass
                                )
                                showLoginView = false
                            }
                        } label: {
                            Text("Login")
                                .font(.headline.bold())
                                .textCase(.uppercase)
                                .frame(width: geo.size.width * 0.65)
                        }
                        .softButtonStyle(
                            RoundedRectangle(cornerRadius: 10),
                            padding: 8,
                            pressedEffect: .flat
                        )
                        .padding(.top)
                        Text("Don't have an account? Join our [Waitlist](https://www.example.com)!")
                            .font(.subheadline)
                            .padding(.top)
                        Spacer()
                    }
                    Spacer()
                }
            }
            .foregroundColor(secondaryColor)
        }
    }
}


struct Logo: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(secondaryColor)
                .softOuterShadow()
            Circle()
                .fill(mainColor)
                .mask {
                    Path { path in
                        let width = 200.0
                        let height = 500.0
                        
                        path.move(to: CGPoint(x: 0, y: height * 0.1))
                        
                        path.addCurve(
                            to: CGPoint(x: width * 0.55, y: height * 0.06),
                            control1: CGPoint(x: width * 0.3, y: height * 0.3),
                            control2: CGPoint(x: width * 0.2, y: 0)
                        )
                        
                        path.addCurve(
                            to: CGPoint(x: width, y: height * 0.1),
                            control1: CGPoint(x: width, y: height * 0.15),
                            control2: CGPoint(x: width, y: height * 0.05)
                        )

                        path.addLine(to: CGPoint(x: width, y: height))
                        path.addLine(to: CGPoint(x: 0, y: height))
                        path.closeSubpath()
                    }
                }
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(showLoginView: .constant(true))
    }
}
