//
//  JsonPost.swift
//  Shopping List Project
//
//  Created by Hamed Amiry on 09.03.2021.
//

import UIKit


class JsonPost {

  static  func addDataToCard(prices price: Double ,pic image : String,nu id: String,names name: String ) {
        
        
        let did = ["fields": [
            "price": [
                "doubleValue": price
            ],
            "image": [
                "stringValue": image
            ],
            "id": [
                "stringValue": id
            ],
            "name": [
                "stringValue": name
            ]
        ]]

    var urlRequst = URLRequest(url: URL(string: "https://firestore.googleapis.com/v1/projects/online-46aa4/databases/(default)/documents/addData")!)
    urlRequst.httpMethod = "post"


    do {
        let requsetbody = try JSONSerialization.data(withJSONObject: did, options: .prettyPrinted)
        urlRequst.httpBody = requsetbody
        urlRequst.addValue("application/json", forHTTPHeaderField: "content-type")
        
    }catch let error {
        debugPrint(error.localizedDescription)
    }
    

    URLSession.shared.dataTask(with: urlRequst) { (data, resposns, error) in
        if (data != nil && data?.count != 0) {
            let response = String(data: data!, encoding: .utf8)
            print(response)
        }
    }.resume()
    
 }
    
 //MARK: FOR DECODING
typealias success = (PostProduct) -> ()
    static func parseJsonFile (onSucess:@escaping success) {
        if let url = URL(string: "https://firestore.googleapis.com/v1/projects/online-46aa4/databases/(default)/documents/addData") {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else {return}
                
                do {
                    let json = try JSONDecoder().decode(PostProduct.self, from: data)
                    onSucess(json)
                }catch {
                    debugPrint(error.localizedDescription)
                }
            }.resume()
        }
        
    }
    
    
    
}
