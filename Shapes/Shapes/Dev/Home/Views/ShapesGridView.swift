//
//  ShapesGridView.swift
//  Shapes
//
//  Created by Eric Cha on 6/7/25.
//

import SwiftUI

struct ShapeGridView: View {
    let data: [ShapeItem]

    init(_ data: [ShapeItem]) {
        self.data = data
    }

    private func createShape(name: ShapeType) -> AnyShape {
        switch name {
        case .circle:
            return AnyShape(Circle())
        case .square:
            return AnyShape(Rectangle())
        case .triangle:
            return AnyShape(Triangle())
        }
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 20) {
                ForEach(data) { shapeItem in
                    createShape(name: shapeItem.name)
                        .fill(shapeItem.style == .filled ? Color.teal : Color.white)
                        .overlay(createShape(name: shapeItem.name).stroke(Color.teal, style: shapeItem.style == .filled || shapeItem.style == .stroked ? StrokeStyle(lineWidth: 1) : StrokeStyle(lineWidth: 1, dash: [4, 2])))
                        .frame(width: 80, height: 80)
                }
            }
            .padding()
        }
    }
}
