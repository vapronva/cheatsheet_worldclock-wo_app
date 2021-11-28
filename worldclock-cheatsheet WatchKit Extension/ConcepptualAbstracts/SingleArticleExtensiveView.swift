//
//  SingleArticleExtensiveView.swift
//  worldclock-cheatsheet WatchKit Extension
//
//  Created by Vladimir Malinovskiy on 19.11.2021.
//

import SwiftUI

struct SingleArticleExtensiveView: View {
    
    var titleArticle: String
    var textArticle: String
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                Text(textArticle)
                    .font(Font.system(.caption).weight(.regular))
                    .multilineTextAlignment(.leading)
            }.navigationBarTitle(titleArticle).navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct SingleArticleExtensiveView_Previews: PreviewProvider {
    static var previews: some View {
        SingleArticleExtensiveView(titleArticle: "Testing Cum", textArticle: "BRUH BRUH BRUH TEST TEST BRUH BRUH BRUH TEST TEST BRUH BRUH BRUH TEST TEST BRUH BRUH BRUH TEST TEST v BRUH BRUH BRUH TEST TEST BRUH BRUH BRUH TEST TEST BRUH BRUH BRUH TEST TEST BRUH BRUH BRUH TEST TEST BRUH BRUH BRUH TEST TEST BRUH BRUH BRUH TEST TEST BRUH BRUH BRUH TEST TEST BRUH BRUH BRUH TEST TEST ")
    }
}
