//
//  DiscoveryView.swift
//  GATask
//
//  Created by Amir Mohammadi on 2/23/1402 AP.
//

import SwiftUI
import Neumorphic

struct DiscoveryView: View {

    @ObservedObject private var contentVM = ContentVM.shared
    @ObservedObject private var userVM = UserVM.shared

    @Namespace private var animation

    @State private var selectedList = "Followed by You"
    @State private var showNewPost = false
    @State private var showLogout = false

    var body: some View {
        NavigationView {
            ZStack {
                mainColor
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        ScrollViewReader { proxy in
                            ZStack {
                                Capsule()
                                    .fill(mainColor)
                                    .frame(height: 45)
                                    .softInnerShadow(
                                        Capsule(),
                                        radius: 2.5
                                    )
                                    .padding(.horizontal, 5)
                                HStack {
                                    HorizontalCategoriesListView(
                                        selectedList: $selectedList,
                                        listName: "Followed by You",
                                        animationNamespace: animation
                                    )
                                    ForEach(contentVM.allCategories, id: \.self) { list in
                                        HorizontalCategoriesListView(
                                            selectedList: $selectedList,
                                            listName: list,
                                            animationNamespace: animation
                                        )
                                    }
                                }
                                .padding(.horizontal)
                            }
                            .onChange(of: selectedList) { value in
                                proxy.scrollTo(selectedList, anchor: .center)
                            }
                        }
                    }
                    .padding(.top)
                    TabView(selection: $selectedList) {
                        EntriesListView(category: "Followed by You")
                            .tag("Followed by You")
                        ForEach(contentVM.allCategories, id: \.self) { list in
                            EntriesListView(category: list)
                                .tag(list)
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .padding(.top)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Feeds")
                        .font(.title3.bold())
                        .foregroundColor(secondaryColor)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showNewPost = true
                    } label: {
                        Image(systemName: "plus")
                            .font(.caption2)
                    }
                    .softButtonStyle(
                        Circle(),
                        padding: 8,
                        pressedEffect: .flat
                    )
                    .padding(.trailing, 15)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showLogout = true
                    } label: {
                        Image(systemName: "figure.walk.departure")
                            .font(.caption2)
                    }
                    .softButtonStyle(
                        Circle(),
                        padding: 7,
                        pressedEffect: .flat
                    )
                }
            }
        }
        .sheet(isPresented: $showNewPost) {
            NewPostView(showNewPostView: $showNewPost)
        }
        .sheet(isPresented: $showLogout) {
            LogoutView(showLogoutView: $showLogout)
                .presentationDetents([.medium])
        }
    }
}

struct DiscoveryView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoveryView()
    }
}
