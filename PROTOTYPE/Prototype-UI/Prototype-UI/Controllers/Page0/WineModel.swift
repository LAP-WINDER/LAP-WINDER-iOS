//
//  WineModel.swift
//  Prototype-UI
//
//  Created by 이동규 on 2021/11/15.
//

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
