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
                }
                withAnimation {
                    dataLoaded = true
                }
            }
            .overlay {
                Group {
                    if dataLoaded {
                        if userVM.isLoggedIn {
                            if userVM.hasChoseTaste {
                                DiscoveryView()
                            } else {
                                TasteView()
                            }
                        } else {
                            BoardingView()
                        }
                    } else {
                        LoadingView()
                    }
                }
                .foregroundColor(secondaryColor)
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
