//
//  CurrencyTableViewCell.swift
//  CurrencyConverter
//
//  Created by Yurii on 21.10.2021.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {

    @IBOutlet weak var shortDescription: UILabel!
    @IBOutlet weak var rate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
