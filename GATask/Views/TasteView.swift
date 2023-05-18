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
    @State private var categories: [String] = []
    @State private var choosedCategories: [String] = []
    var body: some View {
        VStack(spacing: 25) {
            Spacer()
            VStack(spacing: 10) {
                Image(systemName: "books.vertical")
                    .font(.largeTitle)
                Text("Choose at least 3 categories you like to read")
                    .font(.subheadline.bold())
            }
            if categories.isEmpty {
                Spacer()
                LoadingView()
                    .padding()
                Spacer()
            } else {
                FlowLayout(mode: .vstack,
                           items: categories,
                           itemSpacing: 8) { data in
                    Button {
                        if choosedCategories.contains(data) {
                            choosedCategories.removeAll {
                                $0.contains(data)
                            }
                        } else {
                            choosedCategories.append(data)
                        }
                    } label: {
                        Text(data)
                            .font(.footnote.monospaced().bold())
                    }
                    .softButtonStyle(
                        RoundedRectangle(cornerRadius: 10),
                        mainColor: choosedCategories.contains(data) ? .red : mainColor,
                        textColor: choosedCategories.contains(data) ? .white : secondaryColor,
                        darkShadowColor: choosedCategories.contains(data)
                        ? .redNeuDS
                        : Color.Neumorphic.darkShadow,
                        lightShadowColor: choosedCategories.contains(data)
                        ? .redNeuLS
                        : Color.Neumorphic.lightShadow,
                        pressedEffect: .flat
                    )
                }
                .padding()
            }
            Button {
                
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
            .disabled(choosedCategories.count < 3)
            Spacer()
        }
        .padding()
        .task {
            if let token = UserVM.shared.userToken {
                if let data = await ContentAPI.shared.getCategoriesList(accessToken: token) {
                    categories = data
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
