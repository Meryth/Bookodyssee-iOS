//
//  RemoteBookList.swift
//  BookOdyssee
//
//  Created by Elna on 04.01.24.
//

import Foundation

struct RemoteBookList : Decodable {
    var items: [BookItem]
}

struct BookItem : Decodable, Hashable {
    var id: String
    var volumeInfo: VolumeInfo
}

struct VolumeInfo: Decodable, Hashable {
    var title: String
    var authors: [String]?
    var publisher: String?
    var publishedDate: String
    var description: String?
    var pageCount: Int?
    var imageLinks: BookImageLinks?
}

struct BookImageLinks: Decodable, Hashable {
    var thumbnail: String?
}
