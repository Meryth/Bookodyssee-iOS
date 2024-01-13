//
//  NetworkService.swift
//  BookOdyssee
//
//  Created by Elna on 04.01.24.
//

import Foundation

let apiKey: String = "AIzaSyCB0pJ6U7O32HS2J4WogSM31LsIvVleJws"

struct ApiClient {
    
    func apiGet(endpoint : Endpoint) async throws -> Data {
        
        guard let requestUrl = endpoint.url else {
            throw CoreException.InvalidUrlError
        }
        
        var request = URLRequest(url: requestUrl)
        request.setValue(apiKey, forHTTPHeaderField: "X-goog-api-key")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        return data
    }
    
    func getBooksBySearchTerm(endpoint: Endpoint) async throws -> RemoteBookList {
        let data = try await(apiGet(endpoint: endpoint))
        
        let books = try JSONDecoder().decode(RemoteBookList.self, from: data)
        print(books)
        return books
    }
    
    func getBookById(endpoint: Endpoint) async throws -> BookItem {
        let data = try await(apiGet(endpoint: endpoint))
        
        let book = try JSONDecoder().decode(BookItem.self, from: data)
        return book
    }
     
}
