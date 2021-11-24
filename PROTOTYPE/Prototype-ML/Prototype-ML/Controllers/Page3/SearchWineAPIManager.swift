//
//  SearchWineAPIManager.swift
//  Prototype-ML
//
//  Created by 이동규 on 2021/11/21.
//

import Foundation

class SearchWineAPIManager {
    
    private let urlCollections = [
        "setSearchList": "https://076377ce-e57e-4e02-9010-348b5c4be96d.mock.pstmn.io/api/v1/wine/search"
    ]
    
    // MARK: 와인 셀 데이터 요청, 검색화면 초기 입장
    func setList(completion: @escaping () -> ()) {
        var request = URLRequest(url: URL(string: self.urlCollections["setSearchList"]!)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(#function, error.localizedDescription)
            } else if let data = data {
                let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
                print(jsonData, type(of: jsonData))
            }
        }.resume()
    }

    //+
}
