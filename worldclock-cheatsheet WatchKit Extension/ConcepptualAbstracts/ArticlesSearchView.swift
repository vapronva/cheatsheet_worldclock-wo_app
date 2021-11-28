//
//  ArticlesSearchView.swift
//  worldclock-cheatsheet WatchKit Extension
//
//  Created by Vladimir Malinovskiy on 19.11.2021.
//

import SwiftUI

struct ArticlesSearchView: View {
    
    @Environment(\.dismissSearch) var dismissSearch
    @Environment(\.isSearching) var isSearching
    var pack: MainAllPackJSON
    @State private var textSearch: String = ""
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(pack.content, id: \.id) { value in
                    NavigationLink(value.title, destination: SingleArticleExtensiveView(titleArticle: value.title, textArticle: value.text))
//                        .searchable(text: $textSearch, prompt: Text("Поиск"))
                }
            }
                .navigationBarTitle(Text(pack.packInfo.name))
//              .navigationBarTitleDisplayMode(.automatic)
        }
        .searchable(text: $textSearch, prompt: Text("Поиск"))
    }
}

struct ArticlesSearchView_Previews: PreviewProvider {
    static let parser: JSONParser = JSONParser(packURL: URL(string: "https://cheatsheet-worldclock.api.vapronva.pw/get?key=bruh&author=thispilot")!)
    static var previews: some View {
        ArticlesSearchView(pack: parser.getInformation())
    }
}
