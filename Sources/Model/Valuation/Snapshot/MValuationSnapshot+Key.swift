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

extension MValuationSnapshot: AllocKeyed {
    public struct Key: Hashable, Comparable, Equatable {
        private let snapshotIDn: String
        
        public init(snapshotID: String) {
            self.snapshotIDn = MValuationSnapshot.normalizeID(snapshotID)
        }
        
        public init(_ element: MValuationSnapshot) {
            self.init(snapshotID: element.snapshotID)
        }
        
        public static func < (lhs: Key, rhs: Key) -> Bool {
            if lhs.snapshotIDn < rhs.snapshotIDn { return true }
            if lhs.snapshotIDn > rhs.snapshotIDn { return false }

            return false
        }
    }
    
    public var primaryKey: Key {
        Key(self)
    }
}

//extension MValuationSnapshot: AllocKeyed1 {
//    public var primaryKey1: AllocKey {
//        MValuationSnapshot.makePrimaryKey(snapshotID: snapshotID)
//    }
//
//    public static func makePrimaryKey(snapshotID: String) -> AllocKey {
//        keyify(snapshotID)
//    }
//}
