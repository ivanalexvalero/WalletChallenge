//
//  MainViewController.swift
//  BasicTwo
//
//  Created by Ivan Valero on 29/07/2022.
//

import UIKit
import FirebaseAuth

class MainViewController: UIViewController {
    
    private let kMyKey = "MyKey"
    
    var rootPageViewController: RootPageViewController!
    @IBOutlet weak var newCreditCardButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Wallet"
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? RootPageViewController {
            destination.delegateRoot = self
            rootPageViewController = destination
        }
    }
    
    @IBAction func newCreditCardButtonAction(_ sender: Any) {
        let vc = NewCreditCardViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func userButtonAction(_ sender: Any) {
        let vc = UserViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func qrcodeButtonAction(_ sender: Any) {
        let vc = QRCodeViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func logoutButtonAction(_ sender: Any) {
        let buttonAlert = UIAlertController(title: "Logout", message: "Do you want to log out?", preferredStyle: UIAlertController.Style.alert)
        buttonAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction) in
            do {
                try Auth.auth().signOut()
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "login")
                self.present(vc, animated: true)
                
                let userDefaults = UserDefaults.standard
                userDefaults.removeObject(forKey: self.kMyKey)
                userDefaults.synchronize()
                
            } catch {
                print(error)
            }
        }))
        buttonAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction) in
            print("log out to app")
        }))
        present(buttonAlert, animated: true)
   
    }
    
}

extension MainViewController: RootPageProtocol {
    func currentPage(_ index: Int) {
        print("Current page: ", index)
    }
}
