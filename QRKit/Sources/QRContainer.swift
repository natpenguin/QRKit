//
//  QRContainer.swift
//  QRKit
//
//  Created by Yuji Taniguchi on 2017/05/20.
//  Copyright © 2017 natpenguin. All rights reserved.
//

import UIKit

public protocol QRKit {
    associatedtype T
    var qr: T { get }
}

extension QRKit {
    
    public var qr: QRContainer<Self> {
        return QRContainer(raw: self)
    }
    
}

extension Data: QRKit {}
extension String: QRKit {}

public struct QRContainer<T> {
    
    // MARK: - lifecycle
    
    init(raw: T) {
        self.raw = raw
    }
    
    // MARK: - private
    
    let raw: T
    
}

extension QRContainer where T: QRCreateable {
    
    public var creator: QRCreateContext? {
        guard let data = raw.data else { return nil }
        return QRCreateContext(raw: data)
    }
    
}
