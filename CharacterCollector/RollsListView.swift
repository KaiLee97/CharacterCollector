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
    @State private var rollCount: Int = 10
    let network = Network()
    var body: some View {
        ZStack {
            Color.black.opacity(0.95).ignoresSafeArea()
            VStack(alignment: .center, spacing: 0) {
                Spacer()
                if jikanModelList.count != 0 {
                    ScrollViewReader { proxy in
                        ScrollView(.vertical) {
                            LazyVStack {
                                ForEach(jikanModelList, id: \.self) { model in
                                    CharacterTile(jikanModel: model)
                                        .id(model)
                                        .padding(.vertical, 8)
                                        .padding(.horizontal, 48)
                                }
                            }
                        }
                        .onChange(of: jikanModelList.count, perform: { value in
                            proxy.scrollTo(jikanModelList[0])
                        })
                    }
                } else {
                    Text("You have " + "\(rollCount)" + " rolls left")
                        .font(.title2)
                        .foregroundColor(Color.white)
                        .padding()
                }
                Spacer()
                HStack {
                    Text("\(rollCount)" + " rolls left")
                        .foregroundColor(Color.white)
                        .padding()
                    Spacer()
                    Button {
                        Task {
                            do {
                                jikanModel = try await network.getRandomCharacter()
                                rollCount -= 1
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
                    .disabled(rollCount == 0)
                    .padding()
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
