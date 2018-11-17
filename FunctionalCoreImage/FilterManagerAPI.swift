//
//  FilterManagerAPI.swift
//  FunctionalCoreImage
//
//  Created by James Rochabrun on 11/14/18.
//  Copyright © 2018 James Rochabrun. All rights reserved.
//

import UIKit

struct FilterManagerAPI {
    
    func blur(radius: Double) -> Filter {
        return { image in
            return FilterType.gaussianBlur(image, radius).filter?.outputImage
        }
    }
    
    func colorGenerator(color: UIColor) -> Filter {
        return { _ in
            let inputColor = CIColor(color: color)
            return FilterType.colorGenerator(inputColor).filter?.outputImage
        }
    }
    
    func colorOverlay(color: UIColor) -> Filter {
        return { image in
            guard let overlay =  self.colorGenerator(color: color)(image),
                let compositeIamge = self.compositeSourceOver(overlay: overlay)(image) else {
                    return nil
            }
            return compositeIamge
        }
    }
    
    func compositeSourceOver(overlay: CIImage) -> Filter {
        return { image in
            let filter = FilterType.compositeSourceOver(overlay, image: image).filter
            let cropRect = image.extent
            return filter?.outputImage?.cropped(to: cropRect)
        }
    }
    
    // function composition
    func composeFilters(filter1: @escaping Filter, filter2: @escaping Filter) -> Filter {
        return { img in
            guard let firstFilteredImage = filter1(img) else { return nil }
            return filter2(firstFilteredImage)
        }
    }    
}
