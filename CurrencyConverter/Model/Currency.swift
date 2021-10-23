//
//  Currency.swift
//  CurrencyConverter
//
//  Created by Yurii on 20.10.2021.
//

import Foundation

struct Currency: Codable {
    var code: Int
    var rate: Double
    var shortendDescription: String

    
    enum CodingKeys: String, CodingKey {
    case code = "r030"
    case rate
    case shortendDescription = "cc"
    }
}


