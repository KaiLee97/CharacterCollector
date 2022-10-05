//
//  ContentView.swift
//  CharacterCollector
//
//  Created by Haesong Lee on 10/5/22.
//

import Foundation
import SwiftUI

struct ContentView: View {
    @State private var title: String = ""
    @State private var name: String = ""
    @State private var url: String = ""
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text(title)
            Spacer()
            Text(name)
            Spacer()
            AsyncImage(url: URL(string: url))
            Spacer()
            Button {
                Task {
                    let randomId = Int.random(in: 1...218135)
                    let urlString = "https://api.jikan.moe/v4/characters/" + "\(randomId)" + "/full"
                    let (data, _) = try await URLSession.shared.data(from: URL(string: urlString)!)
                    let json = try JSONSerialization.jsonObject(with: data)
                    let model = JikanModel(json: json as! [String : Any])
                    title = model.title
                    name = model.characterName
                    url = model.imageJpg
                }
            } label: {
                Text("Fetch title")
            }
        }
        .padding(.vertical, 16)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
