//
//  FetBackViewModel.swift
//  Shopping List ProjectTests
//
//  Created by Hamed Amiry on 26.03.2021.
//

import XCTest
@testable import Shopping_List_Project

class FetBackViewModel: XCTestCase {
    
    var fetBackViewModel = FetbackModel()
    
    func testTotalNumberOfFetBack() {
        let total = fetBackViewModel.getTotalNumberOfFetback()
        XCTAssertEqual(total, 0)
    }
    
    func testgetFetBAckName() {
        let name = fetBackViewModel.getFetBack(at: 0)
        XCTAssertEqual(name, "")
    }
    
    func testgetboolean() {
        let boolean = fetBackViewModel.getBoolean(at: 0)
        XCTAssertEqual(boolean, false)
    }
    
    func testFetBackForDelet() {
        let delete = fetBackViewModel.getFetBackDelet(at: 0)
        XCTAssertEqual(delete, "")
    }
    

   

}
