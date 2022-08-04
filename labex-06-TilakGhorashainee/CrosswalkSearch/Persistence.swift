//
//  Persistence.swift
//  CrosswalkSearch
//
//  Created by Paul Inventado on 4/11/22.
//
import Foundation
import SwiftUI

class SearchHistory: ObservableObject {
    // MARK: Lifecycle

    init() {
        // TODO: Create a path to a file named crosswalks.plist and store in fileURL
        //   fileURL = URL(string: "")! // Delete this line and replace with your code
        //

        let documentsDirectory =
            FileManager.default.urls(for: .documentDirectory,
                                     in: .userDomainMask).first!

        fileURL =
            documentsDirectory.appendingPathComponent("crosswalks")
                .appendingPathExtension("plist")
        loadHistory()
    }

    // MARK: Internal

    @Published var searchStrings: [String] = []
    var maxsearches: Int = 5
    var fileURL: URL

    func addSearchString(_ searchString: String) {
        if searchStrings.count == maxsearches {
            searchStrings.remove(at: maxsearches - 1)
        }
        searchStrings.insert(searchString, at: 0)
        saveHistory()
    }

    func saveHistory() {
        // TODO: Save the searchStrings array into a file
        let propertyListEncoder = PropertyListEncoder()
        if let encodedVolunteer = try?
            propertyListEncoder.encode(searchStrings)
        {
            try? encodedVolunteer.write(to: fileURL, options: .noFileProtection)
        }
    }

    func loadHistory() {
        // TODO: Load data from the file and store it in searchString
        let propertyListDecoder = PropertyListDecoder()
        if let retrievedURL = try? Data(contentsOf: fileURL),
           let decodedURL = try?
           propertyListDecoder.decode([String].self,
                                      from: retrievedURL)
        {
            searchStrings = decodedURL
        }
    }
}
