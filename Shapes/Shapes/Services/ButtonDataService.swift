//
//  ButtonDataService.swift
//  Shapes
//
//  Created by Eric Cha on 5/28/25.
//

import SwiftUI
import Combine

//Button Data Service allows for dependency injection to use MockService
class ButtonDataService: ObservableObject {
    
    @Published var buttons: [DynamicButton] = []
    
    private var subscription: AnyCancellable?
    private let buttonUrl = "https://staticcontent.cricut.com/static/test/shapes_001.json"
    
    init() {
        fetchButtons()
    }
    
    func fetchButtons() {
        guard let url = URL(string: buttonUrl) else {
            return
        }
        subscription = NetworkingManager.download(url: url)
            .decode(type: ButtonsResponse.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion(completion:), receiveValue: { [weak self] buttons in
                self?.buttons = buttons.buttons
            })
    }
}
