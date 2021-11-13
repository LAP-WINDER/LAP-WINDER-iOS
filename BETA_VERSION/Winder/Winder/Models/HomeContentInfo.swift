//
//  HomeContentInfo.swift
//  Winder
//
//  Created by 이동규 on 2021/11/12.
//

import Foundation

enum ContentsCase {
    case news
    case recommend
    case blog
    case info
}

struct HomeContentInfo {
    var label: ContentsCase     //컨텐츠 라벨링(recommend, news, blog, info)
    var page: Int               // 컨텐츠 페이지
}
