//
//  NetworkingManager.swift
//  Shapes
//
//  Created by Eric Cha on 5/28/25.
//

import Foundation
import Combine

// Reusable NetworkingManager
class NetworkingManager {
    
    static func download(url: URL) -> AnyPublisher<Data, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap { output in
                guard let httpResponse = output.response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .eraseToAnyPublisher()

    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
