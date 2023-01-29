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
    private var store = JikanStore()
    private init() {
        JikanStore.load { result in
            switch result {
            case .failure(let error):
                fatalError(error.localizedDescription)
            case .success(let jikans):
                self.store.jikans = jikans
                self.claimedList = jikans
            }
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
    
    deinit {
        JikanStore.save(jikans: claimedList) { result in
            if case .failure(let error) = result {
                fatalError(error.localizedDescription)
            }
        }
    }
}
