//
//  BoardingView.swift
//  GATask
//
//  Created by Amir Mohammadi on 2/23/1402 AP.
//

import SwiftUI
import Neumorphic

struct BoardingView: View {
    @State var showLoginModal = false
    var body: some View {
        GeometryReader { geo in
            ZStack {
                mainColor
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 20) {
                    Spacer()
                    Image(systemName: "fleuron.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geo.size.width * 0.7)
                        .softOuterShadow()
                    Button {
                        showLoginModal = true
                    } label: {
                        Text("Log In")
                            .font(.headline.bold())
                            .textCase(.uppercase)
                            .frame(width: geo.size.width * 0.7)
                    }
                    .softButtonStyle(
                        RoundedRectangle(cornerRadius: 15),
                        pressedEffect: .flat
                    )
                    .padding(.top)
                    Text("Got an invite? Login to your account")
                    Spacer()
                }
            }
        }
        .sheet(isPresented: $showLoginModal) {
            LoginView()
        }
        .foregroundColor(secondaryColor)
    }
}

struct BoardingView_Previews: PreviewProvider {
    static var previews: some View {
        BoardingView()
    }
}
