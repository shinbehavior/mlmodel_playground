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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(previewView)
        objectDetectionHandler = ObjectDetectionHandler(captureSession: captureSession, previewView: previewView)
    }
}
