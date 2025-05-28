//
//  HomeView.swift
//  Shapes
//
//  Created by Eric Cha on 5/28/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var showEditCircles = false
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 20) {
                        ForEach(viewModel.shapes) { shapeItem in
                            switch shapeItem.name {
                            case .circle:
                                Circle()
                                    .fill(Color.teal)
                                    .frame(width: 80, height: 80)
                            case .square:
                                Rectangle()
                                    .fill(Color.teal)
                                    .frame(width: 80, height: 80)
                            case .triangle:
                                Triangle()
                                    .fill(Color.teal)
                                    .frame(width: 80, height: 80)
                            }
                        }
                    }
                    .padding()
                }
                Spacer()
                HStack {
                    ForEach(viewModel.buttons) { button in
                        Button(button.name) {
                            viewModel.addShape(type: button.drawPath
                            )
                        }
                    }
                    .padding(.horizontal, 25)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Clear All") {
                            print("Help tapped!")
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
            }
        }
    }
}

#Preview {
    HomeView()
}
