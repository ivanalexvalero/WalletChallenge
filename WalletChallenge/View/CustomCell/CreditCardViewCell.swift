//
//  CreditCardViewCell.swift
//  WalletChallenge
//
//  Created by Ivan Valero on 05/08/2022.
//

import UIKit

class CreditCardViewCell: UITableViewCell {

    static let kId = "CreditCardViewCell"
    
    @IBOutlet weak var nameCardTextLabel: UILabel!
    
    @IBOutlet weak var dateCardTextLabel: UILabel!
    @IBOutlet weak var balanceCardTextLabel: UILabel!
    @IBOutlet weak var numberCardTextLabel: UILabel!
    @IBOutlet weak var codeCardTextLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    func configCell(model: ItemListCreditCard) {
        nameCardTextLabel.text = model.creditName
        numberCardTextLabel.text = model.creditNumber
        dateCardTextLabel.text = ("Valid: \(model.creditDate)")
        codeCardTextLabel.text = ("CVV: \(model.creditCVV)")
        balanceCardTextLabel.text = ("$ \(model.creditBalance)")
    }
    
}
