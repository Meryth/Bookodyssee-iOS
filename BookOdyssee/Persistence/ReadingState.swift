//
//  ReadingState.swift
//  BookOdyssee
//
//  Created by Elna on 15.01.24.
//

import Foundation

enum ReadingState : String {
    case toRead
    case reading
    case finished
    
    var description : String {
        switch self {
        case .toRead: return "TO_READ"
        case .reading: return "READING"
        case .finished: return "FINISHED"
        }
    }
}
