//
//  QRCompatible.swift
//  QRKit
//
//  Created by Yuji Taniguchi on 2017/05/20.
//  Copyright © 2017 natpenguin. All rights reserved.
//

import UIKit

public protocol QRCompatible {
    associatedtype T
    var qr: T { get }
}

extension QRCompatible {
    
    public var qr: QRContainer<Self> {
        return QRContainer(raw: self)
    }
    
}

extension Data: QRCompatible {}
extension String: QRCompatible {}
extension UIImage: QRCompatible {}
