//
//  ClockFaceExMain.swift
//  worldclock-cheatsheet WatchKit Extension
//
//  Created by Vladimir Malinovskiy on 19.11.2021.
//

import SwiftUI
//import UIKit

struct Time {
    var sec: Int
    var min: Int
    var hour: Int
}

struct ClockFaceExMain: View {
        
    @Binding var isDark: Bool
    @Binding var currentTime: Time
    
//    var width = UIScreen.main.bounds.width
//    var width: CGFloat = 75
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color(isDark ? .white : .black))
                .opacity(0.1)
            ForEach(0..<60) { second in
                            Rectangle()
                                .fill(Color.primary)
                                .frame(width: 0.5, height: (second % 5) == 0 ? 10 : 5)
                                .offset(y: 15)
                                .rotationEffect(.init(degrees: Double(second) * 6))
            }
            Rectangle()
                .fill(Color.primary)
                .frame(width: 1.7, height: 20)
                .offset(y: -9)
                .rotationEffect(.init(degrees: Double(currentTime.sec) * 6))
            
            Rectangle()
                .fill(Color.primary)
                .frame(width: 2, height: 15)
                .offset(y: -9)
                .rotationEffect(.init(degrees: Double(currentTime.min) * 6))
            
            Rectangle()
                .fill(Color.primary)
                .frame(width: 2.5, height: 10)
                .offset(y: -7)
                .rotationEffect(.init(degrees: Double(currentTime.hour) * 30))
            
            Circle()
                .fill(Color.primary)
                .frame(width: 6, height: 6)
        }
        .frame(width: 15, height: 15)
//        Spacer()
    }
}

struct ClockFaceExMain_Previews: PreviewProvider {
    static var previews: some View {
        ClockFaceExMain(isDark: Binding.constant(true), currentTime: Binding.constant(Time(sec: 10, min: 37, hour: 12)))
    }
}
