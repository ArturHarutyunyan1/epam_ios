//
//  Config.swift
//  DynamicImageGallery
//
//  Created by Artur Harutyunyan on 10.07.25.
//

import Foundation

struct Config: Codable {
    let imageDisplayCount: Int
    let itemsPerRow: Int
    let imageNames: [String]
    
    func isValid() -> String? {
        if imageNames.isEmpty {
            return "No image names provided in configuration."
        }
        if imageDisplayCount <= 0 {
            return "imageDisplayCount must be greater than 0."
        }
        if imageDisplayCount > imageNames.count {
            return "imageDisplayCount exceeds number of available images."
        }
        if itemsPerRow <= 0 {
            return "itemsPerRow must be greater than 0."
        }
        return nil
    }
}
