//
//  WineModel2.swift
//  Prototype-UI
//
//  Created by 이동규 on 2021/11/21.
//

import Foundation
import UIKit

//MARK: 와인 셀 정보관련
typealias WineCellImageDict = Dictionary<String, String>    //wine_bottle, country_flag
typealias WineDetailDict = Dictionary<String, String>

struct WineCell: Codable {
    var id: Int64
    var name: String
    var price: String
    var currency: String
    var country: String
    var region: String
    var winery: String
    var image: WineCellImageDict
}

struct wineCellList: Codable {
    var search: [WineCell]
}

//MARK: 와인 디테일 정보 관련
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
    var rating: String
    var price: String
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

class WineModel2 {
    
    // MARK: 서버API 에서 로딩
    func loadFromAPI(_ completion: @escaping ([WineCell]?) -> ()) {
        SearchWineAPIManager().loadWineList() { data, error in
            if let error = error {
                print(#function, error.localizedDescription)
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(wineCellList.self, from: data)
                    let theList = result.search
                    //Use `theList` here
                    //print("heloo hererer", theList)
                    DispatchQueue.main.async {
                        completion(theList)
                    }
                    //...
                } catch {
                    print("error")
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    
    // MARK: 서버API 에서 로딩
    func loadDetailFromAPI(wineID: Int64, completion: @escaping (WineDetail?) -> ()) {
        SearchWineAPIManager().loadWineDetail(id: wineID) { data, error in
            if let error = error {
                print(#function, error.localizedDescription)
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(WineDetail.self, from: data)
                    completion(result)
                } catch {
                    print(error.localizedDescription)
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    
    //+
}
