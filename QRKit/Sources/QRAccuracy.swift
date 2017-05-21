//
//  QRAccuracy.swift
//  QRKit
//
//  Created by Yuji Taniguchi on 2017/05/20.
//  Copyright © 2017 natpenguin. All rights reserved.
//

import UIKit

/// Reading accuracy.
///
/// - high: High precision.
/// - low: Low precision.
public enum QRAccuracy {
    case high
    case low
    
    var rawValue: String {
        switch self {
        case .high: return CIDetectorAccuracyHigh
        case .low: return CIDetectorAccuracyLow
        }
    }
}
