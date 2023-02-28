//
//  RollsListView.swift
//  CharacterCollector
//
//  Created by Haesong Lee on 10/5/22.
//

import Foundation
import SwiftUI

struct RollsListView: View {
    @StateObject var viewModel: RollsListViewModel = RollsListViewModel()
    let network = Network()
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.opacity(0.95).ignoresSafeArea()
                VStack(alignment: .center, spacing: 0) {
                    Spacer()
                    if viewModel.characterList.count != 0 {
                        ScrollViewReader { proxy in
                            ScrollView(.vertical) {
                                LazyVStack {
                                    ForEach(viewModel.characterList, id: \.self) { char in
                                        CharacterTile(character: char, retryAction: {
                                            viewModel.retryCharacterRoll(id: char.id)
                                        })
                                        .id(char)
                                        .padding(.vertical, 8)
                                        .padding(.horizontal, 48)
                                    }
                                }
                            }
                            .onChange(of: viewModel.characterList.count, perform: { value in
                                proxy.scrollTo(viewModel.characterList[0])
                            })
                        }
                    } else {
                        Text("Tap roll to get started!")
                            .font(.title2)
                            .foregroundColor(Color.white)
                            .padding()
                    }
                    Spacer()
                    HStack {
                        Text("\(viewModel.rollCount)" + " rolls left")
                            .foregroundColor(Color.white)
                            .padding()
                        Spacer()
                        Button {
                            viewModel.completeCharacterRoll()
                        } label: {
                            if viewModel.loadingState == .loading {
                                Text("Loading")
                                    .frame(width: 64, height: 32)
                            } else {
                                HStack(alignment: .center, spacing: 4) {
                                    Text("Roll")
                                    Image(systemName: "dice")
                                }
                                .frame(width: 64, height: 32)
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .buttonBorderShape(.capsule)
                        .disabled(viewModel.rollCount <= 0 || viewModel.loadingState == .loading)
                        .padding()
                    }
                }
                .padding(.vertical, 16)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        ClaimedListView()
                    } label: {
                        Text("Claim List \(Image(systemName: "list.bullet"))")
                    }
                }
            }
            .onDisappear {
                let encodedData = try! JSONEncoder().encode(CharacterManager.shared.claimedList)
                UserDefaults.standard.set(encodedData, forKey: "claimedList")
            }
        }
    }
}

struct RollsListView_Previews: PreviewProvider {
    static var previews: some View {
        RollsListView()
    }
}
