//
//  String+QR.swift
//  QRKit
//
//  Created by Yuji Taniguchi on 2017/01/20.
//  Copyright © 2017 natpenguin. All rights reserved.
//

import UIKit

extension String {
    
    /// Creates and returns an instance of `QRCreator` based on itself.
    public var qrcreator: QRCreator? {
        return data(using: .utf8)?.qrcreator
    }
    
}
