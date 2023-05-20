//
//  ContentVM.swift
//  GATask
//
//  Created by Amir Mohammadi on 2/28/1402 AP.
//

import Foundation
import Semaphore

class ContentVM: ObservableObject {
    public static let shared = ContentVM()

    @Published var allCategories: [String] = []
    @Published var allContents: [PostedContent]?
    @Published var followedContent: [PostedContent] = []

    let loremSentence = "Lorem ipsum dolor sit amet"
    let loremParagraph = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

    private var updateFollowedTask: Task<Void, Never>?

    @MainActor func initialiseContent(authToken: String) async {
        if let cats = await ContentAPI.shared.getCategoriesList(accessToken: authToken) {
            allCategories = cats
        }
        if let cons = await ContentAPI.shared.getAllContents(accessToken: authToken) {
            allContents = cons
            cons.forEach { entry in
                if UserVM.shared.chosenTastes.contains(entry.category) {
                    followedContent.append(entry)
                }
            }
        }
    }

    func updateFollowedContents() {
        updateFollowedTask?.cancel()
        updateFollowedTask = Task { @MainActor in
            let semaphore = AsyncSemaphore(value: 0)
            followedContent.removeAll()
            if let data = allContents {
                data.forEach { entry in
                    if UserVM.shared.chosenTastes.contains(entry.category) {
                        followedContent.append(entry)
                        semaphore.signal()
                    }
                }
                await semaphore.wait()
            }
        }
    }
}
