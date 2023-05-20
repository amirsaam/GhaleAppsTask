//
//  DetailedView.swift
//  GATask
//
//  Created by Amir Mohammadi on 2/23/1402 AP.
//

import SwiftUI
import Neumorphic
import CachedAsyncImage

struct DetailedView: View {

    @State var content: PostedContent

    @ObservedObject private var contentVM = ContentVM.shared

    @State private var isLiked = false
    @State private var showAlreadyLikedError = false

    var body: some View {
        NavigationView {
            ZStack {
                mainColor
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 25) {
                    VStack(alignment: .leading, spacing: 15) {
                        if let url = URL(string: "Placeholder") {
                            CachedAsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            } placeholder: {
                                Rectangle()
                                    .fill(.regularMaterial)
                                    .overlay {
                                        ProgressView()
                                    }
                            }
                            .frame(width: uiWidth * 0.9, height: uiHeight * 0.25)
                            .cornerRadius(15)
                            .softOuterShadow()
                            .overlay {
                                HStack {
                                    VStack {
                                        Spacer()
                                        Text(contentVM.loremSentence)
                                            .font(.title3.monospaced())
                                            .padding([.leading, .bottom])
                                    }
                                    Spacer()
                                }
                            }
                        }
                        Text("by " + content.author + " in " + content.category)
                            .font(.subheadline.monospaced().bold())
                    }
                    Text(contentVM.loremParagraph)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, 7.5)
                    Spacer()
                    HStack(spacing: 20) {
                        Button {
                            Task {
                                if isLiked {
                                    withAnimation {
                                        showAlreadyLikedError = true
                                    }
                                } else {
                                    if let likeResult = await ContentAPI.shared.likeTheContent(
                                        accessToken: UserVM.shared.userToken ?? "",
                                        contentID: content.id
                                    ) {
                                        isLiked = likeResult["message"] == "Content liked successfully"
                                        if isLiked {
                                            if let data = await ContentAPI.shared.getDetailedContent(
                                                accessToken: UserVM.shared.userToken ?? "",
                                                contentID: content.id
                                            ) {
                                                content = data
                                            }
                                        }
                                    }
                                }
                            }
                        } label: {
                            HStack {
                                Image(systemName: isLiked ? "heart.fill" : "heart")
                                    .foregroundColor(isLiked ? .red : secondaryColor)
                                Text(String(content.likes))
                            }
                        }
                        .softButtonStyle(
                            RoundedRectangle(cornerRadius: 10),
                            pressedEffect: .flat
                        )
                        if showAlreadyLikedError {
                            Text("You already liked this post!")
                                .font(.footnote)
                                .foregroundColor(.red)
                        }
                    }
                    Spacer()
                }
                .padding()
            }
            .navigationTitle(content.title)
        }
        .foregroundColor(secondaryColor)
    }
}

struct DetailedView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedView(
            content: PostedContent(id: 1,
                                   title: "TestArticle",
                                   author: "TestAuthor",
                                   category: "TestCategory",
                                   likes: 11)
            )
    }
}
