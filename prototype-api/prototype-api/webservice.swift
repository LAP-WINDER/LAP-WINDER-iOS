//
//  webservice.swift
//  prototype-api
//
//  Created by 이동규 on 2021/10/25.
//

import Foundation

class webservice {
    
    let url = URL(string: "https://winder.info/api/v1/login")!
    
    func isValidUser(_ user: User) -> Bool {
        var result: Bool = false
        var request = URLRequest(url: self.url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(user)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                NSLog(error.localizedDescription)
            } else if let data = data {
                let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
                if jsonData?["token"] as? String != nil {
                    DispatchQueue.main.async {
                        print("herere")
                        result = true
                    }
                } else {
                    NSLog("wrong ID")
                }
            }
        }.resume()
        return result
    }


}

