//
//  HomeViewModelTest.swift
//  Shopping List ProjectTests
//
//  Created by Hamed Amiry on 11.03.2021.
//

import XCTest
@testable import Shopping_List_Project

class HomeViewModelTest: XCTestCase {
    var testViewModel = HomeViewModel()

    func testTheNumberOfProducts() {
        let totalnumber = testViewModel.getTotalNumberOfProducts()
        XCTAssertEqual(totalnumber, 0)
    }
    func testTheNameOfProduct() {
        let name = testViewModel.getProuductName(at: 0)

        XCTAssertEqual(name, "")
    }
    func testPrice() {
        let newTest = testViewModel.getPrductPrice(at: 0)
        XCTAssertEqual(newTest!, 0.0)
    }
    
    func testProductId() {
        let productId = testViewModel.getProuductid(at: 0)
        XCTAssertEqual(productId, "")
    }
    
    func testProductImage() {
        let productImage = testViewModel.getProductImage(at: 0)
        XCTAssertEqual(productImage, "")
    }
    
    func testDeletingId() {
        let ProductForDeletingId = testViewModel.getDeletId(at: 0)
        XCTAssertEqual(ProductForDeletingId, "")

    }
    
   

    

}
