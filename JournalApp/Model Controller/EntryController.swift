//
//  EntryController.swift
//  JournalApp
//
//  Created by Jonathan Llewellyn on 11/5/21.
//

import Foundation

class EntryController {
    
    // MARK: - Properties
    //Shared Instance
    static let shared = EntryController()
    
    // SOT
    var entries: [Entry] = []
    
    init() {
        loadFromPersistentStorage()
    }
    
    // MARK: - CRUD
    
    // Create entry function:
    func createEntryWith(title: String, body: String) {
        let entry = Entry(title: title, body: body)
        entries.append(entry)
        saveToPersistentStorage()
    }
    
    // Create delete entry function:
    func deleteEntry(entry: Entry) {
        guard let index = entries.firstIndex(of: entry) else { return }
        entries.remove(at: index)
        saveToPersistentStorage()
    }
    
    /**
    Used to update an `Entry` and the timestamp on it
    - Parameters:
    - entry: The `Entry` that we want to update
    - title: The title that we want to update our `Entry` title too
    - details: The details that we want to update our `Entry` details too
    */
    func updateEntry(entry: Entry, title: String, body: String) {
        entry.title = title
        entry.body = body
        saveToPersistentStorage()
    }
    
    // MARK: - Persistence
    /**
    Used to create a file path for a location to save our data
    - Returns: A URL used to specify file location
    */
    private func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileName = "journal.json"
        let documentsDirectoryURL = urls[0].appendingPathComponent(fileName)
        return documentsDirectoryURL
    }
    
    /**
    Saves the current entries array as data to a file on disk
    */
    private func saveToPersistentStorage() {
        let jsonEncoder = JSONEncoder()
        do {
            let data = try jsonEncoder.encode(entries)
            try data.write(to: fileURL())
        } catch {
            print(error.localizedDescription)
        }
    }
    
    /**
    Loads saved data from disk, decodes the data into an array of Entry and assigns that array to the source of truth (entries) on the Entry Controller
    */
    private func loadFromPersistentStorage() {
        let jsonDecoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: fileURL())
            let entries = try jsonDecoder.decode([Entry].self, from: data)
            self.entries = entries
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
