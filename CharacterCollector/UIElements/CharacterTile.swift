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
    @ObservedObject var viewModel: RollsListViewModel
    @State var showView: Bool = false
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            if jikanModel.isFailedModel == nil {
                AsyncImage(url: URL(string: jikanModel.imageJpg)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 150, maxHeight: 200)
                    case .failure:
                        Image(systemName: "photo")
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 150, maxHeight: 200)
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
            } else {
                Spacer()
                Text("Failed to fetch character")
                    .font(.headline)
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(Color.white)
                    .layoutPriority(100)
                    .padding()
                Button {
                    Task {
                        viewModel.removeFailedModelsFromList()
                        await viewModel.completeCharacterRoll()
                    }
                } label: {
                    Image(systemName: "arrow.triangle.2.circlepath")
                        .font(.system(size: 32))
                }
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