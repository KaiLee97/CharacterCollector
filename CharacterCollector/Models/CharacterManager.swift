//
//  JikanManager.swift
//  CharacterCollector
//
//  Created by Haesong Lee on 1/29/23.
//

import Foundation
import SwiftUI

class CharacterManager: ObservableObject {
    static let shared = CharacterManager()
    private init() {
        if let retrievedData = UserDefaults.standard.data(forKey: "claimedList") {
            let data = try? JSONDecoder().decode([Character].self, from: retrievedData)
            self.claimedList = data ?? []
        } else {
            self.claimedList = []
        }
    }
    
    @Published private(set) var claimedList = [Character]()
    
    func claimCharacter(char: Character) {
        claimedList.insert(char, at: 0)
    }
    
    func unclaimCharacter(char: Character) {
        guard claimedList.contains(char) else { return }
        // Don't consider dupes for now
        claimedList.removeAll(where: {$0 == char})
    }
    
    func clearClaimList() {
        claimedList.removeAll()
    }
}
