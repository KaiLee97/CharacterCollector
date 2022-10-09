//
//  JikanModel.swift
//  CharacterCollector
//
//  Created by Haesong Lee on 10/5/22.
//

import SwiftUI

let defaultText: String = "N/A"
struct JikanModel: Hashable, Identifiable {
    let id = UUID()
    var characterId: Int = 0
    var characterName: String  = defaultText
    var title: String = defaultText
    var imageJpg: String = defaultText
    
    var imageUrl: URL? {return URL(string: imageJpg)}
    
    init(json: [String:Any]) {
        if let data = json["data"] as? [String:Any] {
            if let name = data["name"] {self.characterName = "\(name)"}
            if let images = data["images"] as? [String:Any] {
                if let jpg = images["jpg"] as? [String:Any] {
                    if let image = jpg["image_url"] {self.imageJpg = "\(image)"}
                }
            }
            if let anime = data["anime"] as? [[String:Any]] {
                if let details = anime.first?["anime"] as? [String:Any] {
                    if let title = details["title"] {self.title = "\(title)"}
                }
            } else if let manga = data["manga"] as? [[String:Any]] {
                if let details = manga.first?["manga"] as? [String:Any] {
                    if let title = details["title"] {self.title = "\(title)"}
                }
            }
        }
    }
}
