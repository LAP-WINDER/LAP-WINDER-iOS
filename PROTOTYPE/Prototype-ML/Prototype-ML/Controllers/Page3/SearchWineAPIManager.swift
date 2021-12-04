//
//  SearchWineAPIManager.swift
//  Prototype-ML
//
//  Created by 이동규 on 2021/11/21.
//

import Foundation

//MARK: 와인 셀 정보관련
typealias WineCellImageDict = Dictionary<String, String>    //wine_bottle, country_flag
    
struct WineCell: Codable {
    var id: Int64
    var name: String
    var rating: String
    var price: String
    var currency: String
    var country: String
    var region: String
    var winery: String
    var image: WineCellImageDict
}

struct WineCellList: Codable {
    var search: [WineCell]
}

//MARK: 와인 디테일 정보 관련
typealias WineDetailDict = Dictionary<String, String>

struct WineDetailInfo: Codable {
    var id: Int64
    var name: String
    var name_kr: String
    var description: String
}

struct WineDetail: Codable {
    var id: Int64
    var name: String
    var name_kr: String
    var rating: Double
    var price: Int64
    var currency: String
    var description: String
    var characters: WineDetailDict
    var wine_type: WineDetailInfo
    var country: WineDetailInfo
    var region: WineDetailInfo
    var winery: WineDetailInfo
    var wine_style: WineDetailInfo
    var grapes: [WineDetailInfo]
    var images: WineCellImageDict
}

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
    
  
}
