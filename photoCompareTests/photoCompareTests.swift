//
//  photoCompareTests.swift
//  photoCompareTests
//
//  Created by eric yu on 4/13/18.
//  Copyright © 2018 eric yu. All rights reserved.
//

import XCTest
@testable import photoCompare

class photoCompareTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    func testNumberOfFace(){
        let x = UIImage(named: "zeroFace")
        let y = UIImage(named: "oneFace")
        let z = UIImage(named: "threeFace")
        
        let vp = VisionProcessor()
   
        XCTAssertEqual(vp.numberFaceDetected(image:x!), 0)
        XCTAssertEqual(vp.numberFaceDetected(image:y!), 1)
        XCTAssertEqual(vp.numberFaceDetected(image: z!), 3)
        
    }
    
    func testExample() {
       
    }
    
   
}
