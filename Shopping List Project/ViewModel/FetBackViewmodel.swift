//
//  FetBackViewmodel.swift
//  Shopping List Project
//
//  Created by Hamed Amiry on 24.03.2021.
//

import Foundation
import Foundation
protocol FetBackModelDelegate: class {
    func updates()
}

class FetbackModel {
    
    var fetbackProduct: Fetback?
    weak var delegate: FetBackModelDelegate?
    
    
    func fetbackToProduct() {
         JsonFetBack.parseJsonFile { [weak self] addCardData in
            DispatchQueue.main.async {
                self?.fetbackProduct = addCardData
                self?.delegate?.updates()
            }
            
        }
    }
    
    func deleteTheProductFromFetback(productId:String){
        JsonFetBack.delete(id: productId) { (error) in
            if let error = error {
                print("we have error for delete\(error)")
            }else {
                print("the producet deleted")
            }
        }
    }
    func insertFetback(insert: String, forBool: Bool) {
        JsonFetBack.fetbackHere(names: insert, bool: forBool)
    }
        
    //MARK: GET DATA
    
    func getTotalNumberOfFetback() -> Int? {
        let totalAddProduct = fetbackProduct?.documents?.count
        return totalAddProduct ?? 0
    }

    func getTotalNumberForRemove(at index: Int) -> Array<Any> {
        let total = fetbackProduct?.documents?.remove(at: index)
        let newArray = [total]
        return newArray as Array<Any>
    }
    
    func getFetBack(at index: Int) -> String? {
        let fetback = fetbackProduct?.documents?.object(at: index)?.fields?.fetback?.stringValue
        return fetback ?? ""
    }

    func getBoolean(at index: Int) -> Bool? {
        let fetbackBool = fetbackProduct?.documents?.object(at: index)?.fields?.boolean?.booleanValue
        return fetbackBool ?? false
    }
    
    func getFetBackDelet(at index: Int) -> String? {
        let delete = fetbackProduct?.documents?.object(at: index)?.name
        return delete ?? ""
    }
    
}
