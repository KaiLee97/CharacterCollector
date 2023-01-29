//
//  JikanStore.swift
//  CharacterCollector
//
//  Created by Haesong Lee on 1/29/23.
//

import Foundation
import SwiftUI

class JikanStore: ObservableObject {
    @Published var jikans: [JikanModel] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("jikans.data")
    }
    
    static func load(completion: @escaping (Result<[JikanModel], Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                let jikanModels = try JSONDecoder().decode([JikanModel].self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(jikanModels))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    static func save(jikans: [JikanModel], completion: @escaping (Result<Int, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(jikans)
                let outfile = try fileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(jikans.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
