//
//  ViewState.swift
//  GameOfThrones
//
//  Created by Christian Elies on 16/07/2022.
//  Copyright © 2022 Christian Elies. All rights reserved.
//

import Foundation

enum ViewState<V: Equatable, E: Equatable>: Equatable where V: Hashable, E: Hashable {
    case loading(_ previous: V? = nil)
    case loaded(_ value: V)
    case failure(_ error: E)
}

extension ViewState: Hashable {}

extension ViewState {
    var value: V? {
        get {
            switch self {
            case let .loading(value):
                return value
            case let .loaded(value):
                return value
            case .failure:
                return nil
            }
        }
        set {
            switch self {
            case .loading:
                self = .loading(newValue)
            case .loaded:
                guard let newValue = newValue else {
                    return
                }
                self = .loaded(newValue)
            case .failure: ()
            }
        }
    }

    var isLoading: Bool {
        switch self {
        case .loading:
            return true
        default:
            return false
        }
    }
}
