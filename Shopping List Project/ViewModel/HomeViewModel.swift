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
  //  var title: String = ""
   // var done: Bool = false
    
    var productData: Products?
    weak var delegate: HomeViewModelDelegate?
    var arrayNameItem = [String]()
    
    
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
    
//    func getTotalFalse(at index:Int) -> Bool? {
//        var total = productData?.documents?.object(at: index)?.fields?.name?.done
//         total = false
//        return (total ?? false) as Bool
//    }
//    func getTotalTrue(at index:Int) -> Bool? {
//        var total = productData?.documents?.object(at: index)?.fields?.name?.done
//         total = true
//        return (total ?? true) as Bool
//    }
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
    
    
    
    
    func addItemInArray(nameOfItem: String){
        var addItemName = [String]()
    /// user defaultls
    /// user defaults are used for persistency for small chain of date which is not confidential
        let defaults = UserDefaults.standard
        if let addDefult = defaults.object(forKey: "addItem") {
            addItemName = addDefult as? [String] ?? []
        }
        addItemName.append(nameOfItem)
        defaults.set(addItemName, forKey: "addItem")
        defaults.synchronize()
    }
    
    func fetchNameOfItem(){
        let defaults = UserDefaults.standard
        if let nameitem = defaults.object(forKey: "addItem"){
             arrayNameItem = nameitem as? [String] ?? []
        }
    }
    
    func refresh() {
        fetchNameOfItem()
        arrayNameItem = []
    }
}
