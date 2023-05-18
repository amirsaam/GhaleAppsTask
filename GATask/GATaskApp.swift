//
//  GATaskApp.swift
//  GATask
//
//  Created by Amir Mohammadi on 2/22/1402 AP.
//

import SwiftUI
import Neumorphic

let mainColor = Color.Neumorphic.main
let secondaryColor = Color.Neumorphic.secondary
let userDefaults = UserDefaults.standard
let uiWidth = UIScreen.main.bounds.width
let uiHeight = UIScreen.main.bounds.height

@main
struct GATaskApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
