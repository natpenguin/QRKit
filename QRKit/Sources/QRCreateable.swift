//
//  QRCreateable.swift
//  QRKit
//
//  Created by Yuji Taniguchi on 2017/05/20.
//  Copyright © 2017 natpenguin. All rights reserved.
//

import UIKit

public protocol QRCreateable {
    var data: Data? { get }
}

extension String: QRCreateable {
    
    public var data: Data? {
        return data(using: .utf8)
    }
    
}

extension Data: QRCreateable {
    
    public var data: Data? {
        return self
    }
    
}
