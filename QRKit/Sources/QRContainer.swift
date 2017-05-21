//
//  QRContainer.swift
//  QRKit
//
//  Created by Yuji Taniguchi on 2017/05/20.
//  Copyright © 2017 natpenguin. All rights reserved.
//

import UIKit

public struct QRContainer<T> {
    
    // MARK: - lifecycle
    
    init(raw: T) {
        self.raw = raw
    }
    
    // MARK: - fileprivate
    
    let raw: T
    
}

extension QRContainer where T == String {
    
    public var creator: QRCreateContext? {
        guard let data = raw.data(using: .utf8) else { return nil }
        return QRCreateContext(raw: data)
    }
    
}

extension QRContainer where T == Data {
    
    public var creator: QRCreateContext? {
        return QRCreateContext(raw: raw)
    }
    
}

extension QRContainer where T == UIImage {
    
    public var detector: QRDetectContext? {
        return QRDetectContext(raw: raw)
    }
    
}

extension QRContainer where T == UIImageView {
    
    func set(of string: String, completion handler: ((Bool) -> Void)? = nil) {
        DispatchQueue.global(qos: .default).async {
            let creator = string.qr.creator
            if let image = creator?.image() {
                DispatchQueue.main.async {
                    self.raw.image = image
                    handler?(true)
                }
            } else {
                DispatchQueue.main.async {
                    self.raw.image = nil
                    handler?(false)
                }
            }
        }
    }
    
}
