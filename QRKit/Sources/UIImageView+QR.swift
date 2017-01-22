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
    public func loading(of qr: QRCreator, completion handler: ((Bool) -> Void)?) {
        DispatchQueue.global(qos: .default).async {
            guard let qrImage = qr.image else {
                DispatchQueue.main.async {
                    handler?(false)
                }
                return
            }
            DispatchQueue.main.async { [weak self] in
                self?.image = qrImage
                handler?(true)
            }
        }
    }
    
}
