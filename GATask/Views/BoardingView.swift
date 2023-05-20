//
//  BoardingView.swift
//  GATask
//
//  Created by Amir Mohammadi on 2/23/1402 AP.
//

import SwiftUI
import Neumorphic

struct BoardingView: View {

    @State private var showLoginForm = false

    var body: some View {
        ZStack {
            PathView()
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    Button {
                        showLoginForm = true
                    } label: {
                        Text("Login")
                            .textCase(.uppercase)
                            .font(.headline.bold())
                            .frame(width: uiWidth * 0.65)
                    }
                    .softButtonStyle(
                        RoundedRectangle(cornerRadius: 10),
                        pressedEffect: .flat
                    )
                    Text("Hop into our [Waitlist](https://www.example.com) to gain early access!")
                        .font(.subheadline)
                        .padding(.top)
                }
                Spacer()
            }
            .padding(.bottom, 50)
        }
        .sheet(isPresented: $showLoginForm) {
            LoginView(showLoginView: $showLoginForm)
        }
    }
}

struct BoardingView_Previews: PreviewProvider {
    static var previews: some View {
        BoardingView()
    }
}
