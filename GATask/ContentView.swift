//
//  ContentView.swift
//  GATask
//
//  Created by Amir Mohammadi on 2/22/1402 AP.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        if let userToken = defaults.string(forKey: "userToken") {
            
        } else {
            BoardingView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
