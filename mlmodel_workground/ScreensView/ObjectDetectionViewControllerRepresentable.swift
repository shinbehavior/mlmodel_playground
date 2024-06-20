//
//  ObjectDetectionViewControllerRepresentable.swift
//  mlmodel_workground
//
//  Created by Nxtech on 20/06/2024.
//

import SwiftUI
import UIKit

struct ObjectDetectionViewControllerRepresentable: UIViewControllerRepresentable {
    var selectedModel: String

    func makeUIViewController(context: Context) -> ViewController {
        let viewController = ViewController()
        viewController.selectedModel = selectedModel
        return viewController
    }

    func updateUIViewController(_ uiViewController: ViewController, context: Context) {}
}
