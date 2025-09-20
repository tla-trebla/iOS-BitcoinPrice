//
//  File.swift
//  
//
//  Created by Albert Pangestu on 20/09/25.
//

final class FetchBitcoinPriceUseCase {
    private let repository: FetchBitcoinPriceRepositoryProtocol
    
    init(repository: FetchBitcoinPriceRepositoryProtocol) {
        self.repository = repository
    }
    
    @available(macOS 10.15.0, *)
    func fetch() async throws -> Int {
        try await repository.execute()
    }
}
