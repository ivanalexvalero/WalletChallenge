//
//  QRCodeViewController.swift
//  WalletChallenge
//
//  Created by Ivan Valero on 22/08/2022.
//

import UIKit

class QRCodeViewController: UIViewController {
    
    var qrCode: QRCode?

    @IBOutlet weak var qrCodeImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        SetupImage()
    }

    func SetupImage() {
        qrCodeImage
    }

}
