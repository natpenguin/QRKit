//
//  QRCorrection.swift
//  QRKit
//
//  Created by Yuji Taniguchi on 2017/05/20.
//  Copyright © 2017 natpenguin. All rights reserved.
//

import Foundation

/// Correction level when generating QR code.
///
/// - h: 30%
/// - q: 25%
/// - m: 15%
/// - l: 07%
enum QRCorrection: String {
    case h = "H"
    case q = "Q"
    case m = "M"
    case l = "L"
}
