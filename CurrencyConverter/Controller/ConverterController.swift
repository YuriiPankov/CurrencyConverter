//
//  ConverterController.swift
//  CurrencyConverter
//
//  Created by Yurii on 22.10.2021.
//

import Foundation
import UIKit

class ConverterController{
    
    func updateCurrenciesArray(from currenciesArray: [Currency]) -> [Currency] {
        let uah = Currency(code: 980, rate: 1.0, shortendDescription: "UAH")
        var uahArray = currenciesArray
        uahArray.sort {
            $0.shortendDescription < $1.shortendDescription
        }
        uahArray.append(uah)
        return uahArray
    }
    
    func convert(baseCurrency: Currency, outputCurrency: Currency, baseCurrencyAmount: String) -> String {
        
        guard let baseCurrencyAmount = Double(baseCurrencyAmount) else {
            return ""
        }
        
        let baseRate = baseCurrency.rate
        let outputRate = outputCurrency.rate
        let multiplier = baseRate / outputRate
        let outputAmount = String(format: "%.2f", baseCurrencyAmount * multiplier)
        
        return outputAmount
    }
}


extension ConverterTableViewController{
    
    func initialUpdateUI() {
        firstPickedCurrency = updatedCurrenciesArray[0]
        secondPickedCurrency = updatedCurrenciesArray[0]
        firstLabel.text = firstPickedCurrency.shortendDescription
        secondLabel.text = secondPickedCurrency.shortendDescription
    }
}
