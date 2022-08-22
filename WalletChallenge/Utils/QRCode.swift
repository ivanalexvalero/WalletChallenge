//
//  QRCode.swift
//  WalletChallenge
//
//  Created by Ivan Valero on 18/08/2022.
//

import Foundation
import UIKit


struct QRCode: Decodable {
    let contentImg: String
}

func callApi() {
    
//    var testValue: String = ""
//    var fullList: [QRCode] = []
//    var imagePNG: UIImage
    
    let headers = [
        "content-type": "application/x-www-form-urlencoded",
        "X-RapidAPI-Key": "be2fd8cfd2mshe450d9b739d9d82p11aa7ajsn62b50f2ac725",
        "X-RapidAPI-Host": "neutrinoapi-qr-code.p.rapidapi.com"
    ]

    let postData = NSMutableData(data: "content=name".data(using: String.Encoding.utf8)!)
    postData.append("&width=128".data(using: String.Encoding.utf8)!)
    postData.append("&height=128".data(using: String.Encoding.utf8)!)
    postData.append("&fg-color=#000000".data(using: String.Encoding.utf8)!)
    postData.append("&bg-color=#ffffff".data(using: String.Encoding.utf8)!)
    
    
    let request = NSMutableURLRequest(url: NSURL(string: "https://neutrinoapi-qr-code.p.rapidapi.com/qr-code")! as URL,
                                            cachePolicy: .useProtocolCachePolicy,
                                        timeoutInterval: 10.0)
    request.httpMethod = "POST"
    request.allHTTPHeaderFields = headers
    request.httpBody = postData as Data
    let imageP = UIImage(data: request.httpBody!)
    print("image", imageP)
    
    let session = URLSession.shared
    let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
        
//        guard let json = data else { return }
//
//        print("Data", json)
//
        if (error != nil) {
            print("Error CallApi", error)
        } else {
            let httpResponse = response as? HTTPURLResponse
            print("CallApi",httpResponse)
            
        }
    })

    dataTask.resume()
}
