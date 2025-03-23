//
//  FamousQuotesParseApp.swift
//  FamousQuotesParse
//
//  Created by Cormell, David - DPC on 18/03/2025.
//

import SwiftUI
import ParseSwift

@main
struct FamousQuotesParseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(vm: FamousQuotesViewModel())
        }
    }
    
    init() {
        // Replace placeholders with your Back4App credentials
        ParseSwift.initialize(
            applicationId: "E3kqwuUweXDqUn1FVpzdfdMb4atpqJsx9wFCoESQ",
            clientKey: "Efo9YkGvqayJVNsgPXXM6S8K8BilcT1yfVUL5Yqc ",
            serverURL: URL(string: "https://parseapi.back4app.com/")!
        )
    }
}
