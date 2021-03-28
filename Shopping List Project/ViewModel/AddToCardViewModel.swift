//
//  AddToCardViewModel.swift
//  Shopping List Project
//
//  Created by Hamed Amiry on 08.03.2021.
//

import Foundation
protocol AddViewModelDelegate: class {
    func update()
}

class AddCardViewModel {
    
    var addProductData: Products?
    weak var delegate: AddViewModelDelegate?
    
    
    func AddCardSearch() {
        JsonPost.parseJsonFile { [weak self] addCardData in
            self?.addProductData = addCardData
            self?.delegate?.update()
        }
    }
    
    func deleteTheProductFromAddCard(productId:String){
        JsonDelete.del(id: productId) { (error) in
            if let error = error {
                print("we have error for delete\(error)")
            }else {
                print("the producet deleted")
            }
        }
    }
        
    //MARK: GET DATA
    
    /// Function that returns total number of product
    /// - Returns: return total product
    func getTotalNumberOfAddCard() -> Int? {
        let totalAddProduct = addProductData?.documents?.count
        return totalAddProduct ?? 0
    }
    func getTotalNumberOf(at index: Int) -> Array<Any> {
        let total = addProductData?.documents?.remove(at: index)
        let newArray = [total]
        return newArray as Array<Any> 
    }
    
    /// Function to retun  the name of Product
    /// - Parameter index: product name for each index
    /// - Returns: return only a product name as string, if does not exist then return the default as empty string.
    func getAddCardName(at index: Int) -> String? {
        let addCardName = addProductData?.documents?.object(at: index)?.fields?.name?.stringValue
        return addCardName ?? ""
    }
    /// Function returns an id of Product
    /// - Parameter index: based on indexpath in the row
    /// - Returns: returns the id as string
    func getAddCardid(at index: Int) -> String? {
        let addCardId = addProductData?.documents?.object(at: index)?.fields?.id?.stringValue
        return addCardId ?? ""
    }
    
    /// Function returns an image of Product
    /// - Parameter index: based on indexpath in the row
    /// - Returns: returns the image url as string
    func getAddCardImage(at index: Int) -> String? {
        
        let addCardImage = addProductData?.documents?.object(at: index)?.fields?.image?.stringValue
        return addCardImage ?? ""
    }
    
    func getAddCardPrice(at index: Int) -> Double? {
        let addCardPrice = addProductData?.documents?.object(at: index)?.fields?.price?.doubleValue
        return addCardPrice ?? 0.0
    }
    func getAddCardDeletId(at index: Int) -> String? {
        let idForDeletAddCard = addProductData?.documents?.object(at: index)?.name
        return idForDeletAddCard ?? ""
    }

}
