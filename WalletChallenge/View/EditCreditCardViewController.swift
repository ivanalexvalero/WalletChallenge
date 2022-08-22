//
//  VC3.swift
//  WalletChallenge
//
//  Created by Ivan Valero on 05/08/2022.
//

import UIKit
import DropDown
import RealmSwift

class EditCreditCardViewController: UIViewController {
    
    let dropDown = DropDown()
    let creditCards = ["Mastercard", "Visa", "American Express"]
    var numCard = ["", "", ""]
    var balanceValue: String = ""
    
    var receiveElement: ItemListCreditCard?
    
    var currentTest = Test()
    var filterArray : [TestEvents] = []
    
    private let realm = try! Realm()
    
    @IBOutlet weak var creditCardLabel: UILabel!
    @IBOutlet weak var viewDropDown: StyleUIView!
    
    @IBOutlet weak var nameCreditCardTextLabel: UILabel!
    @IBOutlet weak var numberCreditCardTextLabel: UILabel!
    @IBOutlet weak var dateCreditCardTextLabel: UILabel!
    
    @IBOutlet weak var balanceTextLabel: UITextField!
    
    @IBOutlet weak var balanceCreditCardTextLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Edit Credit Card"
        
        SetupDropDown()
    
        currentTest.statEvents = [
            TestEvents(name: "Visa", num: "3711 803032 57522", code: "123" , date: "11/25"),
            TestEvents(name: "Mastercard", num: "4509 9535 6623 3704", code: "123" , date: "11/25"),
            TestEvents(name: "American Express", num: "5031 7557 3453 0604", code: "1234" , date: "11/25")
        ]
        
        ReceiveElementLoadData()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(self.SaveDataButton))
    }

    @objc func SaveDataButton() {
        if creditCardLabel.text != "Select a Credit Card" {
//            realm.beginWrite()
//            let newCard = ItemListCreditCard()
//            newCard.creditName = filterArray.first?.name ?? "name"
//            newCard.creditNumber = filterArray.first?.num ?? "0"
//            newCard.creditDate = filterArray.first?.date ?? "--/--"
//            newCard.creditCVV = filterArray.first?.code ?? "000"
//            newCard.creditBalance = Int(balanceValue) ?? 0
//            realm.add(newCard)
//
//            try! realm.commitWrite()
            
            do {
                try realm.write({
                    receiveElement?.creditName = filterArray.first?.name ?? "name"
                    receiveElement?.creditNumber = filterArray.first?.num ?? "0"
                    receiveElement?.creditDate = filterArray.first?.date ?? "--/--"
                    receiveElement?.creditCVV = filterArray.first?.code ?? "000"
                    receiveElement?.creditBalance = Float(balanceValue) ?? 0.0
                    
                    
                })
            } catch {
                print(error.localizedDescription)
            }
            
            
            navigationController?.popToRootViewController(animated: true)
        } else {
            let alert = UIAlertController(title: "Error", message: "Complete the data to continue", preferredStyle: .alert)
            let actionOk = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(actionOk)
            present(alert, animated: true, completion: nil)

        }
    }
    
    
    @IBAction func selectCardButtonAction(_ sender: Any) {
        dropDown.show()
    }
    
    
    private func SetupDropDown() {
        creditCardLabel.text = "Select a Credit Card"
        dropDown.anchorView = viewDropDown
        dropDown.dataSource = creditCards
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.topOffset = CGPoint(x: 0, y:-(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.direction = .bottom
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.creditCardLabel.text = creditCards[index]
            
            if creditCardLabel.text == "Select a Credit Card" {
                print("Prueba boton")
            }
        }
    }
    
    @IBAction func ViewInfoButtonAction(_ sender: Any) {
        if creditCardLabel.text != "Select a Credit Card" {
     
            switch creditCardLabel.text {
            case "Visa":
                filterArray = currentTest.statEvents.filter({ $0.num.hasPrefix("3")})
                LoadData()

            case "Mastercard":
                filterArray = currentTest.statEvents.filter({ $0.num.hasPrefix("4")})
                LoadData()
                
            case "American Express":
                filterArray = currentTest.statEvents.filter({ $0.num.hasPrefix("5")})
                LoadData()
                
            default:
                print("default")
                
            }
        } else {
            let alerta = UIAlertController(title: "Error", message: "Select a Credit Card to continue", preferredStyle: .alert)
            let accionAceptar = UIAlertAction(title: "OK", style: .default, handler: nil)
            alerta.addAction(accionAceptar)
            present(alerta, animated: true, completion: nil)
        }
    }
    
    private func LoadData() {
        if nameCreditCardTextLabel.text != nil && numberCreditCardTextLabel.text != nil, let balanceData = balanceTextLabel.text, !balanceData.isEmpty{
            nameCreditCardTextLabel.text = filterArray.first?.name
            numberCreditCardTextLabel.text = filterArray.first?.num
            dateCreditCardTextLabel.text = ("Valid: \(String(describing: filterArray.first?.date ?? "--/--")) - Code: \(String(describing: filterArray.first?.code ?? "000"))")

            balanceCreditCardTextLabel.text = balanceData
            
             
            balanceValue = balanceData
            print("Value", balanceValue)
        } else {
            let alert = UIAlertController(title: "Error", message: "Adds a balance value", preferredStyle: .alert)
            let actionOk = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(actionOk)
            present(alert, animated: true, completion: nil)
//            print("No data")
        }
    }

    private func ReceiveElementLoadData() {
        if nameCreditCardTextLabel.text != nil && numberCreditCardTextLabel.text != nil {
            nameCreditCardTextLabel.text = receiveElement?.creditName
            numberCreditCardTextLabel.text = receiveElement?.creditNumber
            dateCreditCardTextLabel.text = ("Valid: \(String(describing: receiveElement?.creditDate ?? "--/--")) - Code: \(String(describing: receiveElement?.creditCVV ?? "000"))")
//            balanceValue = ("\(receiveElement?.creditBalance ?? 0000)")
            balanceCreditCardTextLabel.text = ("\(String(describing: receiveElement?.creditBalance ?? 0000))")
            
//
        } else {
            print("No data")
        }
    }

}
