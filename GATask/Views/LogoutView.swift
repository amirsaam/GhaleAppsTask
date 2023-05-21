//
//  LogoutView.swift
//  GATask
//
//  Created by Amir Mohammadi on 2/23/1402 AP.
//

import SwiftUI
import Neumorphic

struct LogoutView: View {

    @Binding var showLogoutView: Bool

    @State var cleanEverything = false

    var body: some View {
        ZStack {
            mainColor
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 50) {
                Text("Logout Options")
                    .font(.title.monospaced().bold())
                HStack {
                    Toggle(isOn: $cleanEverything) {
                        Text("Clean All Settings and Data?")
                            .font(.headline.bold())
                    }
                }
                .padding(.horizontal, 47.5)
                HStack(spacing: 25) {
                    Button {
                        showLogoutView = false
                    } label: {
                        Text("Cancel")
                            .font(.headline.bold())
                            .textCase(.uppercase)
                            .frame(width: uiWidth * 0.3)
                    }
                    .softButtonStyle(
                        RoundedRectangle(cornerRadius: 10),
                        pressedEffect: .flat
                    )
                    Button {
                        if cleanEverything {
                            userDefaults.set(nil, forKey: "userToken")
                            userDefaults.set(false, forKey: "userChoseTaste")
                            let emptyArray: [String] = []
                            userDefaults.set(emptyArray, forKey: "userChosenTastes")
                            ContentVM.shared.followedContent = []
                        }
                        withAnimation {
                            UserVM.shared.isLoggedIn = false
                        }
                    } label: {
                        Text("Logout")
                            .font(.headline.bold())
                            .textCase(.uppercase)
                            .frame(width: uiWidth * 0.3)
                    }
                    .softButtonStyle(
                        RoundedRectangle(cornerRadius: 10),
                        pressedEffect: .flat
                    )
                }
            }
        }
        .foregroundColor(secondaryColor)
    }
}

struct LogoutView_Previews: PreviewProvider {
    static var previews: some View {
        LogoutView(showLogoutView: .constant(true))
    }
}
