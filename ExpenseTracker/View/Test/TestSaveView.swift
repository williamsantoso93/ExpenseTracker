//
//  TestSaveView.swift
//  ExpenseTracker
//
//  Created by William Santoso on 29/04/21.
//

import SwiftUI

struct TestSaveView: View {
    @StateObject var addRecordViewModel = AddRecordViewModel()
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("add")) {
                    Button("Add dummy category") {
                        addRecordViewModel.addDummyCategory()
                    }
                    
                    Button("Add dummy records") {
                        addRecordViewModel.addDummyRecord()
                    }
                    
                    Button("Clear category") {
                        addRecordViewModel.clearCategories()
                    }
                    
                    Button("Clear records") {
                        addRecordViewModel.clearRecords()
                    }
                    
                    Button("filter by income") {
                        addRecordViewModel.filter = .income
                    }
                    
                    Button("filter by expense") {
                        addRecordViewModel.filter = .expense
                    }
                    
                    Button("clear filter") {
                        addRecordViewModel.filter = nil
                    }
                }
                
                if let categories = addRecordViewModel.filterCategories {
                    if !categories.isEmpty {
                        Section(header: Text("categories")) {
                            ForEach(categories, id:\.self) { category in
                                VStack(alignment: .leading) {
                                    //                                Text("id\t\t: \(category.id)")
                                    Text("name\t: \(category.name)")
                                    Text("type\t: \(category.type)")
                                }
                            }
                        }
                    }
                }
                
                if let records = addRecordViewModel.filterRecords {
                    if !records.isEmpty {
                        Section(header: Text("Records")) {
                            ForEach(records, id:\.self) { record in
                                VStack(alignment: .leading) {
                                    //                                Text("id\t\t: \(record.id)")
                                    Text("date\t: \(record.date)")
                                    Text("type\t: \(record.type)")
                                    
                                    Text("categories\t:")
                                    if let categories = record.categories {
                                        ForEach(categories, id:\.self) { category in
                                            Text(" - \(category.name)")
                                        }
                                    }
                                    
                                    Text("value\t: \(String(format: "%.f", record.value))")
                                    Text("note\t: \(record.note ?? "")")
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Records")
        }
    }
}

struct TestSaveView_Previews: PreviewProvider {
    static var previews: some View {
        TestSaveView()
    }
}
