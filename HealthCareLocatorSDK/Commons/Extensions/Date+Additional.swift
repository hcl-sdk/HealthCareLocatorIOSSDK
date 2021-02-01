//
//  Date+Additional.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 12/21/20.
//

import Foundation

extension Date {
    func timeAgo(locale: String) -> String {
        let formatter = DateComponentsFormatter()
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: locale)
        formatter.calendar = calendar
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.year, .month, .day, .hour, .minute, .second]
        formatter.zeroFormattingBehavior = .dropAll
        formatter.maximumUnitCount = 1

        return formatter.string(from: self, to: Date()) ?? ""
    }
}
