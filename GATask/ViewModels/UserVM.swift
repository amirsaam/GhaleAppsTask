//
//  UserVM.swift
//  GATask
//
//  Created by Amir Mohammadi on 2/26/1402 AP.
//

import Foundation

class UserVM: ObservableObject {
    public static let shared = UserVM()

    @Published var userToken: String? {
        didSet {
            if let token = userToken {
                userDefaults.set(token, forKey: "userToken")
                isLoggedIn = testUserToken(token)
                hasChoseTaste = userDefaults.bool(forKey: "userChoseTaste")
                if hasChoseTaste {
                    if let taste = userDefaults.stringArray(forKey: "userChosenTastes") {
                        chosenTastes = taste
                    }
                }
            }
        }
    }
    @Published var isLoggedIn = false
    @Published var hasChoseTaste = false
    @Published var chosenTastes: [String] = []

    func testUserToken(_ token: String) -> Bool {
        // should create a test subject to vlidate the token for now we just assume it's valid
        return true
    }
}
