//
//  RollsListView.swift
//  CharacterCollector
//
//  Created by Haesong Lee on 10/5/22.
//

import Foundation
import SwiftUI

struct RollsListView: View {
    @State private var jikanModel: JikanModel = JikanModel(json: [:])
    @State private var jikanModelList: [JikanModel] = []
    let network = Network()
    var body: some View {
        ZStack {
            Color.black.opacity(0.95).ignoresSafeArea()
            VStack(alignment: .center, spacing: 0) {
                Spacer()
                ScrollView {
                    LazyVStack {
                        ForEach(jikanModelList) { model in
                            CharacterTile(jikanModel: model)
                        }
                    }
                }
                Spacer()
            }
            .padding(.vertical, 16)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        Task {
                            do {
                                jikanModel = try await network.getRandomCharacter()
                                jikanModelList.insert(jikanModel, at: 0)
                            } catch {
                                print("Error", error)
                            }
                        }
                    } label: {
                        HStack(alignment: .center, spacing: 4) {
                            Text("Roll")
                            Image(systemName: "dice")
                        }
                        .frame(width: 64, height: 32)
                    }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.capsule)
                    .padding()
                }
            }
        }
    }
}

struct RollsListView_Previews: PreviewProvider {
    static var previews: some View {
        RollsListView()
    }
}
