//
//  WineModel.swift
//  Prototype-ML
//
//  Created by 이동규 on 2021/11/21.
//

import Foundation

/*
"id": 1591326,
"name": "Tawny Port",
"rating": "3.8",
"price": "30000",
"currency": "won",
"country": "Portgual",
"region": "Porto",
"winery": "Fonseca",
"image": {
  "wine_bottle": "https://images.vivino.com/thumbs/DHB93n50RnyjsLMEfprPUQ_pb_x600.png",
  "country_flag": "https://images-counties-flag.s3.ap-northeast-2.amazonaws.com/png100px/pt.png"
*/
    
typealias WineCellImageDict = Dictionary<String, String>
    
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

class WineModel {
    
    var wineCellList = [WineCell]()
    
    // MARK: 서버API 에서 로딩
    func loadFromAPI() {
        SearchWineAPIManager()
    }
    
    //+
}
