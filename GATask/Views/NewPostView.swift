//
//  NewPostView.swift
//  GATask
//
//  Created by Amir Mohammadi on 2/30/1402 AP.
//

import SwiftUI
import Neumorphic

struct NewPostView: View {

    @Binding var showNewPostView: Bool

    @ObservedObject private var userVM = UserVM.shared
    @ObservedObject private var contentVM = ContentVM.shared

    @State private var titleFiled = ""
    @State private var authorField = ""
    @State private var selectedCategory = "News"

    var body: some View {
        ZStack {
            mainColor
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 50) {
                Text("New Post Form")
                    .font(.title2)
                VStack(spacing: 15) {
                    Group {
                        TextField("Article Title", text: $titleFiled)
                        Divider()
                        TextField("Pen Name", text: $authorField)
                    }
                    .textFieldStyle(.plain)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .frame(width: uiWidth * 0.8)
                }
                HStack {
                    Text("Category:")
                    Spacer()
                    Picker("", selection: $selectedCategory) {
                        ForEach(contentVM.allCategories, id: \.self) { cat in
                            Text(cat)
                        }
                    }
                    .pickerStyle(.inline)
                }
                .frame(width: uiWidth * 0.8)
                Button {
                    Task {
                        if let _ = await ContentAPI.shared.postNewContent(accessToken: userVM.userToken ?? "", title: titleFiled, author: authorField, category: selectedCategory) {
                            contentVM.followedContent = []
                            await contentVM.initialiseContent(authToken: userVM.userToken ?? "")
                            showNewPostView = false
                        }
                    }
                } label: {
                    Text("Submit")
                        .font(.headline.bold())
                        .textCase(.uppercase)
                        .frame(width: uiWidth * 0.75)
                }
                .softButtonStyle(
                    RoundedRectangle(cornerRadius: 10),
                    pressedEffect: .flat
                )
                .disabled(titleFiled.isEmpty || authorField.isEmpty)
            }
        }
        .foregroundColor(secondaryColor)
    }
}

struct NewPostView_Previews: PreviewProvider {
    static var previews: some View {
        NewPostView(showNewPostView: .constant(true))
    }
}
