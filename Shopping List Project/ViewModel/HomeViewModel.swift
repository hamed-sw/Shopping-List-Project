//
//  HomeViewModel.swift
//  Shopping List Project
//
//  Created by Hamed Amiry on 08.03.2021.
//

import Foundation

protocol HomeViewModelDelegate: class {
    func update()
}

class HomeViewModel {
 
    
    var productData: Products?
    weak var delegate: HomeViewModelDelegate?
    
    
    func productSearch() {
        JsonParsing.parseJsonFile { [weak self] newData in
            self?.productData = newData
            self?.delegate?.update()
        }
    }
    
    
    
    //MARK: GET DATA
    
    /// Function that returns total number of product
    /// - Returns: return total product
    func getTotalNumberOfProducts() -> Int? {
        let totalProduct = productData?.documents?.count
        return totalProduct ?? 0
    }
    
    /// Function to retun  the name of Product
    /// - Parameter index: product name for each index
    /// - Returns: return only a product name as string, if does not exist then return the default as empty string.
    func getProuductName(at index: Int) -> String? {
        let productName = productData?.documents?.object(at: index)?.fields?.name?.stringValue
        return productName ?? ""
    }
    /// Function returns an id of Product
    /// - Parameter index: based on indexpath in the row
    /// - Returns: returns the id as string
    func getProuductid(at index: Int) -> String? {
        let productId = productData?.documents?.object(at: index)?.fields?.id?.stringValue
        return productId ?? ""
    }
    
    /// Function returns an image of Product
    /// - Parameter index: based on indexpath in the row
    /// - Returns: returns the image url as string
    func getProductImage(at index: Int) -> String? {
        
        let productImage = productData?.documents?.object(at: index)?.fields?.image?.stringValue
        return productImage ?? ""
    }
    
    func getPrductPrice(at index: Int) -> Double? {
        let productPrice = productData?.documents?.object(at: index)?.fields?.price?.doubleValue
        return productPrice ?? 0.0
    }
    func getDeletId(at index: Int) -> String? {
        let idForDelet = productData?.documents?.object(at: index)?.name
        return idForDelet ?? ""
    }
    
    
}
