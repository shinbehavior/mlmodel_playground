//
//  ViewController.swift
//  mlmodel_workground
//
//  Created by Nxtech on 14/06/2024.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var captureSession = AVCaptureSession()
    var previewView = UIImageView()
    var objectDetectionHandler: ObjectDetectionHandler!
    var selectedModel: String = "YOLOv8sFeatureExtractor"  // Ensure this matches the name of your new model
    
    var featureExtractor: FeatureExtractor!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(previewView)
        objectDetectionHandler = ObjectDetectionHandler(captureSession: captureSession, previewView: previewView, selectedModel: selectedModel)
        
        featureExtractor = FeatureExtractor(modelName: selectedModel)

        guard let image = UIImage(named: "example_image") else {
            print("Error: Could not load example_image")
            return
        }
        
        print("Starting feature extraction...")
        
        featureExtractor.extractFeatures(from: image) { result in
            switch result {
            case .success(let features):
                self.saveFeaturesToFile(features)
                
            case .failure(let error):
                print("Error extracting features: \(error.localizedDescription)")
            }
        }
    }
    
    func saveFeaturesToFile(_ features: [Float]) {
        let fileName = "features.txt"
        let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)
        
        let featuresString = features.map { String($0) }.joined(separator: "\n")
        do {
            try featuresString.write(to: fileURL, atomically: true, encoding: .utf8)
            print("Features saved to \(fileURL.path)")
        } catch {
            print("Error saving features: \(error.localizedDescription)")
        }
    }

    func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}



