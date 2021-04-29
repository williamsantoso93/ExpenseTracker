//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by William Santoso on 14/02/21.
//

import SwiftUI
import VisionKit
import Vision

struct ContentView: View {
    @State var isScanned = false
    @State var text = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Hello, World!")
                
                Button(action: {
                    isScanned.toggle()
                }) {
                    Text("Button")
                }
            }
        }
        .fullScreenCover(isPresented: $isScanned, content: {
            ScannerView(completion: { textPerPage in
                if let text = textPerPage {
                    self.text = text
                }
                isScanned = false
            })
                .ignoresSafeArea()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
