//
//  ClaimedListView.swift
//  CharacterCollector
//
//  Created by Haesong Lee on 1/29/23.
//

import Foundation
import SwiftUI

struct ClaimedListView: View {
    @State var tappedCharacter: Bool = false
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.opacity(0.95).ignoresSafeArea()
                VStack {
                    Text("Claimed Characters")
                        .font(.title)
                        .bold()
                        .foregroundColor(Color.white)
                        .padding(.vertical, 16)
                    ScrollView(.vertical) {
                        LazyVStack(alignment: .center, spacing: 0) {
                            ForEach(CharacterManager.shared.claimedList) { char in
                                ClaimedCharacterTile(character: char)
                            }
                        }
                        .padding(.horizontal, 12)
                    }
                    Spacer()
                }
            }
        }
    }
}
