//
//  TestHeadwordEntryParser.swift
//  Tests
//
//  Created by Yusei Nishiyama on 05/08/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import XCTest
import OxfordDictionary
@testable import App

class TestRetrieveEntryParser: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testHomograph() {
        let retrieveEntry = loadFixture(OxfordDictionary.RetrieveEntry.self, from: "Homograph")
        let _ = RetrieveEntryEntryParser.parse(retrieveEntry)

        assert(true, "Successfully parsed")
    }

    func testHeteronym() {
        let retrieveEntry = loadFixture(OxfordDictionary.RetrieveEntry.self, from: "Heteronym")
        let headwordEntry = RetrieveEntryEntryParser.parse(retrieveEntry)

        assert(headwordEntry.homographs[0].pronunciation == "bəʊ")
        assert(headwordEntry.homographs[1].pronunciation == "baʊ")
        assert(headwordEntry.homographs[2].pronunciation == "baʊ")

        assert(true, "Successfully parsed")
    }
}
