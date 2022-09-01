//
//  NewsModel.swift
//  JanDanSwift
//
//  Created by huangyuan on 2022/9/1.
//

import UIKit

struct NewsListDetailModel: Codable {
    var status: String
    var count: Int
    var count_total: Int
    var pages: Int
    var posts: [NewsItem]
}

struct NewsItem: Codable {
    var id: Int
    var url: String
    var title: String
    var excerpt: String
    var date: String
    var comment_count: Int
    var comment_status: String
    var author: NewsAuthor
    var custom_fields: NewsCustomFields
}

struct NewsAuthor: Codable {
    var id: Int
    var name: String
}

struct NewsCustomFields: Codable {
    var thumb_c: [String]
}
