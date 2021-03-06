//
//  DateHelper.swift
//  MenuBarTranslator
//
//  Created by Aiur on 28.04.2021.
//

import Foundation

final class DateHelper {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
//        formatter.dateFormat = "dd.MM.yyyy"
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    static func format(date: Date) -> String {
        return dateFormatter.string(from: date)
    }
    
    static let devDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
//        formatter.dateFormat = "dd.MM.yyyy"
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    static func devFormat(date: Date) -> String {
        return devDateFormatter.string(from: date)
    }
}
