//
//  Extension.swift
//  ExpenseTracker
//
//  Created by William Santoso on 29/04/21.
//

import Foundation
import RealmSwift

extension Results {
    func toArray() -> [Element] {
      return compactMap {
        $0
      }
    }
 }
