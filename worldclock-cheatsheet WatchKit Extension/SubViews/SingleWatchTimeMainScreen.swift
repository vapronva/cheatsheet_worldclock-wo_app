//
//  SingleWatchTimeMainScreen.swift
//  worldclock-cheatsheet WatchKit Extension
//
//  Created by Vladimir Malinovskiy on 18.11.2021.
//

import SwiftUI
//import UIKit

struct SingleWatchTimeMainScreen: View {
    var cityName: String
    var minusHowManyHours: Int
    @State var date = Date()
    @State var currentTime = Time(sec: 15, min: 10, hour: 10)
    var body: some View {
        ZStack {
            Color(red: 25/255, green: 25/255, blue: 25/255)
//                .frame(maxHeight: 65)
            HStack {
                Spacer()
                ClockFaceExMain(isDark: Binding.constant(true), currentTime: $currentTime)
                    .padding(.trailing, 12)
//                    .padding(.leading, 0)
                Spacer()
                VStack (alignment: .center) {
                    Text(self.cityName)
                        .font(Font.system(size: 12, design: .default).weight(.regular))
                        .padding(.bottom, -8)
                    Text("\(timeString(date: date))")
                         .onAppear(perform: {let _ = self.updateTimer})
                         .font(Font.system(.title3, design: .monospaced).weight(.semibold))
                }.padding(.trailing, 17)
            }.padding(.vertical, 5)
        }.onChange(of: date) { _ in
            getTimeComponents()
        }
    }
    var timeFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter
    }
    func timeString(date: Date) -> String {
        let time = timeFormat.string(from: Calendar.current.date(byAdding: .hour, value: self.minusHowManyHours, to: date)!)
         return time
    }
    var updateTimer: Timer {
        Timer.scheduledTimer(
            withTimeInterval: 1, repeats: true,
            block: {_ in
                self.date = Date()
           })
    }
    private func getTimeComponents() {
        let calender = Calendar.current
        let sec = calender.component(.second, from: Date())
        let min = calender.component(.minute, from: Date())
        let hour = calender.component(.hour, from: Date())
        withAnimation(Animation.linear(duration: 0.01)) {
            currentTime = Time(sec: sec, min: min, hour: hour + self.minusHowManyHours)
        }
    }
}

struct SingleWatchTimeMainScreen_Previews: PreviewProvider {
    static var previews: some View {
        SingleWatchTimeMainScreen(cityName: "Омск", minusHowManyHours: 0)
    }
}
