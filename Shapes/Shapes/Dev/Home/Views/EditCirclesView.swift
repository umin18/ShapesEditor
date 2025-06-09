//
//  EditCirclesView.swift
//  Shapes
//
//  Created by Eric Cha on 5/28/25.
//

import SwiftUI

struct EditCirclesView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                ShapeGridView(viewModel.circles)
                Spacer()
                HStack {
                    Button("Delete All") {
                        viewModel.deleteAllCircles()
                    }
                    Spacer()
                    Button("Add") {
                        viewModel.addCircle()
                    }
                    Spacer()
                    Button("Remove") {
                        viewModel.removeLastCircle()
                    }
                }
                .padding(.horizontal, 25)
            }
        }
    }
}
