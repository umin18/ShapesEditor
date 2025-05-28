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
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 20) {
                        ForEach(viewModel.circles) { shapeItem in
                                Circle()
                                    .fill(Color.teal)
                                    .frame(width: 80, height: 80)
                        }
                    }
                }
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
