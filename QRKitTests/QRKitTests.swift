//
//  QRKitTests.swift
//  QRKitTests
//
//  Created by Yuji Taniguchi on 2017/01/21.
//  Copyright © 2017 natpenguin. All rights reserved.
//

import XCTest
@testable import QRKit

class QRKitTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testQuickResponse() {
        let string = "https://www.natpenguin.com/"
        let image = string.qr.creator?.correction(.h).size(CGSize(width: 150, height: 150)).renderer(.software).image()
        let strings = image?.qr.detector?.accurary(.high).strings()
        XCTAssert(strings?.contains(string) ?? false, "Contain string.")
    }
    
}
