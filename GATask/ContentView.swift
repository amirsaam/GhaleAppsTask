//
//  ContentView.swift
//  GATask
//
//  Created by Amir Mohammadi on 2/22/1402 AP.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var userVM = UserVM.shared
    var body: some View {
        Group {
            if userVM.isLoggedIn {
                TasteView()
            } else {
                BoardingView()
            }
        }
        .task {
            if let token = userDefaults.string(forKey: "userToken") {
                userVM.userToken = token
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
