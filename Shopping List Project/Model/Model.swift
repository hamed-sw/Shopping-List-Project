//
//  Model.swift
//  Shopping List Project
//
//  Created by Hamed Amiry on 08.03.2021.
//

import Foundation

struct Products: Codable {
    var documents: [Store]?

}
struct Store: Codable {
    let name: String?
    let fields: ProductFilds?
}
struct ProductFilds: Codable {
    let name: Name?
    let price: Price?
    let image: ImageUrl?
    let id : IdString?
    
}
struct Name: Codable {
    let stringValue: String?
}
struct Price: Codable {
    let doubleValue: Double?
}
struct ImageUrl: Codable {
    let stringValue: String?
}
struct IdString: Codable {
    let stringValue: String?
}

