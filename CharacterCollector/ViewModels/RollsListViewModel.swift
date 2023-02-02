//
//  RollsListViewModel.swift
//  CharacterCollector
//
//  Created by Haesong Lee on 10/22/22.
//

import Foundation
import SwiftUI

class RollsListViewModel: ObservableObject {
    @Published var jikanModelList: [JikanModel] = []
    @Published var rollCount: Int = 10
    @Published private(set) var state = State.idle
    @ObservedObject private(set) var manager = JikanManager.shared
    private var jikanModel: JikanModel = JikanModel(json: [:])
    
    enum State {
        case idle
        case loading
        case failed
        case loaded
    }
    
    let network = Network()
    
    func completeCharacterRoll() -> Void {
        guard rollCount > 0 else { return }
        state = .loading
        Task {
            let model = try? await network.getRandomCharacter()
            await MainActor.run {
                if model != nil {
                    jikanModel = model!
                    jikanModelList.insert(jikanModel, at: 0)
                    state = .loaded
                    rollCount -= 1
                } else {
                    jikanModel.isFailedModel = true
                    jikanModelList.insert(jikanModel, at: 0)
                    state = .failed
                }
            }
        }
    }
    
    func removeFailedModelsFromList() -> Void {
        Task {
            await MainActor.run {
                jikanModelList.removeAll(where: { $0.isFailedModel ?? false })
            }
        }
    }
}
