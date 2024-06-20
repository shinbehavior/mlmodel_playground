//
//  ModelSelectionView.swift
//  mlmodel_workground
//
//  Created by Nxtech on 19/06/2024.
//

import SwiftUI

struct ModelSelectionView: View {
    @State private var selectedModelIndex = 0
    @State private var models = ["yolov8s", "ObjectDetector"]

    var body: some View {
        NavigationStack {
            VStack {
                Picker("Select Model", selection: $selectedModelIndex) {
                    ForEach(0..<models.count, id: \.self) { index in
                        Text(models[index]).tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                NavigationLink("Start Detection", destination: ObjectDetectionViewControllerRepresentable(selectedModel: models[selectedModelIndex]))
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
            }
            .navigationTitle("Select Model")
        }
    }
}
