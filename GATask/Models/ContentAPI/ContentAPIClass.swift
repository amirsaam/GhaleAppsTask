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

        let params = ["username": username, "password": password]
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

    func getCategoriesList(accessToken: String) async -> [String]? {
        let returnValue: [String]?
        let path = "categories"
        let fetchedData = await fetchDataGet(accessToken: accessToken, apiPath: path, retrurnType: [String].self)
        if let categories = fetchedData {
            returnValue = categories
        } else {
            returnValue = nil
        }
        return returnValue
    }

    func getAllContents(accessToken: String) async -> [PostedContent]? {
        let returnValue: [PostedContent]?
        let path = "content"
        let fetchedData = await fetchDataGet(accessToken: accessToken, apiPath: path, retrurnType: [PostedContent].self)
        if let allContents = fetchedData {
            returnValue = allContents
        } else {
            returnValue = nil
        }
        return returnValue
    }

    func getFilteredContents(accessToken: String, filters: [String]) async -> [PostedContent]? {
        let returnValue: [PostedContent]?
        let path = "content/filter"
        let params = ["categories": filters]
        let fetchedData = await fetchDataPost(accessToken: accessToken, apiPath: path,
                                              parameters: params, returnType: [PostedContent].self)
        if let filteredContents = fetchedData {
            returnValue = filteredContents
        } else {
            returnValue = nil
        }
        return returnValue
    }

    func getDetailedContent(accessToken: String, contentID: Int) async -> PostedContent? {
        let returnValue: PostedContent?
        let path = "content/" + String(contentID)
        let fetchedData = await fetchDataGet(accessToken: accessToken, apiPath: path, retrurnType: PostedContent.self)
        if let filteredContents = fetchedData {
            returnValue = filteredContents
        } else {
            returnValue = nil
        }
        return returnValue
    }

    func likeTheContent(accessToken: String, contentID: Int) async -> [String: String]? {
        let returnValue: [String: String]?
        let path = "content/" + String(contentID) + "/like"
        let fetchedData = await fetchDataPost(accessToken: accessToken, apiPath: path,
                                              parameters: nil as Int?, returnType: [String: String].self)
        if let filteredContents = fetchedData {
            returnValue = filteredContents
        } else {
            returnValue = nil
        }
        return returnValue
    }

    func postNewContent(accessToken: String, title: String, author: String, category: String) async -> PostedContent? {
        let returnValue: PostedContent?
        let path = "content"
        let params = NewContent(title: title, author: author, category: category, likes: 0)
        let fetchedData = await fetchDataPost(accessToken: accessToken, apiPath: path,
                                              parameters: params, returnType: PostedContent.self)
        if let filteredContents = fetchedData {
            returnValue = filteredContents
        } else {
            returnValue = nil
        }
        return returnValue
    }

    private func fetchDataGet<T: Codable>(
        accessToken: String,
        apiPath: String,
        retrurnType: T.Type
    ) async -> T? {

        let semaphore = AsyncSemaphore(value: 0)
        var requestResponse: T?

        guard let url = URL(string: baseAPI + apiPath) else { return nil }
        debugPrint("ContentAPI: Trying to fetch data from URL: \(url)")

        let headers: HTTPHeaders = ["Authorization": accessToken]

        AF.request(url,
                   method: .get,
                   headers: headers)
        .responseDecodable(of: T.self) {
            (response: DataResponse<T, AFError>) in
            switch response.result {
            case .success(let data):
                requestResponse = data
                debugPrint("ContentAPI: Data of type \(T.self) fetched.")
            case .failure(let error):
                requestResponse = nil
                debugPrint("ContentAPI: Failed to fetch data of type \(T.self). Alamofire error log: \(error)")
            }
            semaphore.signal()
        }
        
        await semaphore.wait()
        return requestResponse
    }

    private func fetchDataPost<T1: Codable, T2: Codable>(
        accessToken: String,
        apiPath: String,
        parameters: T2?,
        returnType: T1.Type
    ) async -> T1? {
        
        let semaphore = AsyncSemaphore(value: 0)
        var requestResponse: T1?
        
        guard let url = URL(string: baseAPI + apiPath) else { return nil }
        debugPrint("ContentAPI: Trying to fetch data from URL: \(url)")
        
        let headers: HTTPHeaders = ["Authorization": accessToken, "Content-Type": "application/json"]
        
        AF.request(url,
                   method: .post,
                   parameters: parameters,
                   encoder: .json,
                   headers: headers)
        .responseDecodable(of: T1.self) {
            (response: DataResponse<T1, AFError>) in
            switch response.result {
            case .success(let data):
                requestResponse = data
                debugPrint("ContentAPI: Data of type \(T1.self) fetched.")
            case .failure(let error):
                requestResponse = nil
                debugPrint("ContentAPI: Failed to fetch data of type \(T1.self). Alamofire error log: \(error)")
            }
            semaphore.signal()
        }
        
        await semaphore.wait()
        return requestResponse
    }
}
