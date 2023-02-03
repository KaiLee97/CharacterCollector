//
//  JikanModel.swift
//  CharacterCollector
//
//  Created by Haesong Lee on 10/5/22.
//

import SwiftUI

let defaultText: String = "N/A"
struct JikanModel: Hashable, Identifiable, Codable {
    var id = UUID()
    var characterName: String  = defaultText
    var title: String = defaultText
    var imageJpg: String = defaultText
    var isFailedModel: Bool?
    
    init(json: [String:Any]) {
        if let data = json["data"] as? [String:Any] {
            if let name = data["name"] { self.characterName = "\(name)" }
            if let images = data["images"] as? [String:Any] {
                if let jpg = images["jpg"] as? [String:Any] {
                    if let image = jpg["image_url"] { self.imageJpg = "\(image)" }
                }
            } else {
                self.imageJpg = defaultText
            }
            if let anime = data["anime"] as? [[String:Any]] {
                if let details = anime.first?["anime"] as? [String:Any] {
                    if let title = details["title"] { self.title = "\(title)" }
                }
            } else if let manga = data["manga"] as? [[String:Any]] {
                if let details = manga.first?["manga"] as? [String:Any] {
                    if let title = details["title"] { self.title = "\(title)" }
                }
            }
        }
    }
}

extension JikanModel {
    
    init(characterName: String, title: String, imageJpg: String) {
        self.characterName = characterName
        self.title = title
        self.imageJpg = imageJpg
    }
    
    static let testData: [JikanModel] = {
        return [JikanModel(characterName: "Roxy Migurdia", title: "Mushoku Tensei: Isekai Ittara Honki Dasu", imageJpg: "https://cdn.myanimelist.net/images/characters/4/423670.jpg")]
    }()
}
