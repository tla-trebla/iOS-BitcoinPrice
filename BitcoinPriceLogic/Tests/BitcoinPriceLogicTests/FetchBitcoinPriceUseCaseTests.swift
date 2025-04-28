//
//  FetchBitcoinPriceUseCaseTests.swift
//  
//
//  Created by Albert Pangestu on 28/04/25.
//

import XCTest

protocol FetchBitcoinPriceRepositoryProtocol {
    func execute() async throws
}

final class FetchBitcoinPriceUseCase {
    private let repository: FetchBitcoinPriceRepositoryProtocol
    
    init(repository: FetchBitcoinPriceRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetch() {}
}

final class FetchBitcoinPriceUseCaseTests: XCTestCase {
    func test_init_nothing() {
        let repository = FetchBitcoinPriceRepositorySpy()
        let _ = FetchBitcoinPriceUseCase(repository: repository)
        
        XCTAssertEqual(repository.messages, [])
    }
    
    // MARK: Helpers
    private final class FetchBitcoinPriceRepositorySpy: FetchBitcoinPriceRepositoryProtocol {
        let messages: [String] = []
        
        func execute() async throws {}
    }

}
