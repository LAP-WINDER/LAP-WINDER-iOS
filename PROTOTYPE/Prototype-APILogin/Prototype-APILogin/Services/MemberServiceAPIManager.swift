//
//  MemberServiceAPIManager.swift
//  Prototype-APILogin
//
//  Created by 이동규 on 2021/11/10.
//

import Foundation



class MemberServiceAPIManager {

    let urlCollections: Dictionary<String, String> = [
        "login" : "https://winder.info/api/v1/members/login",
        "validEmail" : "https://winder.info/api/v1/members/email",
        "enroll" : "https://winder.info/api/v1/members",
        "userInfo" : "https://winder.info/api/v1/members",
        "pushKakaoToken": "https://winder.info/api/v1/members/sns",
    ]
    
    // 로그인
    func isValidUser(_ user: User, completion: @escaping (String?, Error?)->()) {
        var request = URLRequest(url: URL(string: self.urlCollections["login"]!)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(user)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                NSLog(error.localizedDescription)
                completion(nil, error)
            } else if let data = data {
                print("data: \(data)")
                let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
                let jsonObjData = jsonData?["data"] as? NSDictionary
                if let jsonKeyData = jsonObjData?["accessToken"] as? String {
                    print("jsonKeyData: \(jsonKeyData)")
                    DispatchQueue.main.async {
                        completion(jsonKeyData, nil)
                    }
                } else {
                    //print("response: \(response)")
                    NSLog("wrong ID")
                    completion(nil, nil)
                }
            }
        }.resume()
    }
    
    
    // 자체 회원가입(이에일 인증 -> 인증번호 리턴)
    func isValidEmail(_ email: ValidEmail, completion: @escaping (String?, Error?)->()) {
        var request = URLRequest(url: URL(string: self.urlCollections["validEmail"]!)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(email)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                NSLog(error.localizedDescription)
                completion(nil, error)
            } else if let data = data {
                let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
                let jsonObjData = jsonData?["data"] as? NSDictionary
                if let jsonKeyData = jsonObjData?["authCode"] as? String {
                    print("jsonKeyData: \(jsonKeyData)")
                    DispatchQueue.main.async {
                        completion(jsonKeyData, nil)
                    }
                } else {
                    print("response: \(response)")
                    NSLog("wrong Email")
                    completion(nil, nil)
                }
            }
        }.resume()
    }
    
    // 자체 회원가입(이메일/패스워드 전달, 받은 토큰 저장)
    func Enroll(_ info: User, completion: @escaping (String?, Error?)->()) {
        var request = URLRequest(url: URL(string: self.urlCollections["enroll"]!)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(info)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                NSLog(error.localizedDescription)
                completion(nil, error)
            } else if let data = data {
                let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
                let jsonObjData = jsonData?["data"] as? NSDictionary
                // 여기부터 중요
                if let jsonKeyData = jsonObjData?["accessToken"] as? String {
                    print("jsonKeyData: \(jsonKeyData)")
                    DispatchQueue.main.async {
                        completion(jsonKeyData, nil)
                    }
                } else {
                    NSLog("Something Wrong")
                    completion(nil, nil)
                }
            }
        }.resume()
    }
    
    func requestUserInfo() {
        var request = URLRequest(url: URL(string: self.urlCollections["userInfo"]!)!)
        request.httpMethod = "GET"
        //--임시토큰
        let tokenStr = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNjM2NTQyNDE5LCJleHAiOjE2MzY1NDYwMTl9.9X1nnfDEgGDtj107M5l5dWi6nOGgGIazv4dwor3drQ0"
        request.setValue("Bearer \(tokenStr)", forHTTPHeaderField: "Authorization")
        //--끝
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
                print(jsonData)
            }
        }.resume()
    }
    
    // 서버에 카카오톡 토큰 전달
    func pushTokenFromKakaoLogin(_ info: TokenInfo) {
        var request = URLRequest(url: URL(string: self.urlCollections["pushKakaoToken"]!)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(info)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                print("Push kakako token and returned data \(data)")
                print("response is: \(response)")
            }
        }.resume()
    }
    
    //+
}
