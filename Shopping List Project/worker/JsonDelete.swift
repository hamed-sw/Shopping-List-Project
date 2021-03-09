//
//  JsonDelete.swift
//  Shopping List Project
//
//  Created by Hamed Amiry on 09.03.2021.
//

import UIKit


class JsonDelete {
    
    
//    let str = "projects/online-46aa4/databases/(default)/documents/addData/9EpWwmeVmsxhsvGR4tLf"
//    let size = str.reversed().firstIndex(of: "/") ?? str.count
//    let startWord = str.index(str.endIndex, offsetBy: -size)
//    let last = str[startWord...]
//   // let lastsss = try? String(from: last as! Decoder)
//    let sss = String(last)
//    print (sss)
//
//
//    del(id: sss) { (erro) in
//        if let err = erro {
//            print("errrrrr",err)
//            return
//        }
//        print("delete")
//    }
    
    
    
  static  func del(id: String, completion: @escaping (Error?) -> ()){
        guard let url = URL(string: "https://firestore.googleapis.com/v1/projects/online-46aa4/databases/(default)/documents/addData/\(id)") else {return}
        var urlReq = URLRequest(url: url)
        urlReq.httpMethod = "DELETE"
        URLSession.shared.dataTask(with: urlReq) { (data, resp, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(error)
                    return
                }
                completion(nil)
            }
            
        }.resume()
    }
    
}


