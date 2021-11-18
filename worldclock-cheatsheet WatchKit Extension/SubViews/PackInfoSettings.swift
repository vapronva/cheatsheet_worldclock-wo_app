//
//  PackInfoSettings.swift
//  worldclock-cheatsheet WatchKit Extension
//
//  Created by Vladimir Malinovskiy on 18.11.2021.
//

import SwiftUI

struct PackInfoSettings: View {
    
    var pack: MainAllPackJSON
    @ObservedObject var parser: JSONParser
    @Binding var isShowingSettings: Bool
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        ZStack {
            NavigationView {
                Form {
                    Section(header: Text("Информация")) {
                        Text("Название:\n")
                            .font(Font.system(.caption).weight(.light))
                        + Text("\(pack.packInfo.name)")
                        Text("Автор:\n")
                            .font(Font.system(.caption).weight(.light))
                        + Text("\(pack.packInfo.author)")
                        Text("Ссылка на источник:\n")
                            .font(Font.system(.caption).weight(.light))
                        + Text("\(parser.packURL)")
                            .font(Font.system(size: 10, design: .monospaced).weight(.ultraLight))
                    }
                    Section(header: Text("Контент")) {
                        Text("Всего пунктов:\n")
                            .font(Font.system(.caption).weight(.light))
                        + Text("\(pack.content.count)")
                    }
                    Section(header: Text("Обновление")) {
                        Text("Текущая локальная версия:\n")
                            .font(Font.system(.caption).weight(.light))
                        + Text("\(pack.packInfo.version)")
                        Text("Версия пака на сервере:\n")
                            .font(Font.system(.caption).weight(.light))
                        + Text("\(parser.remoteVersion)")
                        Button(action: {
                            parser.getRemoteVersion()
                        }) {
                            Text("Загрузить актуальную версию")
//                                .font(Font.system(.caption).weight(.semibold))
                        }
                    }.onAppear(perform: {
                        parser.getRemoteVersion()
                        print("CUM")
                    })
                }.navigationBarTitle("О паке")
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button(action: {
                            dismiss()
                        }) {
                            Text("Готово")
                        }
                    }
                }
            }
        }
    }
}

struct PackInfoSettings_Previews: PreviewProvider {
    @StateObject static var parser: JSONParser = JSONParser(packURL: URL(string: "https://cheatsheet-worldclock.api.vapronva.pw/get?key=bruh&author=thispilot")!)
    static var previews: some View {
        PackInfoSettings(pack: parser.getInformation(), parser: parser, isShowingSettings: Binding.constant(true))
    }
}
