//
//  MockButtonDataService.swift
//  Shapes
//
//  Created by Eric Cha on 6/9/25.
//

import SwiftUI
import XCTest
import Combine

@testable import Shapes

class MockButtonDataService: ButtonDataService {
    let mockDynamicButton = DynamicButton(
        name: "Mock",
        drawPath: .square
    )
    var passTest: Bool = true
    
    override func fetchButtons() -> AnyPublisher<[DynamicButton], any Error> {
        if passTest {
            return Just([mockDynamicButton])
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: DataServiceError.badURL)
                .eraseToAnyPublisher()
        }
    }
}


