//
//  JsonParsing.swift
//  Shopping List Project
//
//  Created by Hamed Amiry on 08.03.2021.
//

import UIKit

class JsonParsing {
    
// MARK: FOR GET
    typealias success = (Products) -> ()
    static func parseJsonFile (onSucess:@escaping success) {
        if let url = URL(string: "https://firestore.googleapis.com/v1/projects/online-46aa4/databases/(default)/documents/Watches") {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else {return}
                
                do {
                    let json = try JSONDecoder().decode(Products.self, from: data)
                    onSucess(json)
                }catch {
                    debugPrint(error.localizedDescription)
                }
            }.resume()
        }
        
    }
}
