//
//  TasteView.swift
//  GATask
//
//  Created by Amir Mohammadi on 2/23/1402 AP.
//

import SwiftUI
import Neumorphic
import SwiftUIFlowLayout

struct TasteView: View {

    @ObservedObject private var userVM = UserVM.shared
    @ObservedObject private var contentVM = ContentVM.shared

    @State private var choseCategories: [String] = []

    var body: some View {
        VStack(spacing: 25) {
            Spacer()
            VStack(spacing: 10) {
                Image(systemName: "books.vertical")
                    .font(.largeTitle)
                Text("Choose categories you like to read about")
                    .font(.subheadline.bold())
            }
            if contentVM.allCategories.isEmpty {
                Spacer()
                LoadingView()
                    .padding()
                Spacer()
            } else {
                FlowLayout(mode: .vstack,
                           items: contentVM.allCategories,
                           itemSpacing: 8) { data in
                    Button {
                        if choseCategories.contains(data) {
                            choseCategories.removeAll {
                                $0.contains(data)
                            }
                        } else {
                            choseCategories.append(data)
                        }
                    } label: {
                        Text(data)
                            .font(.footnote.monospaced().bold())
                    }
                    .softButtonStyle(
                        RoundedRectangle(cornerRadius: 10),
                        mainColor: choseCategories.contains(data) ? .red : mainColor,
                        textColor: choseCategories.contains(data) ? .white : secondaryColor,
                        darkShadowColor: choseCategories.contains(data)
                                                            ? .redNeuDS
                                                            : Color.Neumorphic.darkShadow,
                        lightShadowColor: choseCategories.contains(data)
                                                            ? .redNeuLS
                                                            : Color.Neumorphic.lightShadow,
                        pressedEffect: .flat
                    )
                }
                .padding()
            }
            Button {
                Task {
                    userDefaults.set(choseCategories, forKey: "userChosenTastes")
                    userVM.chosenTastes = choseCategories
                    userDefaults.set(true, forKey: "userChoseTaste")
                    if let token = userVM.userToken {
                        if let contents = await ContentAPI.shared.getAllContents(accessToken: token) {
                            contentVM.allContents = contents
                            contents.forEach { entry in
                                if userVM.chosenTastes.contains(entry.category) {
                                    contentVM.followedContent.append(entry)
                                }
                            }
                        }
                    }
                    withAnimation {
                        userVM.hasChoseTaste = true
                    }
                }
            } label: {
                Text("Continue")
                    .font(.subheadline.bold())
                    .textCase(.uppercase)
                    .frame(width: uiWidth * 0.75)
            }
            .softButtonStyle(
                RoundedRectangle(cornerRadius: 10),
                pressedEffect: .flat
            )
            .disabled(choseCategories.isEmpty)
            Spacer()
        }
        .padding()
        .task(priority: .high) {
            if let token = UserVM.shared.userToken {
                if let data = await ContentAPI.shared.getCategoriesList(accessToken: token) {
                    contentVM.allCategories = data
                }
            }
        }
    }
}

struct TasteView_Previews: PreviewProvider {
    static var previews: some View {
        TasteView()
    }
}
