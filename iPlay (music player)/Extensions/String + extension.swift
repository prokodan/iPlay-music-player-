//
//  String + extension.swift
//  iPlay (music player)
//
//  Created by Данил Прокопенко on 13.03.2023.
//

import Foundation

extension String {
    static func getDisplayedTimeString(for value: Double) -> String {
        let valueInt = Int(value)
        let seconds = valueInt % 60
        let minutes = (valueInt / 60) % 60
        let hours = valueInt / 3600
        
        let secondsStr = seconds < 10 ? "0\(seconds)" : "\(seconds)"
        let minutesStr = minutes < 1 ? "\(minutes)" : "0\(minutes)"
        let hoursdStr = hours < 10 ? "0\(hours)" : "\(hours)"
        
        return hours == 0
        ? [minutesStr, secondsStr].joined(separator: ":")
        : [hoursdStr, minutesStr, secondsStr].joined(separator: ":")
    }
}
