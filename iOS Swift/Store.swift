//
//  Store.swift
//  iOS Swift
//
//  Created by Ivica Petrsoric on 18/05/2021.
//  Copyright © 2021 ivica petrsoric. All rights reserved.
//
import Foundation

struct Recipe: Hashable {
    let id: String
    let title: String
    let description: String
    var isLocked: Bool
    var price: String?
    let locale: Locale
    let imageName: String
    
    lazy var formatter: NumberFormatter = {
       let nf = NumberFormatter()
        nf.numberStyle = .currency
        nf.locale = locale
        return nf
    }()
    
    init(product: SKProduct, isLocked: Bool = true) {
        self.id = product.productIdentifier
        self.title = product.localizedTitle
        self.description = product.localizedDescription
        self.isLocked = isLocked
        self.locale = product.priceLocale
        self.imageName = product.productIdentifier
        
        if isLocked {
            self.price = formatter.string(from: product.price)
        }
    }
}


import StoreKit

typealias FetchCompletionHandler = (([SKProduct]) -> Void)
typealias PurchaseCompletionHandler = ((SKPaymentTransaction) -> Void)

class Store: NSObject, ObservableObject {
    
    @Published var allRecipies = [Recipe]()
    
    private let allProductIdentifiers = Set([
        "com.temporary.berry-blue",
        "com.temporary.lemon-berry"
    ])
    
    private var completedPurchases = [String]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                for index in self.allRecipies.indices {
                    self.allRecipies[index].isLocked = !self.completedPurchases.contains(self.allRecipies[index].id)
                }
            }
        }
    }
     
    private var productsRequests: SKProductsRequest?
    
    private var fetchedProducts = [SKProduct]()
    private var fetchCompletionHandler: FetchCompletionHandler?
    
    private var purchaseCompletionHandler: PurchaseCompletionHandler?
    
    override init() {
        super.init()
        
        startObservingPaymentQueue()
        
        fetchProducts { products in
            print(products)
            self.allRecipies = products.map { Recipe(product: $0) }
        }
    }
    
    private func startObservingPaymentQueue() {
        SKPaymentQueue.default().add(self)
    }
    
    private func fetchProducts(_ completion: @escaping(FetchCompletionHandler )) {
        guard self.productsRequests == nil else { return }
        
        fetchCompletionHandler = completion
        
        productsRequests = SKProductsRequest(productIdentifiers: allProductIdentifiers)
        productsRequests?.delegate = self
        productsRequests?.start()
    }
    
    private func buy(_ product: SKProduct, completion: @escaping PurchaseCompletionHandler) {
         purchaseCompletionHandler = completion
        
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }

}

extension Store {
    
    func product(for identifier: String) -> SKProduct? {
        return  fetchedProducts.first(where: { $0.productIdentifier == identifier })
    }
    
    func purchaseProduct(_ product: SKProduct) {
        startObservingPaymentQueue()
        buy(product) { (_) in
            
        }
    }
    
    func restorePurchases() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
}

extension Store: SKProductsRequestDelegate {
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        let loadProducts = response.products
        let invalidProducts = response.invalidProductIdentifiers
        
        guard !loadProducts.isEmpty else {
            print("Could not load the products!")
            
            if !invalidProducts.isEmpty {
                print("Invalid Products found: \(invalidProducts)")
            }
            
            productsRequests = nil
            
            return
        }
        
        // cache the fetched products
        fetchedProducts = loadProducts
        
        // Notify anzone waiting on the product load
        DispatchQueue.main.async {
            self.fetchCompletionHandler?(loadProducts)
            
            self.fetchCompletionHandler = nil
            self.productsRequests = nil
        }
    }
}

extension Store: SKPaymentTransactionObserver {
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            var shouldFinishTransaction = false

            switch transaction.transactionState {
            case .purchasing, .deferred:
                break
            case .purchased, .restored:
                completedPurchases.append(transaction.payment.productIdentifier)
                shouldFinishTransaction = true
                break
            case .failed:
                shouldFinishTransaction = true
                break
//            case .restored:
//            case .deferred:
                
            }
            
            if shouldFinishTransaction {
                SKPaymentQueue.default().finishTransaction(transaction)
                DispatchQueue.main.async {
                    self.purchaseCompletionHandler?(transaction)
                    self.purchaseCompletionHandler = nil
                }
            }
        }
    }
    
}
