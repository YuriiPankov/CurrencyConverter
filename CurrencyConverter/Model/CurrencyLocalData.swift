//
//  CurrencyLocalData.swift
//  CurrencyConverter
//
//  Created by Yurii on 22.10.2021.
//

import Foundation
import UIKit

class CurrencyLocalData {
    
    // This will be used in case of absent internet connection
    // Updated 23.10.2021
    
    static let backupCurrencyData = [Currency(code: 840, rate: 26.2918, shortendDescription: "USD"), Currency(code: 978, rate: 30.5774, shortendDescription: "EUR")]
}
