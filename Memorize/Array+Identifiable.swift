//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by Einar Balan on 7/4/20.
//  Copyright © 2020 Einar Balan. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(of element: Element) -> Int? {
        for index in 0..<self.count {
            if element.id == self[index].id {
                return index
            }
        }
        return nil
    }
}
