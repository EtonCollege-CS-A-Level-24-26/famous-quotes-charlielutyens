//
//  QuoteRepository.swift
//  FamousQuotesParse
//
//  Created by Cormell, David - DPC on 18/03/2025.
//

import Foundation

class QuoteRepository {
    
    static let shared = QuoteRepository()
    
    private init() {}
    
    func saveQuote(quote: Quote) {
        let quoteDao = QuoteDao(author: quote.author, content: quote.content)
        do {
            try quoteDao.save()
        } catch {
            print("Failing to save quote: \(quote.content)")
        }
    }
    
    func deleteQuote(quote: Quote) {

        let query0 = QuoteDao.query("content" == quote.content)
        
        query0.first { result in
            switch result {
            case .success(let quoteDao):
                quoteDao.delete{ deleteResult in
                    switch deleteResult {
                    case .success:
                        print("Deleted quote")
                    case .failure:
                        print("Failed to delete quote")
                    }
                }
            case .failure(let error):
                print("Failed to find quote: \(error.localizedDescription)")
            }
        }
    }
    
    func editQuote(quote: Quote, editedAuthor: String, editedContent: String) {
        var query1 = QuoteDao.query("content" == quote.content && "author" == quote.author)
        
        query1 = query1.first
        do {
            query1.author = editedAuthor
            query1.content = editedContent
            query1.save()
        } catch {
            print("Failed to edit quote")
        }
    }
    
    func getAllQuotes(completion: @escaping ([Quote]) -> Void) {
        let query = QuoteDao.query().order([.descending("createdAt")])
        query.find() { response in
            let quotes: [Quote] = (try? response.get())?.compactMap({
                guard let author = $0.author, let content = $0.content else { return nil }
                return Quote(author: author, content: content)
            }) ?? []
            
            completion(quotes)
            
        }
    }
}
