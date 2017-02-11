//
//  DateExtensions.swift
//  Saturdays
//
//  Created by Muhammed Said Özcan on 18/10/16.
//  Copyright © 2016 Muhammed Said Özcan. All rights reserved.
//

//

import Foundation

// Formatters and Strings
public extension Date {
    /// Returns an ISO 8601 formatter
    public static var iso8601Formatter: DateFormatter = {
        $0.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"
        $0.locale = Locale(identifier: "en_US_POSIX")
        return $0
    }(DateFormatter())
    
    /// Returns a custom short style date formatter
    public static var shortDateFormatter: DateFormatter = {
        $0.dateFormat = "MMM dd, yy'''"
        $0.locale = Locale(identifier: "en_US_POSIX")
        return $0
    }(DateFormatter())
    
    /// Represents date as ISO8601 string
    public var iso8601String: String { return Date.iso8601Formatter.string(from: self) }
    
    /// Returns date components as short string
    public var shortDateString: String { return Date.shortDateFormatter.string(from:self) }
}
