//
//  Array+Only.swift
//  Memorize
//
//  Created by Einar Balan on 7/4/20.
//  Copyright © 2020 Einar Balan. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
