//
//  RollsListViewModel.swift
//  CharacterCollector
//
//  Created by Haesong Lee on 10/22/22.
//

import Foundation
import SwiftUI

class RollsListViewModel: ObservableObject {
    @Published var characterList: [Character] = []
    @Published var rollCount: Int = 10
    @Published var loadingState = State.idle
    @ObservedObject private(set) var manager = CharacterManager.shared
    
    enum State {
        case idle
        case loading
        case failed
        case loaded
    }
    
    let network = Network()
    
    @MainActor
    func completeCharacterRoll() -> Void {
        guard rollCount > 0 else { return }
        loadingState = .loading
        var character = Character()
        characterList.insert(character, at: 0)
        Task {
            let model = try? await network.getRandomCharacter()
            await MainActor.run {
                if let model = model {
                    characterList.removeAll(where: { $0.id == character.id })
                    character = Character(model: model)
                    characterList.insert(character, at: 0)
                    loadingState = .loaded
                    rollCount -= 1
                } else {
                    characterList.removeAll(where: { $0.id == character.id })
                    character = Character(loadingState: .failed)
                    characterList.insert(character, at: 0)
                    loadingState = .loaded
                }
            }
        }
    }
    
    @MainActor
    func retryCharacterRoll(id: UUID) -> Void {
        guard rollCount > 0 else { return }
        loadingState = .loading
        characterList.removeAll(where: { $0.id == id })
        var character = Character()
        characterList.insert(character, at: 0)
        Task {
            let model = try? await network.getRandomCharacter()
            await MainActor.run {
                if let model = model {
                    characterList.removeAll(where: { $0.id == character.id })
                    character = Character(model: model)
                    characterList.insert(character, at: 0)
                    loadingState = .loaded
                    rollCount -= 1
                } else {
                    characterList.removeAll(where: { $0.id == character.id })
                    character = Character(loadingState: .failed)
                    characterList.insert(character, at: 0)
                    loadingState = .loaded
                }
            }
        }
    }
}
