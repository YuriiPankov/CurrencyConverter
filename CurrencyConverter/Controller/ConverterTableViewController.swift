//
//  ConverterTableViewController.swift
//  CurrencyConverter
//
//  Created by Yurii on 21.10.2021.
//

import UIKit

class ConverterTableViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var currenciesArray = [Currency]()
    var updatedCurrenciesArray = [Currency]()
    let converterController = ConverterController()
    var firstPickedCurrency = Currency(code: 0, rate: 1, shortendDescription: "")
    var secondPickedCurrency = Currency(code: 0, rate: 1, shortendDescription: "")
    
    @IBOutlet weak var firstPicker: UIPickerView!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondPicker: UIPickerView!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var secondTextField: UITextField!
    
    let firstPickerCellIndexPath = IndexPath(row: 1, section: 0)
    let secondPickerCellIndexPath = IndexPath(row: 1, section: 1)
    let firstLabelCellIndexPath = IndexPath(row: 0, section: 0)
    let secondLabelCellIndexPath = IndexPath(row: 0, section: 1)
    
    var isFirstPickerVisible: Bool = false {
        didSet{
            firstPicker.isHidden = !isFirstPickerVisible
        }
    }
    var isSecondPickerVisible: Bool = false{
        didSet{
            secondPicker.isHidden = !isSecondPickerVisible
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updatedCurrenciesArray = converterController.updateCurrenciesArray(from: currenciesArray)
        initialUpdateUI()
    }

    @IBAction func firstTextFieldIsChanged(_ sender: Any) {
        secondTextField.text = converterController.convert(baseCurrency: firstPickedCurrency, outputCurrency: secondPickedCurrency, baseCurrencyAmount: firstTextField.text ?? "")
    }
    @IBAction func secondTextFieldIsChanged(_ sender: Any) {
        firstTextField.text = converterController.convert(baseCurrency: secondPickedCurrency, outputCurrency: firstPickedCurrency, baseCurrencyAmount: secondTextField.text ?? "")
    }
    
 
    @IBAction func returnPressedFirstTextField(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    @IBAction func returnPressedSecondTextField(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return updatedCurrenciesArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return updatedCurrenciesArray[row].shortendDescription
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == firstPicker {
            firstPickedCurrency = updatedCurrenciesArray[row]
            firstLabel.text = firstPickedCurrency.shortendDescription
        } else if pickerView == secondPicker {
            secondPickedCurrency = updatedCurrenciesArray[row]
            secondLabel.text = secondPickedCurrency.shortendDescription
        }
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case firstPickerCellIndexPath where isFirstPickerVisible == false:
            return 0
        case secondPickerCellIndexPath where isSecondPickerVisible == false:
            return 0
        default:
            return UITableView.automaticDimension
        }
    }
    
    
    // MARK -- ToDo
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath == firstLabelCellIndexPath && isSecondPickerVisible == false {
            isFirstPickerVisible.toggle()
        } else if indexPath == secondLabelCellIndexPath && isFirstPickerVisible == false {
            isSecondPickerVisible.toggle()
        } else if indexPath == firstLabelCellIndexPath || indexPath == secondLabelCellIndexPath {
            isFirstPickerVisible.toggle()
            isSecondPickerVisible.toggle()
        } else {
            return
        }
        
        tableView.reloadData()
//        tableView.beginUpdates()
//        tableView.endUpdates()
    }
    
}

