//
//  ConverterControllerProtocol.swift
//  CurrencyConverter
//
//  Created by Yurii on 06.11.2021.
//

import UIKit

protocol ConverterControllerProtocol {
    
    func updateCurrenciesArray(from currenciesArray: [Currency]) -> [Currency]
    
    func convert(baseCurrency: Currency, outputCurrency: Currency, baseCurrencyAmount: String) -> String
}

extension ConverterControllerProtocol {
    
    // This method sorts array of currencies in alphabetical order of shortend desxriptions and adds Hryvnia currency to array
    // Final currencies order is shown according to Mockup
    func updateCurrenciesArray(from currenciesArray: [Currency]) -> [Currency] {
        let uah = Currency(code: 980, rate: 1.0, shortendDescription: "UAH")
        var uahArray = currenciesArray
        uahArray.sort {
            $0.shortendDescription < $1.shortendDescription
        }
        uahArray.append(uah)
        return uahArray
    }
    
    // Converts base currency amount to output currency amount using base currency and output currency rates
    func convert(baseCurrency: Currency, outputCurrency: Currency, baseCurrencyAmount: String) -> String {
        
        guard let baseCurrencyAmount = Double(baseCurrencyAmount) else {
            return ""
        }
        
        let baseRate = baseCurrency.rate
        let outputRate = outputCurrency.rate
        let multiplier = baseRate / outputRate
        // output amount has two decimal digits after point
        let outputAmount = String(format: "%.2f", baseCurrencyAmount * multiplier)
        
        return outputAmount
    }
    
}
