//
//  Filter.swift
//  FunctionalCoreImage
//
//  Created by James Rochabrun on 11/14/18.
//  Copyright © 2018 James Rochabrun. All rights reserved.
//

import UIKit

typealias Filter = (CIImage) -> CIImage?

infix operator >>>
precedencegroup ExponentiationPrecedence {
    associativity: left
}

func >>>(filter1: @escaping Filter, filter2: @escaping Filter) -> Filter {
    return { img in
        guard let firstFilteredImage = filter1(img) else { return nil }
        return filter2(firstFilteredImage)
    }
}

