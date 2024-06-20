//
//  FeatureExtractor.swift
//  mlmodel_workground
//
//  Created by Nxtech on 20/06/2024.
//

import UIKit
import CoreML
import Vision

class FeatureExtractor {
    var model: VNCoreMLModel?

    init(modelName: String) {
        loadModel(named: modelName)
    }
    
    func loadModel(named modelName: String) {
        let config = MLModelConfiguration()
        do {
            if let modelURL = Bundle.main.url(forResource: "YOLOv8sFeatureExtractor", withExtension: "mlmodelc") {
                let mlModel = try MLModel(contentsOf: modelURL, configuration: config)
                self.model = try VNCoreMLModel(for: mlModel)
                print("Model \(modelName) loaded successfully")
            } else {
                print("Model \(modelName) not found")
            }
        } catch {
            print("Could not load model \(modelName): \(error)")
        }
    }

    func extractFeatures(from image: UIImage, completion: @escaping (Result<[Float], Error>) -> Void) {
        guard let model = model else {
            completion(.failure(NSError(domain: "Model not loaded", code: 0, userInfo: nil)))
            return
        }

        guard let cgImage = image.cgImage else {
            completion(.failure(NSError(domain: "Invalid image", code: 0, userInfo: nil)))
            return
        }

        let request = VNCoreMLRequest(model: model) { (request, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let results = request.results as? [VNCoreMLFeatureValueObservation] else {
                print("Invalid results: \(String(describing: request.results))")
                completion(.failure(NSError(domain: "Invalid results", code: 0, userInfo: nil)))
                return
            }

            if let featureObservation = results.first,
               let featureValues = featureObservation.featureValue.multiArrayValue {
                let features = featureValues.dataPointer.bindMemory(to: Float.self, capacity: featureValues.count)
                let featureArray = Array(UnsafeBufferPointer(start: features, count: featureValues.count))
                print("Feature extraction completed. Number of features: \(featureArray.count)")
                completion(.success(featureArray))
            } else {
                completion(.failure(NSError(domain: "No valid features found", code: 0, userInfo: nil)))
            }
        }

        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        do {
            try handler.perform([request])
            print("VNImageRequestHandler perform completed")
        } catch {
            completion(.failure(error))
        }
    }
}
