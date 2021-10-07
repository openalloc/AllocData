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

extension MAccount: AllocKeyed {
    public struct Key: Hashable, Comparable, Equatable {
        private let accountIDn: String
        
        public init(accountID: String) {
            self.accountIDn = MAccount.normalizeID(accountID)
        }
        
        public init(_ element: MAccount) {
            self.init(accountID: element.accountID)
        }
        
        public static func < (lhs: Key, rhs: Key) -> Bool {
            lhs.accountIDn < rhs.accountIDn
        }
    }
    
    public var primaryKey: Key {
        Key(self)
    }
}

//extension MAccount: AllocKeyed1 {
//    public var primaryKey1: AllocKey {
//        MAccount.keyify(accountID)
//    }
//}
