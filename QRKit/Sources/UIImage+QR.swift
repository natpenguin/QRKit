//
//  UIImage+QR.swift
//  QRKit
//
//  Created by Yuji Taniguchi on 2017/01/20.
//  Copyright © 2017 natpenguin. All rights reserved.
//

import UIKit

extension UIImage {
    
    /// Creates and returns an instance of `QRDetector` based on itself.
    public var qrdetector: QRDetector? {
        guard let image = CIImage(image: self) else { return nil }
        return QRDetector(image: image)
    }
    
}
