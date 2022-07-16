//
//  Store+Hashable.swift
//  GameOfThrones
//
//  Created by Christian Elies on 16/07/2022.
//  Copyright © 2022 Christian Elies. All rights reserved.
//

import ComposableArchitecture

extension Store: Equatable where State: Equatable {
    public static func == (lhs: ComposableArchitecture.Store<State, Action>, rhs: ComposableArchitecture.Store<State, Action>) -> Bool {
        ViewStore(lhs).state == ViewStore(rhs).state
    }
}

extension Store: Hashable where State: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ViewStore(self).state)
    }
}
