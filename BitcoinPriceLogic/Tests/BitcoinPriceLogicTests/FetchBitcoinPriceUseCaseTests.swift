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
    
    func fetch() async throws {
        try await repository.execute()
    }
}

final class FetchBitcoinPriceUseCaseTests: XCTestCase {
    func test_init_nothing() {
        let repository = FetchBitcoinPriceRepositorySpy()
        let _ = FetchBitcoinPriceUseCase(repository: repository)
        
        XCTAssertEqual(repository.messages, [])
    }
    
    func test_fetch_repoExecute() async {
        let repository = FetchBitcoinPriceRepositorySpy()
        let sut = FetchBitcoinPriceUseCase(repository: repository)
        
        do {
            try await sut.fetch()
        } catch {
            XCTFail()
        }
        
        XCTAssertEqual(repository.messages, ["executed"])
    }
    
    // MARK: Helpers
    private final class FetchBitcoinPriceRepositorySpy: FetchBitcoinPriceRepositoryProtocol {
        var messages: [String] = []
        
        func execute() async throws {
            messages.append("executed")
        }
    }

}
