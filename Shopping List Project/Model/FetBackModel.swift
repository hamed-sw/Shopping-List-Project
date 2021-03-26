//
//  FetBackModel.swift
//  Shopping List Project
//
//  Created by Hamed Amiry on 24.03.2021.
//

import Foundation

struct Fetback: Codable {
    var documents: [Datas]?

}
struct Datas: Codable {
    let name: String?
    let fields: FetBackFile?
}
struct FetBackFile: Codable {
    let fetback: FetbackProduct?
    let boolean: Boolean?
}
struct FetbackProduct: Codable {
    let stringValue: String?
}
struct Boolean: Codable {
    let booleanValue: Bool?
}

