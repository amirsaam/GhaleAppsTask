//
//  BoardingView.swift
//  GATask
//
//  Created by Amir Mohammadi on 2/23/1402 AP.
//

import SwiftUI
import Neumorphic

struct BoardingView: View {
    @State private var userLogin = ""
    @State private var userPass = ""
    var body: some View {
        GeometryReader { geo in
            ZStack {
                mainColor
                    .edgesIgnoringSafeArea(.all)
                HStack {
                    Spacer()
                    VStack(spacing: 20) {
                        Spacer()
                        Group {
                            Image(systemName: "fleuron.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geo.size.width * 0.2)
                            Text("Welcome Back!")
                                .font(.title.bold().italic())
                        }
                        .softOuterShadow()
                        VStack(spacing: 10) {
                            TextField("Username", text: $userLogin)
                            Divider()
                            SecureField("Password", text: $userPass)
                        }
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)
                        .frame(width: geo.size.width * 0.7)
                        .padding(.top)
                        Button {
                            
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
                        Text("Hop into our [Waitlist](https://www.example.com) to gain early access!")
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

struct BoardingView_Previews: PreviewProvider {
    static var previews: some View {
        BoardingView()
    }
}
