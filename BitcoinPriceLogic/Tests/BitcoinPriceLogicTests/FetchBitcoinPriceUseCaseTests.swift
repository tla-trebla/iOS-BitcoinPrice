//
//  FetchBitcoinPriceUseCaseTests.swift
//  
//
//  Created by Albert Pangestu on 28/04/25.
//

import XCTest

protocol FetchBitcoinPriceRepositoryProtocol {
    func execute() async throws -> Int
}

final class FetchBitcoinPriceUseCase {
    private let repository: FetchBitcoinPriceRepositoryProtocol
    
    init(repository: FetchBitcoinPriceRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetch() async throws -> Int {
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
            _ = try await sut.fetch()
        } catch {
            XCTFail()
        }
        
        XCTAssertEqual(repository.messages, [.Executed])
    }
    
    func test_fetchMore_repoExecuteMore() async {
        let (sut, repository) = makeSUT()
        
        do {
            _ = try await sut.fetch()
            _ = try await sut.fetch()
        } catch {
            XCTFail()
        }
        
        XCTAssertEqual(repository.messages, [.Executed, .Executed])
    }
    
    func test_fetch_returnPrice() async {
        let stubbedPrice = 93000
        let repository = FetchBitcoinPriceRepositoryStub(price: stubbedPrice)
        let sut = FetchBitcoinPriceUseCase(repository: repository)
        var price = 0
        
        do {
            price = try await sut.fetch()
        } catch {
            XCTFail()
        }
        
        XCTAssertEqual(price, stubbedPrice)
    }
    
    // MARK: Helpers
    private final class FetchBitcoinPriceRepositoryStub: FetchBitcoinPriceRepositoryProtocol {
        private(set) var price = 0
        
        init(price: Int = 0) {
            self.price = price
        }
        
        func execute() async throws -> Int {
            price
        }
    }
    
    private final class FetchBitcoinPriceRepositorySpy: FetchBitcoinPriceRepositoryProtocol {
        private(set) var messages: [Message] = []
        
        func execute() async throws -> Int {
            messages.append(.Executed)
            return 0
        }
        
        enum Message {
            case Executed
        }
    }
    
    private func makeSUT() -> (FetchBitcoinPriceUseCase, FetchBitcoinPriceRepositorySpy) {
        let repository = FetchBitcoinPriceRepositorySpy()
        let sut = FetchBitcoinPriceUseCase(repository: repository)
        
        return (sut, repository)
    }

}
