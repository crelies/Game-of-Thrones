//
//  HouseListTests.swift
//  HouseListTests
//
//  Created by Christian Elies on 07.09.21.
//  Copyright © 2021 Christian Elies. All rights reserved.
//

import ComposableArchitecture
@testable import GameOfThrones
import XCTest

final class HouseListTests: XCTestCase {
    private let scheduler = DispatchQueue.immediate
    private let pageSize = 5

    private var store: TestStore<HouseListState, HouseListState, HouseListAction, HouseListAction, HouseListEnvironment> {
        TestStore(
            initialState: HouseListState(pageSize: pageSize),
            reducer: HouseListModule.reducer,
            environment: HouseListEnvironment(
                mainQueue: { self.scheduler.eraseToAnyScheduler() },
                houseClient: .mock()
            )
        )
    }

    func testOnAppear_ShouldFetchHouses() {
        // Prepare

        let store = self.store

        let house: HouseMetadataModel = .mock()
        store.environment.houseClient.fetchHouses = { _, _ in
            Effect(value: [house])
        }

        // Action

        store.send(.onAppear)

        // Validate

        store.receive(.refresh)

        store.receive(.fetchHouses)

        store.receive(.housesResponse(.success([house]))) {
            $0.viewState = .loaded(.init(uniqueElements: [.init(dataModel: house)]))
            $0.allHousesLoaded = true
        }
    }

    func testRefresh_ShouldFetchHouses() {
        // Prepare

        let store = self.store

        let house: HouseMetadataModel = .mock()
        store.environment.houseClient.fetchHouses = {  _, _ in
            Effect(value: [house])
        }

        // Action

        store.send(.refresh)

        // Validate

        store.receive(.fetchHouses)

        store.receive(.housesResponse(.success([house]))) {
            $0.viewState = .loaded(.init(uniqueElements: [.init(dataModel: house)]))
            $0.allHousesLoaded = true
        }
    }

    /*func testFetchNextHouses() {
        let houses = Array(0..<10).map { HouseMetadataModel(url: URL(string: "https://duckduckgo.com/house\($0)")!, name: "House \($0)")}
        let nextHouses = Array(10..<20).map { HouseMetadataModel(url: URL(string: "https://duckduckgo.com/house\($0)")!, name: "House \($0)")}

        store.environment.houseClient.fetchHouses = { page, _ in
            if page == 1 {
                return Effect(value: houses)
            } else {
                return Effect(value: nextHouses)
            }
        }

        store.send(.housesResponse(.success(houses))) {
            $0.viewState = .loaded(.init(uniqueElements: houses.map { HouseListRowState(dataModel: $0) }))
        }

        store.send(.row(id: houses[0].id, action: .onAppear))

        store.send(.row(id: houses.last!.id, action: .onAppear))

//            store.receive(.fetchNextHouses) {
//                $0.page = $0.page + 1
//                if var lastRowState = $0.rowStates.last {
////                    lastRowState.isLoading = true
//                    $0.rowStates.updateOrAppend(lastRowState)
//                }
//            }

//            store.receive(.nextHousesResponse(.success(nextHouses))) {
//                if var lastRowState = $0.rowStates.last {
////                    lastRowState.isLoading = false
//                    $0.rowStates.updateOrAppend(lastRowState)
//                }
//                for newHouse in nextHouses {
//                    $0.rowStates.append(.init(id: newHouse.id.absoluteString, dataModel: newHouse))
//                }
//            }
    }*/

    func testFetchHouses_AllHousesLoaded() {
        // Prepare

        let store = self.store

        let houses = Array(0..<10).map { HouseMetadataModel(url: URL(string: "https://duckduckgo.com/house\($0)")!, name: "House \($0)")}
        let expectedHouses = Array(houses.prefix(pageSize - 1))
        store.environment.houseClient.fetchHouses = { _, _ in
            Effect(value: expectedHouses)
        }

        // Action

        store.send(.fetchHouses)

        // Validate

        store.receive(.housesResponse(.success(expectedHouses))) {
            $0.viewState = .loaded(.init(uniqueElements: expectedHouses.map { .init(dataModel: $0) }))
            $0.allHousesLoaded = true
        }
    }

    func testSelectRow_ShouldSetSelection() {
        // Prepare

        let store = self.store

        let houses = Array(0..<10).map { HouseMetadataModel(url: URL(string: "https://duckduckgo.com/house\($0)")!, name: "House \($0)")}
        store.send(.housesResponse(.success(houses))) {
            $0.viewState = .loaded(.init(uniqueElements: houses.map { HouseListRowState(dataModel: $0) }))
        }

        // Action

        let selectedHouse = houses[2]
        store.send(.setSelection(selection: selectedHouse.id)) {
            $0.selection = .init(url: selectedHouse.id)
        }
    }

    func testDeselectRow_ShouldResetSelection() {
        // Prepare

        let store = self.store

        let houses = Array(0..<10).map { HouseMetadataModel(url: URL(string: "https://duckduckgo.com/house\($0)")!, name: "House \($0)")}
        store.send(.housesResponse(.success(houses))) {
            $0.viewState = .loaded(.init(uniqueElements: houses.map { HouseListRowState(dataModel: $0) }))
        }

        // Action

        let selectedHouse = houses[2]
        store.send(.setSelection(selection: selectedHouse.id)) {
            $0.selection = .init(url: selectedHouse.id)
        }

        store.send(.setSelection(selection: nil)) {
            $0.selection = nil
        }
    }

    func testPresentAlert_ShouldSetAlertState() {
        let store = self.store

        let error = HouseListError.fetchError(
            underlying: .init(
                domain: "MockError",
                code: -1,
                userInfo: nil
            )
        )

        store.send(.presentAlert(error: error)) {
            $0.alertState = .init(
                title: TextState("Error"),
                message: TextState(error.localizedDescription)
            )
        }
    }

    func testAlertDismissed_ShouldResetAlertState() {
        let store = self.store

        let error = HouseListError.fetchError(
            underlying: .init(
                domain: "MockError",
                code: -1,
                userInfo: nil
            )
        )

        store.send(.presentAlert(error: error)) {
            $0.alertState = .init(
                title: TextState("Error"),
                message: TextState(error.localizedDescription)
            )
        }

        store.send(.alertDismissed) {
            $0.alertState = nil
        }
    }
}
