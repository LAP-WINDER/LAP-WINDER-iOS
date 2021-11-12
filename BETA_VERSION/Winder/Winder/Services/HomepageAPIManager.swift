//
//  HomepageAPIManager.swift
//  Winder
//
//  Created by 이동규 on 2021/11/12.
//

import Foundation

// 홈페이지 뷰의 서버 리퀘스트 관련 뷰모델 정리
class HomepageAPIManager {
    let URLCollections = [
        "homepageContents" : ""
    ]

    func requestContentsInfo(_ info: HomeContentInfo, completion: @escaping (NSDictionary?, Error?)->()) {
        var request = URLRequest(url: URL(string: self.URLCollections["homepageContents"]!)!)
        request.httpMethod = "GET"
        //request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.httpBody = try? JSONEncoder().encode(info)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                NSLog(error.localizedDescription)
                completion(nil, error)
            } else if let data = data {
                print("data: \(data)")
                let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
                if let jsonObjData = jsonData?["data"] as? NSDictionary {
                    print("jsonObjData: \(jsonObjData)")
                    DispatchQueue.main.async {
                        completion(jsonObjData, nil)
                    }
                } else {
                    //print("response: \(response)")
                    NSLog("Wrong request")
                    completion(nil, nil)
                }
            }
        }.resume()
    }
    
    //+
}
