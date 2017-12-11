//
//  NumberFormatterExtension.swift
//  CoreDataExampleApp
//
//  Created by Jason Ji on 12/9/17.
//  Copyright © 2017 Jason Ji. All rights reserved.
//

import Foundation

// Utility function for NumberFormatter

extension NumberFormatter {
    func string(from value: Double) -> String? {
        return string(from: NSNumber(value: value))
    }
}
