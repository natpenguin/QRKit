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

    /// Specify the foreground color.
    ///
    /// - Parameter color: foreground color.
    /// - Returns: `QRCreator` instance.
    public func foregroundColor(_ color: UIColor) -> QRCreateContext {
        var context = self
        context.foregroundColor = color
        return context
    }

    /// Specify the background color.
    ///
    /// - Parameter color: background color.
    /// - Returns: `QRCreator` instance.
    public func backgroundColor(_ color: UIColor) -> QRCreateContext {
        var context = self
        context.backgroundColor = color
        return context
    }

    public func image() -> UIImage? {
        // generate qr code
        let qrParameters: [String : Any] = [
            "inputMessage" : raw,
            "inputCorrectionLevel" : correction.rawValue
        ]
        guard let qrFilter = CIFilter(name: "CIQRCodeGenerator", withInputParameters: qrParameters) else { return nil }
        qrFilter.setDefaults()
        guard let qrImage = qrFilter.outputImage else { return nil }

        // apply colors
        let colorParameters = [
            "inputImage": qrImage,
            "inputColor0": CIColor(color: foregroundColor),
            "inputColor1": CIColor(color: backgroundColor)
        ]
        guard let colorFilter = CIFilter(name: "CIFalseColor", withInputParameters: colorParameters) else { return nil }
        guard let generatedImage = colorFilter.value(forKey: "outputImage") as? CIImage else { return nil }

        // scaling
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
    private var foregroundColor: UIColor = .black
    private var backgroundColor: UIColor = .white
}


