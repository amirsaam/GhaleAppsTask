//
//  ContentAPIClass.swift
//  GATask
//
//  Created by Amir Mohammadi on 2/22/1402 AP.
//

import Foundation
import Alamofire
import Semaphore

class ContentAPI {
    public static let shared = ContentAPI()
    private let baseAPI = "http://138.201.58.73:3030/api/"

    func getAuthToken(username: String, password: String) async -> String? {
        let semaphore = AsyncSemaphore(value: 0)
        var requestResponse: String?

        guard let url = URL(string: baseAPI + "login") else { return nil }
        debugPrint("ContentAPI: Trying to fetch data from URL: \(url)")

        let params: [String: String] = ["username": username,
                                        "password": password]
        let headers: HTTPHeaders = ["Content-Type": "application/json"]

        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoder: .json,
                   headers: headers)
        .responseDecodable(of: [String: String].self) {
            (response: DataResponse<[String: String], AFError>) in
            switch response.result {
            case .success(let data):
                requestResponse = data["token"]
                debugPrint("ContentAPI: Data of type [String: String] fetched.")
            case .failure(let error):
                requestResponse = nil
                debugPrint("ContentAPI: Failed to fetch data of type [String: String]. Alamofire error log: \(error)")
            }
            semaphore.signal()
        }
        
        await semaphore.wait()
        return requestResponse
    }
}
