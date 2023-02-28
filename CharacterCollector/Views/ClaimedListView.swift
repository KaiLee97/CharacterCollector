//
//  ClaimedListView.swift
//  CharacterCollector
//
//  Created by Haesong Lee on 1/29/23.
//

import Foundation
import SwiftUI

struct ClaimedListView: View {
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
                    LazyVStack(alignment: .center, spacing: 0) {
                        ForEach(CharacterManager.shared.claimedList) { char in
                            HStack(alignment: .center, spacing: 12) {
                                Image(systemName: "heart.fill")
                                    .foregroundColor(.red)
                                    .font(.system(size: 12))
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Name: ").bold().font(.title3) + Text(char.name).font(.title2)
                                    Text("Series: ").bold().font(.body) + Text(char.mediaTitle).font(.body)
                                }
                                .foregroundColor(Color.white)
                                Spacer()
                            }
                        }
                    }
                    .padding(.horizontal, 12)
                    Spacer()
                }
            }
        }
    }
}
