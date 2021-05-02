//
//  SaveLocationDataUtility.swift
//  WeatherDetails
//
//  Created by Pranith Margam on 01/05/21.
//

import Foundation

class SaveLocationDataUtility {
    static let bookmarkedLocationsKey = "bookmarkedLocations"
    static let unitSystemKey = "unitSystemKey"
    
    static func saveBookmarkedlocations(_ locations: [Location]) {        
        let jsonEncoder = JSONEncoder()
        if let encoded = try? jsonEncoder.encode(locations) {
            UserDefaults.standard.removeObject(forKey: bookmarkedLocationsKey)
                  UserDefaults.standard.setValue(encoded, forKey: bookmarkedLocationsKey)
        }
    }
    
    static func getBookmarkedLocations() -> [Location] {
        let jsonDecoder = JSONDecoder()
        guard let encodedLocationsData = UserDefaults.standard.value(forKey: bookmarkedLocationsKey) as? Data, let decoded = try? jsonDecoder.decode([Location].self, from: encodedLocationsData) else {
            return []
        }
        return decoded
    }
    
    static func removeAllBookmarks() {
        UserDefaults.standard.removeObject(forKey: bookmarkedLocationsKey)
    }
    
    static func saveUnitValue(unit: UnitSystem) {
        UserDefaults.standard.setValue(unit.stringValue, forKey: unitSystemKey)
    }
    
    static func lastSavedUnitValue() -> String {
        UserDefaults.standard.value(forKey: unitSystemKey) as? String ?? ""
    }
}
