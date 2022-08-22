//
//  VC2.swift
//  BasicTwo
//
//  Created by Ivan Valero on 29/07/2022.
//

import UIKit
import DropDown

class VC2: UIViewController {
    
   
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var viewDropDown: StyleUIView!
    @IBOutlet weak var creditCardLabel: UILabel!
    
    @IBOutlet weak var cardNamePres: UILabel!
    @IBOutlet weak var cardNumberPres: UILabel!
    @IBOutlet weak var cardDatePres: UILabel!
    @IBOutlet weak var cardUserNamePres: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    
    let dropDown = DropDown()
    let creditCards = ["Mastercard", "Visa", "American Express"]
    var numbersCard = ["5031 7557 3453 0604", "3711 803032 57522", "4509 9535 6623 3704"]
    var valueList: [String] = []
    
    
    private var cardUserName: String = ""
    private var creditCardName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

       SetupDropDown()

    }
    
    init(cardUserName: String, creditCardName: String) {
        super.init(nibName: nil, bundle: nil)
        self.cardUserName = cardUserName
        self.creditCardName = creditCardName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    @IBAction func selectCardButtonAction(_ sender: Any) {
        dropDown.show()
    }
    @IBAction func saveButtonAction(_ sender: Any) {
        
        
        PresentationData()
        
        
    
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
//            if item == "Visa" {
//                print("test")
//                let cardItem: String = item
//                cardNamePres.text = cardItem
//                cardDatePres.text = "11/25"
//
//            }
//
//            switch item {
//            case "Visa":
//                print("test")
//                let cardItem: String = item
//                cardNamePres.text = cardItem
//                cardDatePres.text = "11/25"
//            default:
//                print("defaul")
//            }
        }
    }
    
    
    private func PresentationData() {
//        let nameUser: String = nameTextField.text ?? "Name"
//        let lastnameUser: String = lastnameTextField.text ?? "Lastname"
//        cardUserNamePres.text = ("\(lastnameUser), \(nameUser)")
        if let nameUser = nameTextField.text, nameUser.isEmpty == false, let lastnameUser = lastnameTextField.text, lastnameUser.isEmpty == false {
            
            cardUserNamePres.text = ("\(lastnameUser), \(nameUser)")
            valueList.append(nameUser)
            ShowData(items: nameUser)
        }
        
//        let vc = HomeViewController(cardUserName: "\(cardUserNamePres.text)", creditCardName: "\(creditCardLabel.text)")
//        present(vc, animated: true)
        
        switch creditCardLabel.text {
        case "Visa":
            print("test")
            cardNamePres.text = "Visa"
            cardDatePres.text = "Valid from: 11/25 - CVV: 123"
            numbersCard = numbersCard.filter({ $0.hasPrefix("4")})
            let joinedArray = numbersCard.joined(separator: "")
            print("El numero es: ", joinedArray)
            cardNumberPres.text = "\(joinedArray)"
     
            // guardar info de tarjetas encriptada en base de datos interna del celu
            // saldo de la tarjeta para sumar en el home
            // agregar fila en tableview al presionar boton save
            
        case "Mastercard":
            print("test2")
            cardNamePres.text = "Mastercard"
            cardDatePres.text = "Valid from: 11/25 - CVV: 123"
        case "American Express":
            print("test2")
            cardNamePres.text = "American Express"
            cardDatePres.text = "Valid from: 11/25 - CVV: 1234"
        default:
            print("defaul")
        }
    }
    
    
    func ShowData(items: String) {
        
        for items in valueList {
            print("Lista: ", items)
        }
    }
}
