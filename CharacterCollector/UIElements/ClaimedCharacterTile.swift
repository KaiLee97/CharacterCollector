//
//  ClaimedCharacterTile.swift
//  CharacterCollector
//
//  Created by Kai Lee on 3/5/23.
//

import Foundation
import SwiftUI

struct ClaimedCharacterTile: View {
    let character: Character
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Image(systemName: "heart.fill")
                .foregroundColor(.red)
                .font(.system(size: 12))
            VStack(alignment: .leading, spacing: 4) {
                Text("Name: ").bold().font(.title3) + Text(character.name).font(.title2)
                Text("Series: ").bold().font(.body) + Text(character.mediaTitle).font(.body)
            }
            .foregroundColor(Color.white)
            Spacer()
            AsyncImage(url: URL(string: character.imageURLString)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 30, maxHeight: 50)
                case .failure:
                    Image(systemName: "photo")
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 30, maxHeight: 50)
                @unknown default:
                    // Since the AsyncImagePhase enum isn't frozen,
                    // we need to add this currently unused fallback
                    // to handle any new cases that might be added
                    // in the future:
                    EmptyView()
                }
            }
        }
    }
}
