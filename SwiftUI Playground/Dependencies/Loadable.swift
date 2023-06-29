//
//  Loadable.swift
//  Vestiaire Collective
//
//  Created by Duy Tran on 27/02/2023.
//  Copyright © 2023 VestiaireCollective. All rights reserved.
//

import Foundation

/// An enumeration that represents states of loading data with latency.
enum Loadable<Data, Failure> where Failure: Error {
    /// The data is being reloaded with the latest data.
    case isLoading(last: Data?)
    /// The data is loaded successfully.
    case loaded(Data)
    /// The data loading failed.
    case failed(Failure)

    /// Returns the last data while loading or the loaded data.
    var data: Data? {
        switch self {
        case .isLoading(let data):
            return data
        case .loaded(let data):
            return data
        case .failed:
            return nil
        }
    }

    /// Returns an error if it is failed.
    var error: Error? {
        switch self {
        case .isLoading, .loaded:
            return nil
        case .failed(let error):
            return error
        }
    }
}

extension Loadable: Equatable where Data: Equatable {
    static func == (lhs: Loadable<Data, Failure>, rhs: Loadable<Data, Failure>) -> Bool {
        switch (lhs, rhs) {
        case let (.isLoading(lhsData), .isLoading(rhsData)):
            return lhsData == rhsData
        case let (.loaded(lhsData), .loaded(rhsData)):
            return lhsData == rhsData
        case let (.failed(lhsError), .failed(rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}
