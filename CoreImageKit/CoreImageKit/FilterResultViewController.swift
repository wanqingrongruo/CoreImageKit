//
//  FilterResultViewController.swift
//  Created on 2021/1/20
//  Description <#文件描述#>

import UIKit
import CoreImage

class FilterResultViewController: UIViewController {
    @IBOutlet weak var originalImageView: UIImageView!
    
    @IBOutlet weak var effectImageView: UIImageView!
    
    private let item: CICase
    required init(item: CICase) {
        self.item = item
        super.init(nibName: "FilterResultViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var filter: CIFilter?
    var context: CIContext = CIContext(options: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = item.title + "效果"
        
        let resultImage = outputImage(filterName: item.filterCategoty.filterName)
        DispatchQueue.main.async {
            self.effectImageView.image = resultImage
        }
    }
}

extension FilterResultViewController {
    func outputImage(filterName: String) -> UIImage? {
        guard let image = originalImageView.image else {
            return nil
        }
        guard let ciImage = CIImage(image: image) else {
            return nil
        }
        filter = CIFilter(name: filterName, parameters: [kCIInputImageKey: ciImage])
        filter?.setValue(20.0, forKey: "inputRadius")
        guard let outputImage = filter?.outputImage else {
            return nil
        }
                
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else {
            return nil
        }
        let oImage = UIImage(cgImage: cgImage)
        return oImage
    }
}
