//
//  CharacterTile.swift
//  CharacterCollector
//
//  Created by Haesong Lee on 10/7/22.
//

import Foundation
import SwiftUI

struct CharacterTile: View {
    let jikanModel: JikanModel
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            AsyncImage(url: URL(string: jikanModel.imageJpg)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image.resizable()
                         .aspectRatio(contentMode: .fit)
                         .frame(maxWidth: 200, maxHeight: 200)
                case .failure:
                    Image(systemName: "photo")
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 200, maxHeight: 200)
                @unknown default:
                    // Since the AsyncImagePhase enum isn't frozen,
                    // we need to add this currently unused fallback
                    // to handle any new cases that might be added
                    // in the future:
                    EmptyView()
                }
            }
            .padding()
            
            HStack(alignment: .center, spacing: 0) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Name: " + jikanModel.characterName)
                        .font(.headline)
                        .multilineTextAlignment(.leading)
                    Text("Manga/Anime: " + jikanModel.title)
                        .font(.headline)
                        .multilineTextAlignment(.leading)
                }
                .foregroundColor(Color.white)
                .layoutPriority(100)
            }
            .padding()
        }
        .background(Color.indigo.opacity(0.2))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
        )
        .padding(.top, 16)
        .padding(.horizontal, 32)
    }
}
