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

extension MAllocation: AllocKeyed {
    public struct Key: Hashable, Equatable, Codable {
        public let strategyNormID: String
        public let assetNormID: String
        
        public init(strategyID: String, assetID: String) {
            self.strategyNormID = MAllocation.normalizeID(strategyID)
            self.assetNormID = MAllocation.normalizeID(assetID)
        }
        
        public init(_ element: MAllocation) {
            self.init(strategyID: element.strategyID, assetID: element.assetID)
        }        
    }
    
    public var primaryKey: Key {
        Key(self)
    }
}

//extension MAllocation: AllocKeyed1 {
//    public var primaryKey1: AllocKey {
//        MAllocation.keyify([strategyID, assetID])
//    }
//}
