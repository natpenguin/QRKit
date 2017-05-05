//
//  UIImageView+QR.swift
//  QRKit
//
//  Created by Yuji Taniguchi on 2017/01/21.
//  Copyright © 2017 natpenguin. All rights reserved.
//

import UIKit

extension UIImageView {
    
    /// Reads the specified `QRCreator` and stores it in its own `image` property.
    ///
    /// - Parameters:
    ///   - qr: The `QRCreator` instance you want to load.
    ///   - handler: Completion handler. (Returns true if it succeeds, false if it fails.)
    public func set(of code: String, completion handler: ((Bool) -> Void)?) {
        DispatchQueue.global(qos: .default).async {
            if let image = code.qrcreator?.image {
                DispatchQueue.main.async { [weak self] in
                    self?.image = image
                    handler?(true)
                }
            } else {
                DispatchQueue.main.async {
                    handler?(false)
                }
            }
        }
    }
    
}
