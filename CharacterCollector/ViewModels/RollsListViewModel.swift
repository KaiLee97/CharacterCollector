//
//  RollsListViewModel.swift
//  CharacterCollector
//
//  Created by Haesong Lee on 10/22/22.
//

import Foundation
import SwiftUI

@MainActor
class RollsListViewModel: ObservableObject {
    @Published var jikanModel: JikanModel = JikanModel(json: [:])
    @Published var jikanModelList: [JikanModel] = []
    @Published var rollCount: Int = 10
    
    let network = Network()
    
    func completeCharacterRoll() async -> Error? {
        guard rollCount > 0 else { return nil }
        if let model = try? await network.getRandomCharacter() {
            jikanModel = model
            jikanModelList.insert(jikanModel, at: 0)
            rollCount -= 1
            return nil
        } else {
            jikanModel.isFailedModel = true
            jikanModelList.insert(jikanModel, at: 0)
            return NSError()
        }
    }
    
    func removeFailedModelsFromList() -> Void {
        jikanModelList.removeAll(where: { $0.isFailedModel ?? false })
    }
}
