//
//  AddRecordViewModel.swift
//  ExpenseTracker
//
//  Created by William Santoso on 29/04/21.
//

import Foundation
import RealmSwift

class AddRecordViewModel: ObservableObject {
    let realm = try! Realm()
    var resultCategories: Results<Category>?
    var resultRecords: Results<Record>?
    
    var categories: [Category]? {
        didSet {
            if categories != nil {
                if let filter = filter {
                    filterCategories = getFilteredData(data: categories, by: filter)
                } else {
                    filterCategories = categories
                }
            } else {
                filterCategories = nil
            }
        }
    }
    var records: [Record]?{
        didSet {
            if records != nil {
                if let filter = filter {
                    filterRecords = getFilteredData(data: records, by: filter)
                } else {
                    filterRecords = records
                }
            } else {
                filterRecords = nil
            }
        }
    }
    
    @Published var filterCategories: [Category]?
    @Published var filterRecords: [Record]?
    
    @Published var newCategory: Category?
    @Published var newRecord: Record?
    
    @Published var filter: Type? {
        didSet {
            if let filter = filter {
                filterCategories = getFilteredData(data: categories, by: filter)
                filterRecords = getFilteredData(data: records, by: filter)
            } else {
                clearFilter()
            }
        }
    }
    
    init() {
        loadCategories()
        loadRecords()
        
        print(Realm.Configuration.defaultConfiguration.fileURL ?? "")
    }
    
    var count1 = 0
    var count2 = 0
    
    func addDummyCategory() {
        let dummyCategory = Category()
        dummyCategory.name = "Salary \(count1)"
        count1 += 1
        
        if count1 % 2 == 1 {
            dummyCategory.type = Type.expense.rawValue
        }
        
        saveCategory(dummyCategory)
        loadCategories()
    }
    
    func addDummyRecord() {
        let dummyRecord = Record()
        dummyRecord.date = Date()
        if count2 % 2 == 1 {
            dummyRecord.type = Type.expense.rawValue
        }
        
        if (resultCategories?.count ?? 0 >= 2) {
            if let category = resultCategories?[0] {
                dummyRecord.categories.append(category)
            }
            if let category = resultCategories?[1] {
                dummyRecord.categories.append(category)
            }
        }
        
        dummyRecord.value = 1000 * (Double(count2) + 1)
        dummyRecord.note = "count \(count2)"
        count2 += 1
        
        saveRecord(dummyRecord)
        loadRecords()
    }
    
    func saveCategory(_ category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("error save context : \(error)")
        }
    }
    
    func saveRecord(_ record: Record) {
        do {
            try realm.write {
                realm.add(record)
            }
        } catch {
            print("error save context : \(error)")
        }
    }
    
    func loadCategories() {
        resultCategories = realm.objects(Category.self)
        
        if resultCategories == nil || resultCategories?.isEmpty ?? true {
            let tempCategories = preFilledCategories()
            
            for tempCategory in tempCategories {
                saveCategory(tempCategory)
            }
            
            resultCategories = realm.objects(Category.self)
        }
        
        categories = resultCategories?.toArray()
    }
    
    func loadRecords() {
        resultRecords = realm.objects(Record.self)
        
        records = resultRecords?.toArray()
    }
    
    func clearCategories() {
        let categories = realm.objects(Category.self)
        for category in categories {
            do {
                try realm.write {
                    realm.delete(category)
                }
            } catch let error {
                print("error - \(error.localizedDescription)")
            }
        }
        loadCategories()
        count1=0
    }
    
    func clearRecords() {
        let records = realm.objects(Record.self)
        for record in records {
            do {
                try realm.write {
                    realm.delete(record)
                }
            } catch let error {
                print("error - \(error.localizedDescription)")
            }
        }
        self.records?.removeAll()
        self.filterRecords?.removeAll()
        loadCategories()
        count2=0
    }
    
    func filterData(by type: Type) {
        filterCategories = getFilteredData(data: categories, by: type)
        filterRecords = getFilteredData(data: records, by: type)
    }
    
    func clearFilter() {
        filterCategories = categories
        filterRecords = records
    }
    
    
    func getFilteredData(data: [Category]?, by type: Type) -> [Category]? {
        guard let data = data  else { return nil }
        
        let filteredData = data.filter {
            $0.type == type.rawValue
        }
        
        return filteredData
    }
    
    func getFilteredData(data: [Record]?, by type: Type) -> [Record]? {
        guard let data = data  else { return nil }
        
        let filteredData = data.filter {
            $0.type == type.rawValue
        }
        
        return filteredData
    }
}
