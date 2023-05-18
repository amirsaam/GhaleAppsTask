//
//  ContentView.swift
//  GATask
//
//  Created by Amir Mohammadi on 2/22/1402 AP.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var userVM = UserVM.shared
    @State var dataLoaded = false
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
                            if userVM.hasChoosedTaste {
                                DiscoveryView()
                            } else {
                                TasteView()
                            }
                        } else {
                            BoardingView()
                        }
                    } else {
                        ProgressView("Loading...")
                            .controlSize(.large)
                            .font(.footnote)
                            .textCase(.uppercase)
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
