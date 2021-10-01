//
//  M+Row.swift
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

extension MValuationPosition: AllocRowed {
    public init(from row: DecodedRow) throws {
        guard let snapshotID_ = MValuationPosition.getStr(row, CodingKeys.snapshotID.rawValue)
        else { throw AllocDataError.invalidPrimaryKey(CodingKeys.snapshotID.rawValue) }
        snapshotID = snapshotID_

        guard let accountID_ = MValuationPosition.getStr(row, CodingKeys.accountID.rawValue)
        else { throw AllocDataError.invalidPrimaryKey(CodingKeys.accountID.rawValue) }
        accountID = accountID_

        guard let assetID_ = MValuationPosition.getStr(row, CodingKeys.assetID.rawValue)
        else { throw AllocDataError.invalidPrimaryKey(CodingKeys.assetID.rawValue) }
        assetID = assetID_

        totalBasis = MValuationPosition.getDouble(row, CodingKeys.totalBasis.rawValue) ?? 0
        marketValue = MValuationPosition.getDouble(row, CodingKeys.marketValue.rawValue) ?? 0
    }

    public mutating func update(from row: DecodedRow) throws {
        if let val = MValuationPosition.getDouble(row, CodingKeys.totalBasis.rawValue) { totalBasis = val }
        if let val = MValuationPosition.getDouble(row, CodingKeys.marketValue.rawValue) { marketValue = val }
    }

    public static func getPrimaryKey(_ row: DecodedRow) throws -> AllocKey {
        let rawValue0 = CodingKeys.snapshotID.rawValue
        let rawValue1 = CodingKeys.accountID.rawValue
        let rawValue2 = CodingKeys.assetID.rawValue
        guard let snapshotID_ = getStr(row, rawValue0),
              let accountID_ = getStr(row, rawValue1),
              let assetID_ = getStr(row, rawValue2)
        else { throw AllocDataError.invalidPrimaryKey("Position") }
        return makePrimaryKey(snapshotID: snapshotID_, accountID: accountID_, assetID: assetID_)
    }

    public static func decode(_ rawRows: [RawRow], rejectedRows: inout [RawRow]) throws -> [DecodedRow] {
        let ck = MValuationPosition.CodingKeys.self

        return rawRows.compactMap { rawRow in
            // required values, without default values
            guard let snapshotID = parseString(rawRow[ck.snapshotID.rawValue]),
                  let accountID = parseString(rawRow[ck.accountID.rawValue]),
                  accountID.count > 0,
                  let assetID = parseString(rawRow[ck.assetID.rawValue]),
                  assetID.count > 0
            else {
                rejectedRows.append(rawRow)
                return nil
            }

            // optional values
            let totalBasis = parseDouble(rawRow[ck.totalBasis.rawValue])
            let marketValue = parseDouble(rawRow[ck.marketValue.rawValue])

            return [
                ck.snapshotID.rawValue: snapshotID,
                ck.accountID.rawValue: accountID,
                ck.assetID.rawValue: assetID,
                ck.totalBasis.rawValue: totalBasis,
                ck.marketValue.rawValue: marketValue,
            ]
        }
    }
}
