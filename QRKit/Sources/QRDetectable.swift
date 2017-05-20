//
//  QRDetectable.swift
//  QRKit
//
//  Created by Yuji Taniguchi on 2017/05/20.
//  Copyright © 2017 natpenguin. All rights reserved.
//

import UIKit

public protocol QRDetectable {
    var image: UIImage? { get }
}

extension UIImage: QRDetectable {
    
    public var image: UIImage? {
        return self
    }
    
}

public struct QRDetectContext {
    
    // MARK: - interface
    
    /// Create instance of `String` array.
    public var strings: [String]? {
        let options = [
            CIDetectorAccuracy : accuracy.rawValue
        ]
        guard let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: options) else { return nil }
        guard let image = CIImage(image: self.raw) else { return nil }
        let strings = detector.features(in: image).flatMap { $0 as? CIQRCodeFeature }.flatMap { $0.messageString }
        return strings.count > 0 ? strings : nil
    }
    
    /// Specify reading accuracy.
    ///
    /// - Parameter accurary: Reading accuracy.
    /// - Returns: `QRDetector` instance
    public func accurary(_ accurary: QRAccuracy) -> QRDetectContext {
        var detector = self
        detector.accuracy = accurary
        return detector
    }
    
    /// Initialize by specifying `CIImage` instance.
    ///
    /// - Parameter image: Image data.
    internal init(raw: UIImage) {
        self.raw = raw
    }
    
    // MARK: - private
    
    /// Image of QR code.
    private let raw: UIImage
    
    /// Reading accuracy.
    private var accuracy: QRAccuracy = .high
    
}
