//
//  LoginViewController.swift
//  WalletChallenge
//
//  Created by Ivan Valero on 01/08/2022.
//

import UIKit
import FirebaseAuth
import RealmSwift

class LoginViewController: UIViewController {
    
   
    private var realm = try! Realm()
    var nameUserFull: String = "FullUserName"
    var observer: NSObjectProtocol?

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var singupButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Wallet"

    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkUserInfo()
    }
    
    func checkUserInfo() {
        if Auth.auth().currentUser != nil {
            print(Auth.auth().currentUser?.uid)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "home")
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: false)
        }
    }
    
    @IBAction func singupButtonAction(_ sender: Any) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if let result = result, error == nil {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "home")
                    vc.modalPresentationStyle = .overFullScreen
                    self.present(vc, animated: true)
                    
                    
                    self.realm.beginWrite()
                    self.realm.deleteAll()

                    do {
                        try self.realm.commitWrite()
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                
                    
                } else {
                    let alertController = UIAlertController(title: "Error", message: "An unexpected error occurred. Please try again", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if let result = result, error == nil {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "home")
                    vc.modalPresentationStyle = .overFullScreen
                    self.present(vc, animated: true, completion: nil)
                } else {
                    let alertController = UIAlertController(title: "Error", message: "An unexpected error occurred. Please try logging in again.", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alertController, animated: true)
                }
                self.checkUserInfo()
            }
        }
    }
    
}
