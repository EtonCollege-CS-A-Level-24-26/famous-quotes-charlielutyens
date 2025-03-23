//
//  ContentView.swift
//  FamousQuotesParse
//
//  Created by Cormell, David - DPC on 18/03/2025.
//

import SwiftUI

struct ContentView: View {
    @State var vm: FamousQuotesViewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.quotes) { quote in
                    Text(quote.content)
                        .swipeActions {
                            Button(action: {
                                QuoteRepository.shared.deleteQuote(quote: quote)
                            }) {
                                Image(systemName: "trash")
                            }
                            .tint(.red)
                            
                            Button(action: {
                                vm.isShowingEditQuote = true
                            }) {
                                Image(systemName: "pencil")
                            }
                            .tint(.yellow)
                        }
                        .sheet(isPresented: $vm.isShowingEditQuote) {
                            Form {
                                TextField("Author", text: $vm.editQuoteAuthor)
                                TextField("Quote", text: $vm.editQuoteContent)
                                Button("Add") {
                                    QuoteRepository.shared.editQuote(quote: quote, editedAuthor: vm.editQuoteAuthor, editedContent: vm.editQuoteContent)
                                }
                            }
                        }
                }
            }
            .onAppear {
                vm.restoreQuotes()
            }
            
            .sheet(isPresented: $vm.isShowingAddQuote) {
                Form {
                    TextField("Author", text: $vm.newQuoteAuthor)
                    TextField("Quote", text: $vm.newQuoteContent)
                    Button("Add") {
                        vm.addNewQuote()
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add", systemImage: "plus") {
                        vm.isShowingAddQuote = true
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView(vm: FamousQuotesViewModel())
}
