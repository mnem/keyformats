//
//  NSData+ParsingTests.swift
//  KeyFormatsTests
//
//  Created by David Wagner on 29/06/2021.
//

import XCTest

class NSData_ParsingTests: XCTestCase {

    func testEmptyString() throws {
        let input = ""
        let output = NSData(fromHexString: input)
        
        XCTAssertEqual(output.length, 0)
    }
    
    func testLowNibbles() throws {
        XCTAssertEqual(Data([0x00 as UInt8]), NSData(fromHexString: "0") as Data)
        XCTAssertEqual(Data([0x01 as UInt8]), NSData(fromHexString: "1") as Data)
        XCTAssertEqual(Data([0x02 as UInt8]), NSData(fromHexString: "2") as Data)
        XCTAssertEqual(Data([0x03 as UInt8]), NSData(fromHexString: "3") as Data)
        XCTAssertEqual(Data([0x04 as UInt8]), NSData(fromHexString: "4") as Data)
        XCTAssertEqual(Data([0x05 as UInt8]), NSData(fromHexString: "5") as Data)
        XCTAssertEqual(Data([0x06 as UInt8]), NSData(fromHexString: "6") as Data)
        XCTAssertEqual(Data([0x07 as UInt8]), NSData(fromHexString: "7") as Data)
        XCTAssertEqual(Data([0x08 as UInt8]), NSData(fromHexString: "8") as Data)
        XCTAssertEqual(Data([0x09 as UInt8]), NSData(fromHexString: "9") as Data)
        XCTAssertEqual(Data([0x0a as UInt8]), NSData(fromHexString: "a") as Data)
        XCTAssertEqual(Data([0x0b as UInt8]), NSData(fromHexString: "b") as Data)
        XCTAssertEqual(Data([0x0c as UInt8]), NSData(fromHexString: "c") as Data)
        XCTAssertEqual(Data([0x0d as UInt8]), NSData(fromHexString: "d") as Data)
        XCTAssertEqual(Data([0x0e as UInt8]), NSData(fromHexString: "e") as Data)
        XCTAssertEqual(Data([0x0f as UInt8]), NSData(fromHexString: "f") as Data)

        // Test the ol' uppercase
        XCTAssertEqual(Data([0x0a as UInt8]), NSData(fromHexString: "A") as Data)
        XCTAssertEqual(Data([0x0b as UInt8]), NSData(fromHexString: "B") as Data)
        XCTAssertEqual(Data([0x0c as UInt8]), NSData(fromHexString: "C") as Data)
        XCTAssertEqual(Data([0x0d as UInt8]), NSData(fromHexString: "D") as Data)
        XCTAssertEqual(Data([0x0e as UInt8]), NSData(fromHexString: "E") as Data)
        XCTAssertEqual(Data([0x0f as UInt8]), NSData(fromHexString: "F") as Data)
    }
    
    func testHighNibbles() throws {
        XCTAssertEqual(Data([0x00 as UInt8]), NSData(fromHexString: "00") as Data)
        XCTAssertEqual(Data([0x10 as UInt8]), NSData(fromHexString: "10") as Data)
        XCTAssertEqual(Data([0x20 as UInt8]), NSData(fromHexString: "20") as Data)
        XCTAssertEqual(Data([0x30 as UInt8]), NSData(fromHexString: "30") as Data)
        XCTAssertEqual(Data([0x40 as UInt8]), NSData(fromHexString: "40") as Data)
        XCTAssertEqual(Data([0x50 as UInt8]), NSData(fromHexString: "50") as Data)
        XCTAssertEqual(Data([0x60 as UInt8]), NSData(fromHexString: "60") as Data)
        XCTAssertEqual(Data([0x70 as UInt8]), NSData(fromHexString: "70") as Data)
        XCTAssertEqual(Data([0x80 as UInt8]), NSData(fromHexString: "80") as Data)
        XCTAssertEqual(Data([0x90 as UInt8]), NSData(fromHexString: "90") as Data)
        XCTAssertEqual(Data([0xa0 as UInt8]), NSData(fromHexString: "a0") as Data)
        XCTAssertEqual(Data([0xb0 as UInt8]), NSData(fromHexString: "b0") as Data)
        XCTAssertEqual(Data([0xc0 as UInt8]), NSData(fromHexString: "c0") as Data)
        XCTAssertEqual(Data([0xd0 as UInt8]), NSData(fromHexString: "d0") as Data)
        XCTAssertEqual(Data([0xe0 as UInt8]), NSData(fromHexString: "e0") as Data)
        XCTAssertEqual(Data([0xf0 as UInt8]), NSData(fromHexString: "f0") as Data)
    }

    func testRubbish() throws {
        let input = "xyz"
        let output = NSData(fromHexString: input)
        
        XCTAssertEqual(Data([0x00 as UInt8, 0x00 as UInt8]), output as Data)
    }
    
    func testLongerHexString() {
        let input = "10001"
        let output = NSData(fromHexString: input)
        
        XCTAssertEqual(Data([0x01 as UInt8, 0x00 as UInt8, 0x01 as UInt8]), output as Data)
    }
}
