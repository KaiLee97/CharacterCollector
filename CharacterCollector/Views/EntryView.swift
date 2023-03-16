//
//  EntryView.swift
//  CharacterCollector
//
//  Created by Haesong Lee on 10/6/22.
//

import Foundation
import SwiftUI

struct EntryView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.opacity(0.95).ignoresSafeArea()
                VStack(alignment: .center, spacing: 0) {
                    Spacer()
                    Text("Character Collector")
                        .foregroundColor(Color.white)
                        .padding(.bottom, 32)
                        .font(.system(size: 32, weight: .black))
                    
                    NavigationLink {
                        RollsListView()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        Text("Enter")
                            .foregroundColor(Color.white)
                            .font(.system(size: 16, weight: .medium))
                    }
                    Spacer()
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle()) 
        .navigationBarHidden(true)
        .navigationBarTitle("", displayMode: .inline)
    }
}
