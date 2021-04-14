//
//  LanguageTool.swift
//  SwiftDemo
//
//  Created by Jo on 2021/4/10.
//

import Foundation

func LL(_ key: String, _ comment: String? = nil) -> String {
    return NSLocalizedString(key, comment: comment ?? "")
}
