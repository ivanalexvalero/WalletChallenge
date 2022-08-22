//
//  UserViewController.swift
//  WalletChallenge
//
//  Created by Ivan Valero on 12/08/2022.
//

import UIKit


class UserViewController: UIViewController {

    
    private let kMyKey = "MyKey"
    
    private var userNameFull: String = ""
    
    @IBOutlet weak var nameTextLabel: UITextField!
    @IBOutlet weak var lastnameTextLabel: UITextField!
    @IBOutlet weak var userNameTextLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "User"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(self.SaveDataButton))
    }

    
    @objc func SaveDataButton() {

        
        let userDefaults = UserDefaults.standard
        userDefaults.set(userNameFull, forKey: kMyKey)
        userDefaults.synchronize()
        
        NotificationCenter.default.post(name: Notification.Name("FullNameUserSend"), object: userNameFull)
        navigationController?.popToRootViewController(animated: true)
    }

    

    @IBAction func ViewInfoButtonAction(_ sender: Any) {
        
        if let nameUser = nameTextLabel.text, !nameUser.isEmpty, let lastnameUser = lastnameTextLabel.text, !lastnameUser.isEmpty {
            userNameTextLabel.text = "User: " + nameUser + " " + lastnameUser
            userNameFull = nameUser + " " + lastnameUser
        }
    }
    

}
