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
        let (_, repository) = makeSUT()
        
        XCTAssertEqual(repository.messages, [])
    }
    
    func test_fetch_repoExecute() async {
        let (sut, repository) = makeSUT()
        
        do {
            try await sut.fetch()
        } catch {
            XCTFail()
        }
        
        XCTAssertEqual(repository.messages, ["executed"])
    }
    
    func test_fetchMore_repoExecuteMore() async {
        let (sut, repository) = makeSUT()
        
        do {
            try await sut.fetch()
            try await sut.fetch()
        } catch {
            XCTFail()
        }
        
        XCTAssertEqual(repository.messages, ["executed", "executed"])
    }
    
    // MARK: Helpers
    private final class FetchBitcoinPriceRepositorySpy: FetchBitcoinPriceRepositoryProtocol {
        var messages: [String] = []
        
        func execute() async throws {
            messages.append("executed")
        }
    }
    
    private func makeSUT() -> (FetchBitcoinPriceUseCase, FetchBitcoinPriceRepositorySpy) {
        let repository = FetchBitcoinPriceRepositorySpy()
        let sut = FetchBitcoinPriceUseCase(repository: repository)
        
        return (sut, repository)
    }

}
