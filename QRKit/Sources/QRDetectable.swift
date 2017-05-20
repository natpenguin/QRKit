//
//  QRDetectable.swift
//  QRKit
//
//  Created by Yuji Taniguchi on 2017/05/20.
//  Copyright © 2017 natpenguin. All rights reserved.
//

import UIKit

public protocol QRDetectable {
    var image: UIImage? { get }
}

extension UIImage: QRDetectable {
    
    public var image: UIImage? {
        return self
    }
    
}
