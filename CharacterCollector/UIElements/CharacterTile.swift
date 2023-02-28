//
//  CharacterTile.swift
//  CharacterCollector
//
//  Created by Haesong Lee on 10/7/22.
//

import Foundation
import SwiftUI

struct CharacterTile: View {
    var character: Character
    @State var showView: Bool = false
    @State var claimStatus: Bool?
    let retryAction: (() -> Void)
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            switch character.isLoaded {
            case .loaded:
                AsyncImage(url: URL(string: character.imageURLString)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 300, maxHeight: 500)
                    case .failure:
                        Image(systemName: "photo")
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 300, maxHeight: 500)
                    @unknown default:
                        // Since the AsyncImagePhase enum isn't frozen,
                        // we need to add this currently unused fallback
                        // to handle any new cases that might be added
                        // in the future:
                        EmptyView()
                    }
                }
                .padding()
                
                HStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Name: " + character.name)
                            .font(.headline)
                            .multilineTextAlignment(.leading)
                        Text("Manga/Anime: " + character.mediaTitle)
                            .font(.headline)
                            .multilineTextAlignment(.leading)
                    }
                    .foregroundColor(Color.white)
                    Spacer()
                    Button {
                        if let claimStatus = claimStatus, claimStatus {
                            CharacterManager.shared.unclaimCharacter(char: character)
                        } else {
                            CharacterManager.shared.claimCharacter(char: character)
                        }
                        claimStatus?.toggle()
                    } label: {
                        VStack(alignment: .center, spacing: 8) {
                            if let claimStatus = claimStatus, claimStatus {
                                Text("Claimed")
                                    .multilineTextAlignment(.leading)
                                Image(systemName: "heart.fill")
                            } else {
                                Text("Claim!")
                                    .multilineTextAlignment(.leading)
                                Image(systemName: "heart")
                            }
                        }
                        .padding(8)
                        .font(.headline)
                        .foregroundColor(Color.yellow)
                        .background(Color.black)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .stroke(.gray.opacity(0.2), lineWidth: 1)
                        )
                    }
                    .layoutPriority(100)
                    .onAppear {
                        if claimStatus == nil {
                            claimStatus = character.claimed
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical)
            case .failed:
                Spacer()
                Text("Failed to fetch character")
                    .font(.headline)
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(Color.white)
                    .layoutPriority(100)
                    .padding()
                Button {
                    retryAction()
                } label: {
                    Image(systemName: "arrow.triangle.2.circlepath")
                        .font(.system(size: 32))
                        .frame(width: 300)
                }
                Text("Tap to try again")
                    .font(.caption)
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(Color.white)
                Spacer()
            case .loading:
                Spacer()
                Text("Loading character")
                    .font(.headline)
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(Color.white)
                    .layoutPriority(100)
                    .padding()
                ProgressView()
                    .frame(width: 300)
                Spacer()
            }
            
        }
        .background(Color.indigo.opacity(0.2))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(.gray.opacity(0.2), lineWidth: 1)
        )
        .offset(x: showView ? 0 : 450)
        .onAppear {
            withAnimation(.linear(duration: 0.2)) {
                showView = true
            }
        }
    }
}
