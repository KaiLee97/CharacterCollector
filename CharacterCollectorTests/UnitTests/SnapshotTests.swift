//
//  SnapshotTests.swift
//  CharacterCollector
//
//  Created by Haesong Lee on 2/1/23.
//

import SnapshotTesting
import XCTest
@testable import CharacterCollector

class CharacterCollectorSnapshotTests: XCTestCase {
    
    override func setUp() {
//        isRecording = true
    }
    
    func testRollsListView() {
        let viewModel = RollsListViewModel()
        let rollsListView = RollsListView(viewModel: viewModel)
        assertSnapshot(matching: rollsListView, as: .image(layout: .device(config: .iPhone12)))
        
        viewModel.loadingState = .loading
        assertSnapshot(matching: rollsListView, as: .image(layout: .device(config: .iPhone12)))
    }
    
    func testClaimedListView() {
        let view = ClaimedListView()
        assertSnapshot(matching: view, as: .image(layout: .device(config: .iPhone12)))
    }
}
