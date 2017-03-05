//
//  QRDetector.swift
//  QRKit
//
//  Created by Yuji Taniguchi on 2017/01/20.
//  Copyright © 2017 natpenguin. All rights reserved.
//

import UIKit

public struct QRDetector {
    
    // MARK: - interface
    
    /// Create instance of `String` array.
    public var strings: [String]? {
        let options = [
            CIDetectorAccuracy : accuracy.rawValue
        ]
        guard let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: options) else { return nil }
        let strings = detector.features(in: image).flatMap { $0 as? CIQRCodeFeature }.flatMap { $0.messageString }
        return strings.count > 0 ? strings : nil
    }
    
    /// Specify reading accuracy.
    ///
    /// - Parameter accurary: Reading accuracy.
    /// - Returns: `QRDetector` instance
    public func accurary(_ accurary: Accuracy) -> QRDetector {
        var detector = self
        detector.accuracy = accurary
        return detector
    }
    
    /// Initialize by specifying `CIImage` instance.
    ///
    /// - Parameter image: Image data.
    internal init(image: CIImage) {
        self.image = image
    }
    
    // MARK: - private
    
    /// Image of QR code.
    private let image: CIImage
    
    /// Reading accuracy.
    private var accuracy: Accuracy = .high
    
}

// MARK: - define

extension QRDetector {
    
    // MARK: - enum
    
    /// Reading accuracy.
    ///
    /// - high: High precision.
    /// - low: Low precision.
    public enum Accuracy {
        case high
        case low
        
        var rawValue: String {
            switch self {
            case .high: return CIDetectorAccuracyHigh
            case .low: return CIDetectorAccuracyLow
            }
        }
    }
    
}
