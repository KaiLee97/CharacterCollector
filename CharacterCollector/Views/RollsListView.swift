//
//  RollsListView.swift
//  CharacterCollector
//
//  Created by Haesong Lee on 10/5/22.
//

import Foundation
import SwiftUI

struct RollsListView: View {
    @ObservedObject var viewModel: RollsListViewModel = RollsListViewModel()
    let network = Network()
    var body: some View {
        ZStack {
            Color.black.opacity(0.95).ignoresSafeArea()
            VStack(alignment: .center, spacing: 0) {
                Spacer()
                if viewModel.jikanModelList.count != 0 {
                    ScrollViewReader { proxy in
                        ScrollView(.vertical) {
                            LazyVStack {
                                ForEach(viewModel.jikanModelList, id: \.self) { model in
                                    CharacterTile(jikanModel: model, viewModel: viewModel)
                                            .id(model)
                                            .padding(.vertical, 8)
                                            .padding(.horizontal, 48)
                                }
                            }
                        }
                        .onChange(of: viewModel.jikanModelList.count, perform: { value in
                            proxy.scrollTo(viewModel.jikanModelList[0])
                        })
                    }
                } else {
                    Text("You have " + "\(viewModel.rollCount)" + " rolls left")
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
                        Task {
                            await viewModel.completeCharacterRoll()
                        }
                    } label: {
                        if viewModel.state == .loading {
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
                    .disabled(viewModel.rollCount <= 0 || viewModel.state == .loading)
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
