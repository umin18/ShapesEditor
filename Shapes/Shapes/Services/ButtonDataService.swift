//
//  ButtonDataService.swift
//  Shapes
//
//  Created by Eric Cha on 5/28/25.
//

import SwiftUI
import Combine

class ButtonDataService {
    
    private let buttonUrl = "https://staticcontent.cricut.com/static/test/styled_shapes_001.json"
    
    func fetchButtons() -> AnyPublisher<[DynamicButton], Error> {
        guard let url = URL(string: buttonUrl) else {
            return Fail(error: DataServiceError.badURL).eraseToAnyPublisher()
        }
        
        return NetworkingManager.download(url: url)
            .decode(type: ButtonsResponse.self, decoder: JSONDecoder())
            .map { $0.buttons } // Extract the array of buttons from the response
            .mapError { error in
                if let decodingError = error as? DecodingError {
                    return DataServiceError.decodingError
                } else if let urlError = error as? URLError {
                    return DataServiceError.networkError(urlError)
                } else {
                    return DataServiceError.unknown
                }
            }
            .eraseToAnyPublisher()
    }
}
