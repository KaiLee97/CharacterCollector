//
//  Character.swift
//  CharacterCollector
//
//  Created by Haesong Lee on 2/28/23.
//

import Foundation
import SwiftUI

struct Character: Identifiable, Equatable, Codable, Hashable {
    var id = UUID()
    var name: String
    var mediaTitle: String
    var imageURLString: String
    var isLoaded: State = .loading
    
    enum State: Codable {
        case loading
        case failed
        case loaded
    }
    
    init() {
        self.name = ""
        self.mediaTitle = ""
        self.imageURLString = ""
    }
    
    init(model: JikanModel) {
        self.name = model.characterName
        self.mediaTitle = model.title
        self.imageURLString = model.imageJpg
        self.isLoaded = .loaded
    }
    
    init(loadingState: State) {
        self.name = ""
        self.mediaTitle = ""
        self.imageURLString = ""
        self.isLoaded = .failed
    }
}

extension Character {
    
    init(name: String, mediaTitle: String, imageURLString: String) {
        self.name = name
        self.mediaTitle = mediaTitle
        self.imageURLString = imageURLString
        self.isLoaded = .loaded
    }
    
    static let testData: [Character] = {
        return [Character(name: "Roxy Migurdia", mediaTitle: "Mushoku Tensei: Isekai Ittara Honki Dasu", imageURLString: "https://cdn.myanimelist.net/images/characters/4/423670.jpg")]
    }()
}
