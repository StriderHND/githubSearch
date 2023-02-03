//
//  Date+StringFormats.swift
//  GitSearch
//
//  Created by Erick Gonzales on 30/1/23.
//

import Foundation

extension Date {
    /**
     Fuction that will give a relative time of a date using `RelativeDateTimeFormatter`
    */
    func timeAgoDisplay() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}
