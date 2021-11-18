//
//  JSONParser.swift
//  worldclock-cheatsheet WatchKit Extension
//
//  Created by Vladimir Malinovskiy on 18.11.2021.
//

import Foundation

let JSONINFODATATEST = """
{
    "packInfo": {
        "name": "Декабрьское сочинение",
        "author": "ThisPilot",
        "version": "0.2",
        "lastUpdated": 1637232267
    },
    "content": [
        {
            "id": "38d3ab94-89e4-4a89-b884-e870b5c90d73",
            "title": "Согласны ли вы, что жизненный путь-постоянный выбор?",
            "text": "Жизненный путь-это дорога, по которой человек идет всю свою жизнь. Каждый день человек выбирает новый поворот, который решает его судьбу, так как даже самое простое решение может отразиться на его будущем. Выбор жизненного пути лежит целиком и полностью в руках человека, и он чертит свой путь как карту, составленную из его выборов и действий.",
            "externalimages": []
        }
    ]
}
"""


struct MainAllPackJSON: Decodable {
    
    struct ContentSingletonJSON: Decodable {
        var id: UUID = UUID()
        var title: String
        var text: String
        var externalimages: Array<ExternalImagesJSON>
    }
    
    struct ExternalImagesJSON: Decodable {
        var name: String
        var url: String
    }
    
    struct PackInfoJSON: Decodable {
        var name: String
        var author: String
        var version: String
        var lastUpdated: Int
        
        func getUpdatedDate() -> String {
            return String(self.lastUpdated)
        }
    }
    
    var packInfo: PackInfoJSON
    var content: Array<ContentSingletonJSON>
}


class JSONParser: ObservableObject {
    
//    let fileLocationURL: URL = URL()
    @Published var remoteVersion: String = "Pending..."
    var packURL: URL
    
    init(packURL: URL) {
        self.packURL = packURL
    }
    
    func getInformation() -> MainAllPackJSON {
        let jsonData = JSONINFODATATEST.data(using: .utf8)!
        let allContents: MainAllPackJSON = try! JSONDecoder().decode(MainAllPackJSON.self, from: jsonData)
        return allContents
    }
    
    func getRemoteVersion() {
        self.remoteVersion = "BRUHHH"
    }
}
