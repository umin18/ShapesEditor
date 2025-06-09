//
//  HomeViewModelTests.swift
//  Shapes
//
//  Created by Eric Cha on 6/9/25.
//

import SwiftUI
import XCTest

@testable import Shapes

final class HomeViewModelTests: XCTestCase {
    var mockButtonDataService: MockButtonDataService!
    var viewModel: HomeViewModel!
    
    override func setUp() async throws {
        mockButtonDataService = MockButtonDataService()
        viewModel = HomeViewModel(dataService: mockButtonDataService)
    }
    
    override func tearDown() {
        viewModel = nil
    }
    
    func testFetchButtonsSuccess () throws {
        viewModel.fetchButtons()
        XCTAssertNotNil(viewModel.buttons)
    }
    
    func testFetchButtonsFailure () throws {
        mockButtonDataService.passTest = false
        viewModel.fetchButtons()
        XCTAssertNotNil(viewModel.errorMessage)
    }
}
