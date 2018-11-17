//
//  ViewController.swift
//  FunctionalCoreImage
//
//  Created by James Rochabrun on 11/13/18.
//  Copyright © 2018 James Rochabrun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var filterAPI: FilterManagerAPI = FilterManagerAPI()
    @IBOutlet weak var imageView: UIImageView!
    let blurRadius = 3.0
    let overLayColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 0.1143877414)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func applyChanges(_ sender: UIButton) {
        guard let image = imageView.image else { return }
      //  self.applyTo(image)
      //  self.applyUsingComposition(image)
       self.applyUsingInfixOperation(image)
    }
    
    // composing filters
    func applyTo(_ image: UIImage) {
        
        guard let inputImage = CIImage(image: image) else { return }
        if let blurredImage = filterAPI.blur(radius: blurRadius)(inputImage), let overLaidImage = filterAPI.colorOverlay(color: overLayColor)(blurredImage) {
            //updateImageViewWith(result: overLaidImage)
        }
        // or
        guard let result = filterAPI.colorOverlay(color: overLayColor)(filterAPI.blur(radius: blurRadius)(inputImage)!) else { return }
        updateImageViewWith(result: result)
    }
    
    func applyUsingComposition(_ image: UIImage) {
        
        guard let inputImage = CIImage(image: image) else { return }
        let filteredImage = filterAPI.composeFilters(filter1: filterAPI.blur(radius: blurRadius), filter2: filterAPI.colorOverlay(color: overLayColor))(inputImage)
        guard let outputImage = filteredImage else { return }
        updateImageViewWith(result: outputImage)
    }
    
    //infix operator
    func applyUsingInfixOperation(_ image: UIImage) {
        
        guard let inputImage = CIImage(image: image) else { return }
        let filter = filterAPI.blur(radius: blurRadius) >>> filterAPI.colorOverlay(color: overLayColor)
        guard let outputImage = filter(inputImage) else { return }
        updateImageViewWith(result: outputImage)
    }
    
    private func updateImageViewWith(result: CIImage) {
        imageView.image = nil
        imageView.image = UIImage(ciImage: result)
    }
}


