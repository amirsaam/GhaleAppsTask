//
//  Components.swift
//  GATask
//
//  Created by Amir Mohammadi on 2/30/1402 AP.
//

import SwiftUI
import Neumorphic
import CachedAsyncImage
import SwiftUIFlowLayout

struct HorizontalCategoriesListView: View {

    @Binding var selectedList: String

    @State var listName: String
    @State var animationNamespace: Namespace.ID

    var body: some View {
        ZStack {
            if selectedList == listName {
                Capsule()
                    .fill(mainColor)
                    .frame(width: 135, height: 30)
                    .matchedGeometryEffect(id: "list", in: animationNamespace)
                    .softOuterShadow(offset: 2)
            } else {
                Capsule()
                    .foregroundColor(.clear)
                    .frame(width: 135, height: 30)
            }
            Text(listName)
                .font(.subheadline)
                .foregroundColor(selectedList == listName ? secondaryColor : .gray)
                .onTapGesture {
                    withAnimation {
                        selectedList = listName
                    }
                }
                .id(listName)
        }
    }
}

struct ChangeTasteView: View {

    @Binding var showChangeTaste: Bool

    @ObservedObject private var userVM = UserVM.shared
    @ObservedObject private var contentVM = ContentVM.shared

    @State private var choseCategories: [String] = []

    var body: some View {
        ZStack {
            mainColor
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 25) {
                Spacer()
                VStack(spacing: 10) {
                    Image(systemName: "books.vertical")
                        .font(.largeTitle)
                    Text("Choose categories you like to read about")
                        .font(.subheadline.bold())
                }
                FlowLayout(mode: .vstack,
                           items: contentVM.allCategories,
                           itemSpacing: 8) { data in
                    Button {
                        if userVM.chosenTastes.contains(data) {
                            userVM.chosenTastes.removeAll {
                                $0.contains(data)
                            }
                        } else {
                            userVM.chosenTastes.append(data)
                        }
                        contentVM.updateFollowedContents()
                    } label: {
                        Text(data)
                            .font(.footnote.monospaced().bold())
                    }
                    .softButtonStyle(
                        RoundedRectangle(cornerRadius: 10),
                        mainColor: userVM.chosenTastes.contains(data) ? .red : mainColor,
                        textColor: userVM.chosenTastes.contains(data) ? .white : secondaryColor,
                        darkShadowColor: userVM.chosenTastes.contains(data)
                        ? .redNeuDS
                        : Color.Neumorphic.darkShadow,
                        lightShadowColor: userVM.chosenTastes.contains(data)
                        ? .redNeuLS
                        : Color.Neumorphic.lightShadow,
                        pressedEffect: .flat
                    )
                }
                .padding()
            }
        }
    }
}
