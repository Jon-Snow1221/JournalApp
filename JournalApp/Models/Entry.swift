//
//  Entry.swift
//  JournalApp
//
//  Created by Jonathan Llewellyn on 11/5/21.
//

import Foundation

class Entry: Codable {
    var title: String
    var body: String
    var timestamp: Date
    
    // MARK: - Initilizer
    // By passing in timestamp it gives us the option to set our own if we want in the future. If we don't pass one in then it just has a default value of the current Date
    init(title: String, body: String, timestamp: Date = Date()) {
        self.title = title
        self.body = body
        self.timestamp = timestamp
    }
}

extension Entry: Equatable {
    static func == (lhs: Entry, rhs: Entry) -> Bool {
        return lhs.title == rhs.title &&
        lhs.body == rhs.body &&
        lhs.timestamp == rhs.timestamp
    }
}
