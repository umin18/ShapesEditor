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
    
    private let dataService = ButtonDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addButtons()
    }
    
    func addButtons() {
        dataService.$buttons
            .sink { [weak self] buttons in
                self?.buttons = buttons
            }
            .store(in: &cancellables)
    }
    
    var circles: [ShapeItem] {
        shapes.filter { $0.name == .circle }
    }
    
    // Function to add a new shape
    func addShape(type: ShapeType) {
        shapes.append(ShapeItem(name: type))
    }
    
    func clearAllShapes() {
        shapes.removeAll()
    }
    
    func addCircle() {
        shapes.append(ShapeItem(name: .circle))
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
