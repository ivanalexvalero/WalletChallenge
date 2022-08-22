//
//  VC1.swift
//  BasicTwo
//
//  Created by Ivan Valero on 29/07/2022.
//

import UIKit
import RealmSwift



class HomeViewController: UIViewController {
    

    private var realm = try! Realm()
    private var itemList = [ItemListCreditCard]()
    var editElement: ItemListCreditCard?
    var nameUserFull: String = "FullUserName"
    var observer: NSObjectProtocol?
    private let kMyKey = "MyKey"
   
    
    @IBOutlet weak var balanceTextLabel: UILabel!
    
    @IBOutlet weak var cardsTableView: UITableView!
    @IBOutlet weak var fullUserNameTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configTableView()
        readNewData()
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.tapFunc))
        fullUserNameTextLabel.isUserInteractionEnabled = true
        fullUserNameTextLabel.addGestureRecognizer(tap)
        
    }

        
        @objc func tapFunc() {
            let vc = UserViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    
    
    override func viewWillAppear(_ animated: Bool) {
        readNewData()
        balanceSum()
        cardsTableView.reloadData()
        print("Call", balanceSum())
        
        if let valueUser = UserDefaults.standard.string(forKey: self.kMyKey) {
            fullUserNameTextLabel.text = valueUser
            print("ValueUser", valueUser)
        } else {
            print("No hay nombre")
        }
        
        observer = NotificationCenter.default.addObserver(forName: Notification.Name("FullNameUserSend"), object: nil, queue: .main, using: { notification in
            
            guard let object = notification.object as? String else { return }
            self.fullUserNameTextLabel.text = object
            
            let userDefaults = UserDefaults.standard
            userDefaults.value(forKey: self.kMyKey)
            userDefaults.synchronize()
            
            print("Default: ", userDefaults)
        })
        
    }
    
   
    
    func balanceSum() {
        let sumBalance = itemList.map( { $0.creditBalance} ).reduce(0, +)
        balanceTextLabel.text = ("$ \(Float(sumBalance))")
        print("Result: ", sumBalance)
    }
    
    func readNewData() {
        itemList = realm.objects(ItemListCreditCard.self).map({ $0 })
    }

    func configTableView() {
        cardsTableView.delegate = self
        cardsTableView.dataSource = self
        cardsTableView.register(UINib(nibName: CreditCardViewCell.kId, bundle: nil), forCellReuseIdentifier: CreditCardViewCell.kId)
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = cardsTableView.dequeueReusableCell(withIdentifier: CreditCardViewCell.kId, for: indexPath) as? CreditCardViewCell
        cell?.configCell(model: itemList[indexPath.row])
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cardsTableView.deselectRow(at: indexPath, animated: true)
        editElement = itemList[indexPath.row]
        
        let vc = EditCreditCardViewController()
        vc.receiveElement = editElement
        navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "Delete", handler: { [self]_,_,_ in
            
            if let deleteElement = itemList[indexPath.row] as? ItemListCreditCard {
                
                self.realm.beginWrite()
                self.realm.delete(deleteElement)
                
                do {
                    try self.realm.commitWrite()
                } catch {
                    print(error.localizedDescription)
                }
                self.itemList.remove(at: indexPath.row)
                self.cardsTableView.reloadData()
                balanceSum()
            }
            
            print("delete")
        })
        
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
}

//extension HomeViewController: UserProtocol {
//    func UserFullName(_ userName: String) {
//        fullUserNameTextLabel.text = userName
//    }
//
//
//}
