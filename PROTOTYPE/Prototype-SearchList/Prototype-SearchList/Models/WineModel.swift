//
//  WineModel.swift
//  Prototype-SearchList
//
//  Created by 이동규 on 2021/10/26.
//

/* 예시
 "id": 2,
 "importer": "레드와인앤제이와이",
 "nameKor": "그라티엔 메이어 끌레망 드 루아르 브뤼",
 "nameEng": "GRATIEN ET MEYER CREMANT DE LOIRE BRUT",
 "producer": "GRATIEN MEYER",
 "importDate": "2021-09-13",
 "manufactureCountry": "프랑스",
 "exportCountry": "프랑스"
*/
// 와인 설명 데이터 필요


import Foundation
import UIKit

struct Wine: Codable {
    var id: Int64
    var importer: String
    var nameKor: String
    var nameEng: String
    var producer: String
    var importDate: String
    var manufactureCountry: String
    var exportCountry: String
}

class WineModel {
    
    var wineList = [Wine]()
    
    func loadFromJson() {
        guard let wineDataFromJson = NSDataAsset(name: "ImportWine") else {
            return
        }
        self.wineList = try! JSONDecoder().decode([Wine].self, from: wineDataFromJson.data)
        //print("Success", self.wineList[0].importer)
    }
}
