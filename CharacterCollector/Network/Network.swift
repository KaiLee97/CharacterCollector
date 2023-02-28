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
        var randomId: Int
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 1.5
        let session = URLSession(configuration: sessionConfig)
        for _ in 0..<3 {
            randomId = Int.random(in: 1...218135)
            guard let url = URL(string: jikanApiUrl + "\(randomId)" + "/full") else { fatalError("Missing URL") }
            do {
                let (data, response) = try await session.data(for: URLRequest(url: url))
                guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                    print("Bad api header")
                    continue
                }
                let json = try JSONSerialization.jsonObject(with: data)
                return JikanModel(json: json as! [String : Any])
            } catch {
                print("Timeout")
                continue
            }
        }
        return nil
    }
}
