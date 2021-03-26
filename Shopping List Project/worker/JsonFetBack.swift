//
//  JsonFetBack.swift
//  Shopping List Project
//
//  Created by Hamed Amiry on 24.03.2021.
//

import Foundation
import UIKit

class JsonFetBack {
    var controller = FetBackViewController()


    static  func fetbackHere(names name: String, bool boolean: Bool  ) {
        
        
        let did = ["fields": [
            "fetback": [
                "stringValue": name
            ],
            "boolean": [
                "booleanValue": boolean
            ]
        ]]
    
    guard let url = URL(string: "https://firestore.googleapis.com/v1/projects/online-46aa4/databases/(default)/documents/fetback") else {return}
    
    var urlRequst = URLRequest(url: url)
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
            // let response = String(data: data!, encoding: .utf8)
            //  print(response)
        }
    }.resume()
    
 }
    
 //MARK: FOR DECODING
typealias success = (Fetback) -> ()
    static func parseJsonFile (onSucess:@escaping success) {
        if let url = URL(string: "https://firestore.googleapis.com/v1/projects/online-46aa4/databases/(default)/documents/fetback") {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else {return}
                
                do {
                    let json = try JSONDecoder().decode(Fetback.self, from: data)
                    onSucess(json)
                }catch {
                    debugPrint(error.localizedDescription)
                }
            }.resume()
        }
        
    }
    
    



     static  func delete(id: String, completion: @escaping (Error?) -> ()){
          guard let url = URL(string: "https://firestore.googleapis.com/v1/projects/online-46aa4/databases/(default)/documents/fetback/\(id)") else {return}
          var urlReq = URLRequest(url: url)
          urlReq.httpMethod = "DELETE"
          URLSession.shared.dataTask(with: urlReq) { (data, resp, error) in
             // DispatchQueue.main.async {
                  if let error = error {
                      completion(error)
                      return
                  }
                  completion(nil)
            //  }
              
          }.resume()
      }
    
    
}
