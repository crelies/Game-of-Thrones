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

    private lazy var store = TestStore(
        initialState: HouseListState(pageSize: pageSize),
        reducer: HouseListModule.reducer,
        environment: HouseListEnvironment(
            mainQueue: { self.scheduler.eraseToAnyScheduler() },
            fetchHouses: { _, _ in .none },
            fetchHouse: { _, _ in .none }
        )
    )

    func testOnAppearSetSelectedHouse() {

    }

    func testRefresh() {
        let house = HouseMetadataModel(url: URL(string: "https://duckduckgo.com")!, name: "House 1")
        store.assert(
            .environment {
                $0.fetchHouses = { _, _ in
                    Effect(value: [house]).eraseToEffect()
                }
            },
            .send(.refresh),
            .receive(.fetchHouses) {
                $0.viewState = .loading()
            },
            .receive(.housesResponse(.success([house]))) {
                $0.allHousesLoaded = true
                $0.viewState = .loaded(.init(uniqueElements: [HouseListRowState(id: house.id.absoluteString, dataModel: house)]))
            }
        )
    }

    func testFetchNextHouses() {
        let houses = Array(0..<10).map { HouseMetadataModel(url: URL(string: "https://duckduckgo.com/house\($0)")!, name: "House \($0)")}
        let nextHouses = Array(10..<20).map { HouseMetadataModel(url: URL(string: "https://duckduckgo.com/house\($0)")!, name: "House \($0)")}

        store.assert(
            .environment {
                $0.fetchHouses = { page, _ in
                    if page == 1 {
                        return Effect(value: houses)
                    } else {
                        return Effect(value: nextHouses)
                    }
                }
            },
            .send(.housesResponse(.success(houses))) {
                $0.viewState = .loaded(.init(uniqueElements: houses.map { HouseListRowState(id: $0.id.absoluteString, dataModel: $0) }))
            },
            .send(.row(index: houses[0].id.absoluteString, action: .onAppear)),
            .send(.row(index: houses.last!.id.absoluteString, action: .onAppear))
//            .receive(.fetchNextHouses) {
//                $0.page = $0.page + 1
//                if var lastRowState = $0.rowStates.last {
////                    lastRowState.isLoading = true
//                    $0.rowStates.updateOrAppend(lastRowState)
//                }
//            },
//            .receive(.nextHousesResponse(.success(nextHouses))) {
//                if var lastRowState = $0.rowStates.last {
////                    lastRowState.isLoading = false
//                    $0.rowStates.updateOrAppend(lastRowState)
//                }
//                for newHouse in nextHouses {
//                    $0.rowStates.append(.init(id: newHouse.id.absoluteString, dataModel: newHouse))
//                }
//            }
        )
    }

    func testAllHousesLoaded() {
        let houses = Array(0..<10).map { HouseMetadataModel(url: URL(string: "https://duckduckgo.com/house\($0)")!, name: "House \($0)")}
        let expectedHouses = Array(houses.prefix(pageSize - 1))

        store.assert(
            .environment {
                $0.fetchHouses = { page, pageSize in
                    Effect(value: expectedHouses)
                }
            },
            .send(.fetchHouses) {
                $0.viewState = .loading()
            },
            .receive(.housesResponse(.success(expectedHouses))) {
                $0.viewState = .loaded(.init(uniqueElements: expectedHouses.map { house in HouseListRowState(id: house.id.absoluteString, dataModel: house) }))
                $0.allHousesLoaded = true
            }
        )
    }

    func testSetSelected() {
        let houses = Array(0..<10).map { HouseMetadataModel(url: URL(string: "https://duckduckgo.com/house\($0)")!, name: "House \($0)")}
        let selectedHouse = houses[2]
        let expectedHouseDataModel: HouseDataModel = .init(
            id: selectedHouse.id.absoluteString,
            url: selectedHouse.id,
            name: selectedHouse.name,
            region: "",
            coatOfArms: "",
            words: "",
            titles: [],
            seats: [],
            currentLord: nil,
            heir: nil,
            overlord: nil,
            founded: "",
            founder: nil,
            diedOut: "",
            ancestralWeapons: [],
            cadetBranches: [],
            swornMembers: []
        )

        store.assert(
            .environment {
                $0.fetchHouse = { id, url in
                    Effect(value: expectedHouseDataModel)
                }
            },
            .send(.housesResponse(.success(houses))) {
                $0.viewState = .loaded(.init(uniqueElements: houses.map { HouseListRowState(id: $0.id.absoluteString, dataModel: $0) }))
            }
            // Set selection
//            .send(.row(index: selectedHouse.id.absoluteString, action: .setSelected(selected: true))),
            // Start fetching
//            .receive(.row(index: selectedHouse.id.absoluteString, action: .fetchHouse(id: selectedHouse.id.absoluteString))) {
//                if var rowState = $0.rowStates.first(where: { $0.id == selectedHouse.id.absoluteString }) {
////                    rowState.isLoading = true
//                    $0.rowStates.updateOrAppend(rowState)
//                }
//            },
            // Select house (remember selection in list)
//            .receive(.selectHouse(selection: selectedHouse.id.absoluteString)) {
//                $0.selection = selectedHouse.id.absoluteString
//            },
//            .receive(.row(index: selectedHouse.id.absoluteString, action: .houseResponse(id: selectedHouse.id.absoluteString, .success(expectedHouseDataModel)))) {
//                if var rowState = $0.rowStates.first(where: { $0.id == selectedHouse.id.absoluteString }) {
////                    rowState.isLoading = false
////                    rowState.houseDetailState = .init(dataModel: expectedHouseDataModel)
//                    $0.rowStates.updateOrAppend(rowState)
//                }
//            },
            // Call set selection again after successful loading, this time the row will be selected
//            .receive(.row(index: selectedHouse.id.absoluteString, action: .setSelected(selected: true))) {
//                if var rowState = $0.rowStates.first(where: { $0.id == selectedHouse.id.absoluteString }) {
////                    rowState.selected = true
//                    $0.rowStates.updateOrAppend(rowState)
//                }
//            },
            // Finally select house
//            .receive(.selectHouse(selection: selectedHouse.id.absoluteString)) {
//                if var rowState = $0.rowStates.first(where: { $0.id == selectedHouse.id.absoluteString }) {
////                    rowState.selected = true
//                    $0.rowStates.updateOrAppend(rowState)
//                }
//            }
        )
    }

    func testPresentAlert() {
        let error = HouseListError.fetchError(underlying: .init(domain: "MockError", code: -1, userInfo: nil))
        store.assert(
            .send(.presentAlert(error: error)) {
                $0.alertState = .init(title: TextState("Error"), message: TextState(error.localizedDescription))
            }
        )
    }

    func testAlertDismissed() {
        let error = HouseListError.fetchError(underlying: .init(domain: "MockError", code: -1, userInfo: nil))
        store.assert(
            .send(.presentAlert(error: error)) {
                $0.alertState = .init(title: TextState("Error"), message: TextState(error.localizedDescription))
            },
            .send(.alertDismissed) {
                $0.alertState = nil
            }
        )
    }
}
