//
//  RollsListViewModel.swift
//  CharacterCollector
//
//  Created by Haesong Lee on 10/22/22.
//

import Foundation
import SwiftUI

class RollsListViewModel: ObservableObject {
    @Published var jikanModel: JikanModel = JikanModel(json: [:])
    @Published var jikanModelList: [JikanModel] = []
    @Published var rollCount: Int = 10
    
    let network = Network()
    
    func completeCharacterRoll() async -> Error? {
        if let model = try? await network.getRandomCharacter() {
            jikanModel = model
            rollCount -= 1
            jikanModelList.insert(jikanModel, at: 0)
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
