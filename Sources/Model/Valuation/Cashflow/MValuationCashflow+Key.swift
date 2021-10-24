//
//  M+Key.swift
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

extension MValuationCashflow: AllocKeyed {
    public struct Key: Hashable, Equatable, Codable {
        public let transactedAt: Date
        public let accountNormID: NormalizedID
        public let assetNormID: NormalizedID
        
        public init(transactedAt: Date, accountID: String, assetID: String) {
            self.transactedAt = transactedAt
            self.accountNormID = MTracker.normalizeID(accountID)
            self.assetNormID = MTracker.normalizeID(assetID)
        }
        
        public init(_ element: MValuationCashflow) {
            self.init(transactedAt: element.transactedAt,
                      accountID: element.accountID,
                      assetID: element.assetID)
        }
    }
    
    public var primaryKey: Key {
        Key(self)
    }
    
    public static var emptyKey: Key {
        Key(transactedAt: Date.init(timeIntervalSinceReferenceDate: 0), accountID: "", assetID: "")
    }
}
