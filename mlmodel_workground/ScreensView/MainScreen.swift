//
//  MainScreen.swift
//  mlmodel_workground
//
//  Created by Nxtech on 19/06/2024.
//

import SwiftUI

struct MainScreen: View {
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink("Object Detection", destination: ModelSelectionView())
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()

                NavigationLink("Semantic Segmentation", destination: SegmentationView())
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
            }
            .navigationTitle("Choose an Option")
        }
    }
}

//struct MainScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        MainScreen()
//    }
//}
