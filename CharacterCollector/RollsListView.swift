//
//  RollsListView.swift
//  CharacterCollector
//
//  Created by Haesong Lee on 10/5/22.
//

import Foundation
import SwiftUI

struct RollsListView: View {
    @State private var title: String = ""
    @State private var name: String = ""
    @State private var url: String = ""
    @State private var jikanModel: JikanModel = JikanModel(json: [:])
    let network = Network()
    var body: some View {
        ZStack {
            Color.black.opacity(0.95).ignoresSafeArea()
            VStack(alignment: .center, spacing: 0) {
                Text(title)
                    .foregroundColor(.cyan)
                Spacer()
                Text(name)
                    .foregroundColor(.cyan)
                Spacer()
                AsyncImage(url: URL(string: url))
                Spacer()
                Button {
                    Task {
                        do {
                            jikanModel = try await network.getRandomCharacter()
                            title = jikanModel.title
                            name = jikanModel.characterName
                            url = jikanModel.imageJpg
                        } catch {
                            print("Error", error)
                        }
                    }
                } label: {
                    Text("Fetch character")
                }
            }
            .padding(.vertical, 16)
        }
    }
}

struct RollsListView_Previews: PreviewProvider {
    static var previews: some View {
        RollsListView()
    }
}
