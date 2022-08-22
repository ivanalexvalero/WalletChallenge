//
//  CreditCardModel.swift
//  WalletChallenge
//
//  Created by Ivan Valero on 04/08/2022.
//

import Foundation
import RealmSwift


class ItemListCreditCard: Object {
    @objc dynamic var creditName: String = ""
    @objc dynamic var creditNumber: String = ""
    @objc dynamic var creditDate: String = ""
    @objc dynamic var creditCVV: String = ""
    @objc dynamic var creditBalance: Float = 0.0
//    @objc dynamic var creditUserName: String = ""
}


