//
//  ContentView.swift
//  worldclock-cheatsheet WatchKit Extension
//
//  Created by Vladimir Malinovskiy on 18.11.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State var isShowingSettings: Bool = false
    @State var isShowingSearch: Bool = false
    @StateObject var parser: JSONParser = JSONParser(packURL: URL(string: "https://cheatsheet-worldclock.api.vapronva.pw/get?key=bruh&author=thispilot")!)
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    SingleWatchTimeMainScreen(cityName: "Омск", minusHowManyHours: 0)
                        .cornerRadius(12.0)
                        .padding(.horizontal, 3)
                        .padding(.vertical, 1)
                        .onTapGesture(count: 3, perform: {
                            self.isShowingSettings = true
                        })
                    SingleWatchTimeMainScreen(cityName: "МТеч", minusHowManyHours: -3)
                        .cornerRadius(12.0)
                        .padding(.horizontal, 3)
                        .padding(.vertical, 1)
                    SingleWatchTimeMainScreen(cityName: "Сосан", minusHowManyHours: -9)
                        .cornerRadius(12.0)
                        .padding(.horizontal, 3)
                        .padding(.vertical, 1)
                        .onTapGesture(count: 3, perform: {
                            self.isShowingSearch = true
                        })
                    SingleWatchTimeMainScreen(cityName: "Bruh", minusHowManyHours: 5)
                        .cornerRadius(12.0)
                        .padding(.horizontal, 3)
                        .padding(.vertical, 1)
                    SingleWatchTimeMainScreen(cityName: "Омск", minusHowManyHours: 0)
                        .cornerRadius(12.0)
                        .padding(.horizontal, 3)
                        .padding(.vertical, 1)
                    
                }
            }.navigationBarTitle(Text("Мировое время"))
                .navigationBarTitleDisplayMode(.inline)
                .sheet(isPresented: $isShowingSettings) {
                    PackInfoSettings(pack: parser.getInformation(), parser: parser, isShowingSettings: $isShowingSettings)
                }
                .sheet(isPresented: $isShowingSearch) {
                    ArticlesSearchView(pack: parser.getInformation())
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
