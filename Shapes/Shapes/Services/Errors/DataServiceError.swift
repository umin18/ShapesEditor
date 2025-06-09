//
//  DataServiceError.swift
//  Shapes
//
//  Created by Eric Cha on 6/7/25.
//

import SwiftUI

enum DataServiceError: Error, LocalizedError {
    case badURL
    case decodingError
    case networkError(Error)
    case unknown

    var errorDescription: String? {
        switch self {
        case .badURL:
            return "The URL for buttons was invalid."
        case .decodingError:
            return "Failed to decode button data from the server."
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .unknown:
            return "An unknown error occurred."
        }
    }
}
