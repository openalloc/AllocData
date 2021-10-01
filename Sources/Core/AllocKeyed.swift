//
//  AllocKeyed.swift
//
// Copyright 2021 FlowAllocator LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import Foundation

public protocol AllocKeyed {
    // Note that key values should NOT be persisted. Their format and composition may vary across platforms and versions.
    var primaryKey: AllocKey { get }

    static func keyify(_ component: String?) -> AllocKey
    static func keyify(_ components: [String?]) -> AllocKey
    static func makeAllocMap<T: AllocKeyed>(_ elements: [T]) -> [AllocKey: T]
}

public extension AllocKeyed {
    
    // an AllocKey is a normalized 'ID', trimmed and lowercased.
    typealias AllocKey = String

    // an AllocKey in non-optional 'nil' state
    // needed to support SwiftUI Picker
    static var AllocNilKey: AllocKey { "" }

    static func keyify(_ component: String?) -> AllocKey {
        component?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() ?? AllocNilKey
    }

    static func keyify(_ components: [String?]) -> AllocKey {
        let separator = ","
        return
            components
                .map { $0?.trimmingCharacters(in: .whitespacesAndNewlines) ?? AllocNilKey }
                .joined(separator: separator).lowercased()
    }

    static func makeAllocMap<T: AllocKeyed>(_ elements: [T]) -> [AllocKey: T] {
        let keys: [AllocKey] = elements.map(\.primaryKey)
        return Dictionary(zip(keys, elements), uniquingKeysWith: { old, _ in old })
    }
}