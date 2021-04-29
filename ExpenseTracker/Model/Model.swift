//
//  Model.swift
//  ExpenseTracker
//
//  Created by William Santoso on 29/04/21.
//

import Foundation
import RealmSwift

enum Type: String {
    case income = "income"
    case expense = "expense"
}

class Record: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var date: Date = Date()
    @objc dynamic var type: String = "income"
    var categories = List<Category>()
    @objc dynamic var value: Double = 0
    @objc dynamic var note: String?
    
}

class Category: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name: String = ""
    @objc dynamic var type: String = "income"
}

