//
//  ContentView.swift
//  GATask
//
//  Created by Amir Mohammadi on 2/22/1402 AP.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var userVM = UserVM.shared
    @State private var dataLoaded = false
    var body: some View {
        mainColor
            .edgesIgnoringSafeArea(.all)
            .task(priority: .high) {
                if let token = userDefaults.string(forKey: "userToken") {
                    userVM.userToken = token
                    await ContentVM.shared.initialiseContent(authToken: token)
                }
                withAnimation {
                    dataLoaded = true
                }
            }
            .overlay {
                Group {
                    if dataLoaded {
                        if userVM.isLoggedIn {
                            Group {
                                if userVM.hasChoseTaste {
                                    DiscoveryView()
                                } else {
                                    TasteView()
                                }
                            }
                        } else {
                            BoardingView()
                        }
                    } else {
                        LoadingView()
                    }
                }
                .foregroundColor(secondaryColor)
                .accentColor(secondaryColor)
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
