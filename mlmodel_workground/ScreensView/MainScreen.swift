//
//  MainScreen.swift
//  mlmodel_workground
//
//  Created by Nxtech on 19/06/2024.
//

import SwiftUI

struct MainScreen: View {
    @State private var path = [String]()

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                NavigationLink("Object Detection", value: "ObjectDetection")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()

                NavigationLink("Semantic Segmentation", value: "SemanticSegmentation")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
            }
            .navigationTitle("Choose an Option")
            .navigationDestination(for: String.self) { value in
                switch value {
                case "ObjectDetection":
                    ObjectDetView()
                case "SemanticSegmentation":
                    SegmentationView()
                default:
                    Text("Unknown Destination")
                }
            }
        }
    }
}

//struct MainScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        MainScreen()
//    }
//}
