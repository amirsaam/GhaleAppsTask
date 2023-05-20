//
//  EntriesListView.swift
//  GATask
//
//  Created by Amir Mohammadi on 2/30/1402 AP.
//

import SwiftUI
import Neumorphic
import CachedAsyncImage

struct EntriesListView: View {

    @State var category: String

    @ObservedObject private var contentVM = ContentVM.shared

    @State private var contentToShow: [PostedContent]?
    @State private var showChangeTasteView = false

    var body: some View {
        Group {
            if let content = contentToShow {
                List {
                    if category == "Followed by You" {
                        HStack {
                          Text("You can manage your followed categories here")
                                .font(.footnote.bold())
                          Spacer()
                          Button {
                              showChangeTasteView = true
                          } label: {
                            Image(systemName: "arrow.right")
                          }
                          .softButtonStyle(
                            Circle(),
                            padding: 8,
                            pressedEffect: .flat
                          )
                        }
                        .padding(.vertical, 5)
                        .listRowBackground(mainColor)
                        .sheet(isPresented: $showChangeTasteView) {
                            ChangeTasteView(showChangeTaste: $showChangeTasteView)
                                .presentationDetents([.medium])
                        }
                        .onChange(of: showChangeTasteView) { newValue in
                            if !newValue {
                                contentToShow = contentVM.followedContent
                                userDefaults.set(UserVM.shared.chosenTastes, forKey: "userChosenTastes")
                            }
                        }
                    }
                    ForEach(content, id: \.id) { data in
                        NavigationLink {
                            DetailedView(content: data)
                        } label: {
                            HStack(spacing: 15) {
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
                                    .frame(width: 60, height: 60)
                                    .cornerRadius(15)
                                    .softOuterShadow()
                                }
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(data.title)
                                        .font(.headline)
                                    Text("by: " + data.author)
                                        .font(.subheadline)
                                }
                                Spacer()
                                VStack(spacing: 5) {
                                    Image(systemName: "heart")
                                        .font(.headline)
                                    Text(String(data.likes))
                                        .font(.subheadline)
                                }
                            }
                        }
                        .listRowBackground(mainColor)
                    }
                }
                .listStyle(.plain)
                .refreshable {
                    contentVM.followedContent = []
                    await contentVM.initialiseContent(authToken: UserVM.shared.userToken ?? "")
                }
            } else {
                LoadingView()
            }
        }
        .task {
            if category == "Followed by You" {
                contentToShow = contentVM.followedContent
            } else {
                if let data = contentVM.allContents {
                    contentToShow = data.filter {
                        $0.category == category
                    }
                }
            }
        }
    }
}
