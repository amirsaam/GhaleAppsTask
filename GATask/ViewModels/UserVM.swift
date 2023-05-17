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
            }
        }
    }
    @Published var isLoggedIn = false
    @Published var hasChoosedTaste = false
    @Published var choosenTastes: [String] = []

    func testUserToken(_ token: String) -> Bool {
        // should create a test subject to vlidate the token for now we just assume it's valid
        return true
    }
}
