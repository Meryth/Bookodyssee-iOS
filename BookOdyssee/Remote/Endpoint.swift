//
//  Endpoint.swift
//  BookOdyssee
//
//  Created by Elna on 04.01.24.
//

import Foundation

let baseUrl : String = "www.googleapis.com"

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]
    
     init(path: String, queryItems: [URLQueryItem] = []) {
        self.path = path
        self.queryItems = queryItems
    }
}

extension Endpoint {
    static func searchBooks(query: String) -> Endpoint {
        return Endpoint(
            path: "/books/v1/volumes",
            queryItems: [
                URLQueryItem(name: "q", value: query)
            ]
        )
    }
    
    static func getBookById(id: String) -> Endpoint {
        return Endpoint(path: "/books/v1/volumes/\(id)")
    }
    
    var url: URL? {

        var components = URLComponents()
        components.scheme = "https"
        components.host = baseUrl
        components.path = path
        components.queryItems = queryItems
        
        return components.url
    }
}

