//
//  QRCreateContext.swift
//  QRKit
//
//  Created by Yuji Taniguchi on 2017/05/20.
//  Copyright © 2017 natpenguin. All rights reserved.
//

import UIKit

public struct QRCreateContext {
    
    // MARK: - interface
    
    /// Specify image size.
    ///
    /// - Parameter size: Image size.
    /// - Returns: `QRCreator` instance.
    public func size(_ size: CGSize) -> QRCreateContext {
        var context = self
        context.size = size
        return context
    }
    
    /// Specify the rendering environment.
    ///
    /// - Parameter renderer: Rendering environment
    /// - Returns: `QRCreator` instance
    public func renderer(_ renderer: QRRenderer) -> QRCreateContext {
        var context = self
        context.renderer = renderer
        return context
    }
    
    /// Specify the correction level.
    ///
    /// - Parameter correction: Correction level.
    /// - Returns: `QRCreator` instance.
    public func correction(_ correction: QRCorrection) -> QRCreateContext {
        var context = self
        context.correction = correction
        return context
    }
    
    public func image() -> UIImage? {
        let parameters: [String : Any] = [
            "inputMessage" : raw,
            "inputCorrectionLevel" : correction.rawValue
        ]
        guard let filter = CIFilter(name: "CIQRCodeGenerator", withInputParameters: parameters) else { return nil }
        filter.setDefaults()
        
        guard let generatedImage = filter.outputImage else { return nil }
        
        let scale = CGPoint(
            x: size.width / generatedImage.extent.width,
            y: size.height / generatedImage.extent.height
        )
        let scaleTransform = CGAffineTransform(scaleX: scale.x, y: scale.y)
        let appliedImage = generatedImage.applying(scaleTransform).cropping(to: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        let context = CIContext(options: [kCIContextUseSoftwareRenderer : renderer == .software])
        guard let image = context.createCGImage(appliedImage, from: appliedImage.extent) else { return nil }
        return UIImage(cgImage: image, scale: 1.0, orientation: .up)
    }
    
    // MARK: - lifecycle
    
    public init(raw: Data) {
        self.raw = raw
    }
    
    // MARK: - private
    
    private let raw: Data
    
    private var size: CGSize = .init(width: 256, height: 256)
    private var renderer: QRRenderer = .software
    private var correction: QRCorrection = .h
}


