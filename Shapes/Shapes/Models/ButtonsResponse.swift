//
//  Buttons.swift
//  Shapes
//
//  Created by Eric Cha on 5/28/25.
//

import Foundation

struct ButtonsResponse: Codable {
    var buttons: [DynamicButton]
}

// Struct to decode the dynamic button data from the API
struct DynamicButton: Codable, Identifiable {
    let id = UUID()
    var name: String
    var drawPath: DrawPath
    
    enum CodingKeys: String, CodingKey {
        case name
        case drawPath = "draw_path"
    }
}

struct DrawPath: Codable {
    var shape: ShapeType
    var style: ShapeStyle
}

// Enum to represent different types of shapes
enum ShapeType: String, Codable , Hashable {
    case circle
    case square
    case triangle
}

enum ShapeStyle: String, Codable, Hashable {    
    case filled
    case dotted
    case stroked
}
