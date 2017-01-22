//
//  QRCreator.swift
//  QRKit
//
//  Created by Yuji Taniguchi on 2017/01/20.
//  Copyright © 2017 natpenguin. All rights reserved.
//

import UIKit

public struct QRCreator {
    
    // MARK: - Enum define
    
    /// Correction level when generating QR code.
    ///
    /// - h: 30%
    /// - q: 25%
    /// - m: 15%
    /// - l: 07%
    public enum Correction: String {
        case h = "H"
        case q = "Q"
        case m = "M"
        case l = "L"
    }
    
    /// Rendering environment.
    ///
    /// - software: Software rendering
    /// - hardware: Hardware rendering
    public enum Renderer {
        case software
        case hardware
    }
    
    // MARK: - Interface
    
    /// Create `UIImage` instance.
    public var image: UIImage? {
        let parameters: [String : Any] = [
            "inputMessage" : data,
            "inputCorrectionLevel" : correction.rawValue
        ]
        guard let generatorFilter = CIFilter(name: "CIQRCodeGenerator", withInputParameters: parameters) else { return nil }
        generatorFilter.setDefaults()
        guard var outputImage = generatorFilter.outputImage else { return nil }
        
        if let size = self.size {
            let scale = CGPoint(
                x: size.width / outputImage.extent.width,
                y: size.height / outputImage.extent.height
            )
            let scaleTransform = CGAffineTransform(scaleX: scale.x, y: scale.y)
            outputImage = outputImage.applying(scaleTransform).cropping(to: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        }
        
        let context = CIContext(options: [kCIContextUseSoftwareRenderer : renderer == .software])
        guard let image = context.createCGImage(outputImage, from: outputImage.extent) else { return nil }
        return UIImage(cgImage: image, scale: 1.0, orientation: .up)
    }
    
    /// Specify the correction level.
    ///
    /// - Parameter correction: Correction level.
    /// - Returns: `QRCreator` instance.
    public func correction(_ correction: Correction) -> QRCreator {
        var creator = self
        creator.correction = correction
        return creator
    }
    
    /// Specify image size.
    ///
    /// - Parameter size: Image size.
    /// - Returns: `QRCreator` instance.
    public func size(_ size: CGSize) -> QRCreator {
        var creator = self
        creator.size = size
        return creator
    }
    
    /// Specify the rendering environment.
    ///
    /// - Parameter renderer: Rendering environment
    /// - Returns: `QRCreator` instance
    public func renderer(_ renderer: Renderer) -> QRCreator {
        var creator = self
        creator.renderer = renderer
        return creator
    }
    
    /// Initialize by specifying binary data.
    ///
    /// - Parameter data: Binary data.
    internal init(data: Data) {
        self.data = data
    }
    
    // MARK: - Private
    
    /// Data of QR code.
    private let data: Data
    
    /// Correction level.
    private var correction: Correction = .m
    /// Image size.
    private var size: CGSize?
    /// Rendering environment.
    private var renderer: Renderer = .software
    
}
