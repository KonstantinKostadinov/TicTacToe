//
//  Utilities.swift
//  TicTacToe
//
//  Created by Konstantin Kostadinov on 13.11.19.
//  Copyright © 2019 Konstantin Kostadinov. All rights reserved.
//

import Foundation

public extension Sequence where Element : Hashable {
    func contains(_ elements: [Element]) -> Bool {
        return Set(elements).isSubset(of:Set(self))
    }
}
