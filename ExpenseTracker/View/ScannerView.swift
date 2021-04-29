//
//  ScannerView.swift
//  ExpenseTracker
//
//  Created by William Santoso on 14/02/21.
//

import SwiftUI
import VisionKit
import Vision

struct ScannerView: UIViewControllerRepresentable {
    private let completionHandler: (String?) -> Void
     
    init(completion: @escaping (String?) -> Void) {
        self.completionHandler = completion
    }
    
    
    func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
        let documentCameraViewController = VNDocumentCameraViewController()
//        documentCameraViewController.delegate = self
        
        return documentCameraViewController
    }
    
    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(completion: completionHandler)
    }
    
    
    final class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        private let completionHandler: (String?) -> Void
        var transcript = ""
         
        init(completion: @escaping (String?) -> Void) {
            self.completionHandler = completion
        }
        
        func addRecognizedText(recognizedText: [VNRecognizedTextObservation]) {
            // Create a full transcript to run analysis on.
            let maximumCandidates = 1
            for observation in recognizedText {
                guard let candidate = observation.topCandidates(maximumCandidates).first else { continue }
                transcript += candidate.string
                transcript += "\n"
            }
            completionHandler(transcript)
        }
         
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            print("Document camera view controller did finish with ", scan)
//            let recognizer = TextRecognizer(cameraScan: scan)
//            recognizer.recognizeText(withCompletionHandler: completionHandler)
        }
         
        func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
            completionHandler(nil)
        }
         
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
            print("Document camera view controller did finish with error ", error)
            completionHandler(nil)
        }
    }
}
