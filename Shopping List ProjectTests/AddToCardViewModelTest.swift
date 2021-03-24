//
//  AddToCardViewModelTest.swift
//  Shopping List ProjectTests
//
//  Created by Hamed Amiry on 11.03.2021.
//
import XCTest
@testable import Shopping_List_Project

class AddToCardViewModelTest: XCTestCase {

    var testViewModel =  AddCardViewModel()

        func testTheNumberOfProducts() {
            let totalnumber = testViewModel.getTotalNumberOfAddCard()
            XCTAssertEqual(totalnumber, 0)
          
            
        }
        func testTheNameOfProduct() {
            let name = testViewModel.getAddCardName(at: 0)

            XCTAssertEqual(name, "")
        }
        func testPrice() {
            let newTest = testViewModel.getAddCardPrice(at: 0)
            XCTAssertEqual(newTest!, 0.0)
        }
        
        func testProductId() {
            let productId = testViewModel.getAddCardid(at: 0)
            XCTAssertEqual(productId, "")
        }
        
        func testProductImage() {
            let productImage = testViewModel.getAddCardImage(at: 0)
            XCTAssertEqual(productImage, "")
        }
        
        func testDeletingId() {
            let ProductForDeletingId = testViewModel.getAddCardDeletId(at: 0)
            XCTAssertEqual(ProductForDeletingId, "")
            
        }
        
       
}

