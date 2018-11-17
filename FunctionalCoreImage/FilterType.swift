//
//  FilterType.swift
//  FunctionalCoreImage
//
//  Created by James Rochabrun on 11/14/18.
//  Copyright © 2018 James Rochabrun. All rights reserved.
//

import UIKit

enum FilterType {
    
    case gaussianBlur(_ image: CIImage, _ radius: Double)
    case colorGenerator(_ color: CIColor)
    case compositeSourceOver(_ overlay: CIImage, image: CIImage)
    
    var filter: CIFilter? {
        switch self {
        case .gaussianBlur(let image, let radius):
            let parameters:  [String : Any] = [
                kCIInputRadiusKey: radius,
                kCIInputImageKey: image
            ]
            return CIFilter(name: "CIGaussianBlur", parameters: parameters)
        case .colorGenerator(let color):
            let parameters: [String: Any] = [
                kCIInputColorKey: color
            ]
            return CIFilter(name: "CIConstantColorGenerator", parameters: parameters)
        case .compositeSourceOver(let overlay, let image):
            let parameters: [String: Any] = [
                kCIInputBackgroundImageKey: image,
                kCIInputImageKey: overlay
            ]
            return CIFilter(name: "CISourceOverCompositing", parameters: parameters)
        }
    }
}
