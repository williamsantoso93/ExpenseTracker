//
//  PrefilledData.swift
//  ExpenseTracker
//
//  Created by William Santoso on 29/04/21.
//

import Foundation

func preFilledCategories() -> [Category] {
    var categories = [Category]()
    
    //Income
    let incomes = ["salary", "other"]
    for income in incomes {
        let category = Category()
        category.name = income
        category.type = Type.income.rawValue
        categories.append(category)
    }
    
    //expense
    let expenses = ["food", "electricity", "internet", "water", "IPL", "credit card", "taxes", "utilities", "insurance", "fruit", "laundry", "transport", "medicine", "pulsa", "gift", "learning", "electronic", "vitamin", "other"]
    
    for expense in expenses {
        let category = Category()
        category.name = expense
        category.type = Type.expense.rawValue
        categories.append(category)
    }
    return categories
}
