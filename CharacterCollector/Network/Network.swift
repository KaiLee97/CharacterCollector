//
//  Network.swift
//  CharacterCollector
//
//  Created by Haesong Lee on 10/6/22.
//

import Foundation
import SwiftUI

class Network {
    private let jikanApiUrl: String = "https://api.jikan.moe/v4/characters/"
    func getRandomCharacter() async throws -> JikanModel? {
        let randomId = Int.random(in: 1...218135)
        guard let url = URL(string: jikanApiUrl + "\(randomId)" + "/full") else { fatalError("Missing URL") }
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            // Do retry logic
            // Send empty model and have tile show retry button.
            print("Error while fetching data")
            return nil
        }
        let json = try JSONSerialization.jsonObject(with: data)
        return JikanModel(json: json as! [String : Any])
    }
}
