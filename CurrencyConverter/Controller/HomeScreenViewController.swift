//
//  HomeScreenViewController.swift
//  CurrencyConverter
//
//  Created by Yurii on 20.10.2021.
//

import UIKit

class HomeScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    
    var currenciesArray = [Currency]()
    let currencyController = CurrencyController()
    let currencyCodesToShow: [Int] = [840, 978]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchCurrencies()
    }
    
    
    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return currenciesArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CurrencyTableViewCell

        let currenciesArrayItem = currenciesArray[indexPath.row]
        cell.shortDescription.text = currenciesArrayItem.shortendDescription
        // Decimal format according to Mockup
        cell.rate.text = String(format: "%.1f", currenciesArrayItem.rate)

        return cell
    }
    
    // MARK: - Table view delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToConverter"{
            let vc = segue.destination as? ConverterTableViewController
            vc?.currenciesArray = currenciesArray
        }
    }
    
}

extension HomeScreenViewController {
    
    func fetchCurrencies(){
        
        self.currenciesArray = []
        self.tableView.reloadData()
        
        currencyController.fetchCurrencyRates { (result) in
            switch result {
            case .success(let resultCurrenciesArray):
                DispatchQueue.main.async {
                    self.currenciesArray = self.currencyController.specificCurrenciesArray(of: self.currencyCodesToShow, from: resultCurrenciesArray)
                    self.tableView.reloadData()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error)
                    self.currenciesArray = self.currencyController.specificCurrenciesArray(of: self.currencyCodesToShow, from: CurrencyLocalData.backupCurrencyData)
                    self.tableView.reloadData()
                }
            }
        }
    }
    
}
