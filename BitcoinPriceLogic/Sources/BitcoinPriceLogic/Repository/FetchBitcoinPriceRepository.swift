//
//  File.swift
//  
//
//  Created by Albert Pangestu on 20/09/25.
//

protocol FetchBitcoinPriceRepositoryProtocol {
    @available(macOS 10.15.0, *)
    func execute() async throws -> Int
}
