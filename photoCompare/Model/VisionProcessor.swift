//
//  VisionProcessor.swift
//  photoCompare
//
//  Created by eric yu on 4/14/18.
//  Copyright © 2018 eric yu. All rights reserved.
//

import Foundation
import Vision
import UIKit

class VisionProcessor {
    
    func numberFaceDetected(image: UIImage) -> Int{

        var numOfFaces = 0
        let request = VNDetectFaceRectanglesRequest { (req, err) in
            if let err = err {
                print("err \(err)")
                return
            }
            //element of req contain boundingBox
            
            numOfFaces = req.results?.count ?? 0
        }
        
        guard let cgImage = image.cgImage else { return numOfFaces }
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        do {
            try handler.perform([request])
        } catch let reqErr {
            print("Failed to perform request:", reqErr)
        }
        
        return numOfFaces
    }
}
