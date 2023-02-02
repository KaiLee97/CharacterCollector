//
//  JikanManager.swift
//  CharacterCollector
//
//  Created by Haesong Lee on 1/29/23.
//

import Foundation
import SwiftUI

class JikanManager: ObservableObject {
    static let shared = JikanManager()
    private init() {
        if let retrievedData = UserDefaults.standard.data(forKey: "claimedList") {
            self.claimedList = try! JSONDecoder().decode([JikanModel].self, from: retrievedData)
        }
    }
    
    @Published private(set) var claimedList = [JikanModel]()
    
    func claimCharacter(char: JikanModel) {
        claimedList.insert(char, at: 0)
    }
    
    func unclaimCharacter(char: JikanModel) {
        guard claimedList.contains(char) else { return }
        // Don't consider dupes for now
        claimedList.removeAll(where: {$0 == char})
    }
    
    func clearClaimList() {
        claimedList.removeAll()
    }
}
