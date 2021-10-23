//
//  CurrencyController.swift
//  CurrencyConverter
//
//  Created by Yurii on 20.10.2021.
//

import Foundation
import UIKit

class CurrencyController {
    
    enum AnswerControllerError: Error, LocalizedError {
    case absentInternetConnection
    }
    
    func fetchCurrencyRates(completion: @escaping (Result<[Currency], Error>) -> Void) {
        let urlComponents = URLComponents(string: "https://bank.gov.ua/NBUStatService/v1/statdirectory/exchange?json")!
        URLSession.shared.dataTask(with: urlComponents.url!) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(AnswerControllerError.absentInternetConnection))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            if let data = data {
                do {
                    let requestResponse = try jsonDecoder.decode([Currency].self, from: data)
                    completion(.success(requestResponse))
                } catch  {
                    completion(.failure(error))
                }
            }
            
        }.resume()
    }
    
    func specificCurrenciesArray(of currencyCodes: [Int], from currencies: [Currency]) -> [Currency] {
        let selectedCurrencies = currencyCodes.map { (currencyCode)  in
            return currencies.first(where: {$0.code == currencyCode})!
        }
        return selectedCurrencies
    }
}
