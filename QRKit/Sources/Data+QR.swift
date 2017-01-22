//
//  Data+QR.swift
//  QRKit
//
//  Created by Yuji Taniguchi on 2017/01/21.
//  Copyright © 2017 natpenguin. All rights reserved.
//

import Foundation

extension Data {
    
    /// Creates and returns an instance of `QRCreator` based on itself.
    public var qrcreator: QRCreator {
        return QRCreator(data: self)
    }
    
}
