//
//  HomeView.swift
//  Shapes
//
//  Created by Eric Cha on 5/28/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var showAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                ShapeGridView(viewModel.shapes)
                
                Spacer()
                
                if viewModel.isLoading {
                    ProgressView("Loading buttons...")
                }
                HStack {
                    ForEach(viewModel.buttons) { button in
                        Button(button.name) {
                            viewModel.addShape(type: button.drawPath)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Clear All") {
                        viewModel.clearAllShapes()
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: EditCirclesView(viewModel: viewModel)) {
                        Text("Edit Circles")
                    }
                }
            }
            .task {
                viewModel.fetchButtons()
            }
            .onChange(of: viewModel.errorMessage) { oldValue, newValue in
                showAlert = newValue != nil
            }
            .alert("Button Retrieval Error", isPresented: $showAlert) {
                Button("Retry") {
                    viewModel.fetchButtons()
                }
            } message: {
                Text(viewModel.errorMessage ?? "An unknown error occurred.")
            }
        }
    }
}

#Preview {
    HomeView()
}
