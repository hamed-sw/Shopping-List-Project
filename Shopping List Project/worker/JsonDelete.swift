//
//  JsonDelete.swift
//  Shopping List Project
//
//  Created by Hamed Amiry on 09.03.2021.
//

import UIKit


class JsonDelete {
    
    
    
  static  func del(id: String, completion: @escaping (Error?) -> ()){
        guard let url = URL(string: "https://firestore.googleapis.com/v1/projects/online-46aa4/databases/(default)/documents/addData/\(id)") else {return}
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


