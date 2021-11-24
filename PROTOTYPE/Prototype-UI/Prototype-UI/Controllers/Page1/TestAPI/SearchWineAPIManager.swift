//
//  SearchWineAPIManager.swift
//  Prototype-UI
//
//  Created by 이동규 on 2021/11/21.
//

import Foundation

class SearchWineAPIManager {
    
    private let urlCollections = [
        "setSearchList": "https://076377ce-e57e-4e02-9010-348b5c4be96d.mock.pstmn.io/api/v1/wine/search",
        "setWineDetail": "https://076377ce-e57e-4e02-9010-348b5c4be96d.mock.pstmn.io/api/v1/wine/details?wine_ids=" // id 뒤에 +로 붙이기
    ]
    
    // MARK: 와인 셀 데이터 요청, 검색화면 초기 입장
    func loadWineList(completion: @escaping (Data?, Error?) -> ()) {
        var request = URLRequest(url: URL(string: self.urlCollections["setSearchList"]!)!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(#function, error.localizedDescription)
                completion(nil, error)
            } else if let data = data {
                completion(data, nil)
            }
        }.resume()
    }
    
    func loadWineDetail(id: Int64, completion: @escaping (Data?, Error?) -> ()) {
        let urlStr = self.urlCollections["setWineDetail"]! + String(id)
        print(urlStr)
        var request = URLRequest(url: URL(string: urlStr)!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(#function, error.localizedDescription)
                completion(nil, error)
            } else if let data = data {
                //print(response)
                completion(data, nil)
            }
        }.resume()
    }

    //+
}
