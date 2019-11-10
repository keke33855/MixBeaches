//
//  Date+Additions.swift
//  nomura
//
//  Created by lio on 2019/7/2.
//  Copyright © 2019 lio. All rights reserved.
//

import Foundation

extension Date {

    var calendar: Calendar {
        return Calendar(identifier: Calendar.current.identifier)
    }

    var unixTimestamp: TimeInterval {
        return timeIntervalSince1970
    }
}

extension Date {

    private func date(component: Calendar.Component, newValue: Int) -> Date? {
        let currentValue = calendar.component(component, from: self)
        let diffValue = newValue - currentValue
        return calendar.date(byAdding: component, value: diffValue, to: self)
    }

    var year: Int {
        get {
            return calendar.component(.year, from: self)
        }
        set {
            guard newValue > 0 else { return }
            if let newDate = date(component: .year, newValue: newValue) {
                self = newDate
            }
        }
    }

    var month: Int {
        get {
            return calendar.component(.month, from: self)
        }
        set {
            guard let allowedRange = calendar.range(of: .month, in: .year, for: self),
                allowedRange.contains(newValue) else { return }

            if let newDate = date(component: .month, newValue: newValue) {
                self = newDate
            }
        }
    }

    var day: Int {
        get {
            return calendar.component(.day, from: self)
        }
        set {
            guard let allowedRange = calendar.range(of: .day, in: .month, for: self),
                allowedRange.contains(newValue) else { return }

            if let newDate = date(component: .day, newValue: newValue) {
                self = newDate
            }
        }
    }

    var hour: Int {
        get {
            return calendar.component(.hour, from: self)
        }
        set {
            guard let allowedRange = calendar.range(of: .hour, in: .day, for: self),
                allowedRange.contains(newValue) else { return }

            if let newDate = date(component: .hour, newValue: newValue) {
                self = newDate
            }
        }
    }

    var minute: Int {
        get {
            return calendar.component(.minute, from: self)
        }
        set {
            guard let allowedRange = calendar.range(of: .minute, in: .hour, for: self),
                allowedRange.contains(newValue) else { return }

            if let newDate = date(component: .minute, newValue: newValue) {
                self = newDate
            }
        }
    }

    var second: Int {
        get {
            return calendar.component(.second, from: self)
        }
        set {
            guard let allowedRange = calendar.range(of: .second, in: .minute, for: self),
                allowedRange.contains(newValue) else { return }

            if let newDate = date(component: .second, newValue: newValue) {
                self = newDate
            }
        }
    }
}

extension Date {
    func begin(of component: Calendar.Component) -> Date? {
        if component == .day {
            return calendar.startOfDay(for: self)
        }

        var components: Set<Calendar.Component> {
            switch component {
            case .year:
                return [.year]
            case .month:
                return [.year, .month]
            case .hour:
                return [.year, .month, .day, .hour]
            case .minute:
                return [.year, .month, .day, .hour, .minute]
            case .second:
                return [.year, .month, .day, .hour, .minute, .minute]
            case .weekOfMonth, .weekOfYear:
                return [.weekOfYear, .weekOfMonth]
            default:
                return []
            }
        }

        guard !components.isEmpty else { return nil }
        return calendar.date(from: calendar.dateComponents(components, from: self))
    }

    func end(of component: Calendar.Component) -> Date? {
        fatalError()
    }

    func isBetween(_ startDate: Date, _ endDate: Date, includeBounds: Bool = false) -> Bool {
        if includeBounds {
            return startDate.compare(self).rawValue * compare(endDate).rawValue >= 0
        }
        return startDate.compare(self).rawValue * compare(endDate).rawValue > 0
    }

    func adding(_ component: Calendar.Component, value: Int) -> Date? {
        return calendar.date(byAdding: component, value: value, to: self)
    }
}

extension Date {
    func between(of component: Calendar.Component, to: Date) -> Int? {
        let comps = calendar.dateComponents(Set<Calendar.Component>(arrayLiteral: component),
                                            from: self,
                                            to: to)
        return comps.value(for: component)
    }
}

extension Date {
    init(unixTimestamp: Double) {
        self.init(timeIntervalSince1970: unixTimestamp)
    }
}

extension TimeInterval {
    var toDate: Date {
        return Date(unixTimestamp: self)
    }
}
