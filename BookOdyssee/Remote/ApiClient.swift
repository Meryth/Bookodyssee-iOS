//
//  NetworkService.swift
//  BookOdyssee
//
//  Created by Elna on 04.01.24.
//

import Foundation

let apiKey: String = "AIzaSyCB0pJ6U7O32HS2J4WogSM31LsIvVleJws"

struct ApiClient {
    
    func getBooksBySearchTerm(endpoint : Endpoint) async throws -> RemoteBookList {
        
        guard let requestUrl = endpoint.url else {
            throw NetworkError.InvalidUrlError
        }
        
        var request = URLRequest(url: requestUrl)
        request.setValue(apiKey, forHTTPHeaderField: "X-goog-api-key")
        
        //TODO: handle possible invalid json error and nil data response
        let (data, response) = try await URLSession.shared.data(for: request)
        
        let books = try! JSONDecoder().decode(RemoteBookList.self, from: data)
        
        print(books)
        
        return books
    }
}
