//
//  PostedContents.swift
//  GATask
//
//  Created by Amir Mohammadi on 2/22/1402 AP.
//

import Foundation

struct PostedContents: Codable {
    let id: Int
    let title: String
    let author: String
    let category: String
    let likes: Int
}
