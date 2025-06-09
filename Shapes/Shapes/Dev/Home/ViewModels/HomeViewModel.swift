//
//  HomeViewModel.swift
//  Shapes
//
//  Created by Eric Cha on 5/28/25.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var buttons: [DynamicButton] = []
    @Published var shapes: [ShapeItem] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    private let dataService: ButtonDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(dataService: ButtonDataService = ButtonDataService()) {
        self.dataService = dataService
    }
    
    func fetchButtons() {
        self.errorMessage = nil
        self.isLoading = true
        dataService.fetchButtons()
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .finished:
                    self?.errorMessage = nil
                    break
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] buttons in
                self?.buttons = buttons
            })
            .store(in: &cancellables)
    }
    
    var circles: [ShapeItem] {
        shapes.filter { $0.name == .circle }
    }
    
    // Function to add a new shape
    func addShape(type: DrawPath) {
        shapes.append(ShapeItem(name: type.shape, style: type.style))
    }
    
    func clearAllShapes() {
        shapes.removeAll()
    }
    
    func addCircle() {
        shapes.append(ShapeItem(name: .circle, style: .filled))
    }
    
    func removeLastCircle() {
        // Find index of the last circle
        if let lastCircleIndex = shapes.lastIndex(where: { $0.name == .circle }) {
            shapes.remove(at: lastCircleIndex)
        }
    }
    
    func deleteAllCircles() {
        shapes.removeAll(where: { $0.name == .circle })
    }
}
