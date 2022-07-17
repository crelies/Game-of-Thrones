//
//  HouseDetailView.swift
//  Game-of-Thrones-SwiftUI
//
//  Created Christian Elies on 29.08.21.
//  Copyright © 2021 Christian Elies. All rights reserved.
//
//  Template generated by Christian Elies @crelies
//  https://www.christianelies.de
//

import ComposableArchitecture
import SwiftUI

struct HouseDetailView: View {
    let store: Store<HouseDetailState, HouseDetailAction>

    var body: some View {
        WithViewStore(
            store.scope(
                state: { $0.view },
                action: { (viewAction: HouseDetailView.Action) in
                    viewAction.feature
                }
            )
        ) { viewStore in
            VStack {
                switch viewStore.viewState {
                case let .loaded(dataModel):
                    loaded(viewStore: viewStore, dataModel: dataModel)
                case .loading:
                    ProgressView()
                        .onAppear {
                            viewStore.send(.onAppear)
                        }
                case let .failure(error):
                    Text(error.localizedDescription)
                }
            }
            .navigationTitle(viewStore.viewState.value?.name ?? "House Details")
        }
    }
}

private extension HouseDetailView {
    func loaded(
        viewStore: ViewStore<HouseDetailView.State, Action>,
        dataModel: HouseDataModel
    ) -> some View {
        List {
            HouseFactsView(
                name: dataModel.name,
                region: dataModel.region,
                coatOfArms: dataModel.coatOfArms,
                words: dataModel.words,
                currentLord: dataModel.currentLord,
                heir: dataModel.heir,
                overlord: dataModel.overlord,
                founded: dataModel.founded,
                founder: dataModel.founder,
                diedOut: dataModel.diedOut
            )

            Section(header: Text("\(dataModel.titles.count) Titles")) {
                titles(titles: dataModel.titles)
            }

            Section(header: Text("\(dataModel.seats.count) Seats")) {
                seats(seats: dataModel.seats)
            }

            Section(header: Label("\(dataModel.ancestralWeapons.count) Ancestral Weapons", systemImage: "hammer")) {
                ancestralWeapons(ancestralWeapons: dataModel.ancestralWeapons)
            }

            Section(header: Label("\(dataModel.cadetBranches.count) Cadet Branches", systemImage: "building.columns")) {
                HouseCadetBranchesView(cadetBranches: dataModel.cadetBranches)
            }

            Section(header: Label("\(dataModel.swornMembers.count) Sworn Members", systemImage: "flag.2.crossed")) {
                HouseSwornMembersView(swornMembers: dataModel.swornMembers)
            }
        }
        .navigationDestination(for: URL.self) { url in
            Text(url.absoluteString)
        }
    }
}

private extension HouseDetailView {
    func seats(
        seats: [String]
    ) -> some View {
        ForEach(seats, id: \.self) { seat in
            Text(seat)
        }
    }

    func ancestralWeapons(
        ancestralWeapons: [String]
    ) -> some View {
        ForEach(ancestralWeapons, id: \.self) { ancestralWeapon in
            Text(ancestralWeapon)
        }
    }

    func titles(
        titles: [String]
    ) -> some View {
        ForEach(titles, id: \.self) { title in
            Text(title)
        }
    }
}

struct HouseDetailView_Preview: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HouseDetailView(
                store: .init(
                    initialState: .init(
                        id: "123",
                        url: URL(string: "https://duckduckgo.com")!
                    ),
                    reducer: HouseDetailModule.reducer,
                    environment: .init(
                        mainQueue: { .main.eraseToAnyScheduler() },
                        fetchHouse: { _, _ in
                            let houseDataModel: HouseDataModel = .mock()
                            return Effect(value: houseDataModel)
                        }
                    )
                )
            )
            .frame(minWidth: 400, minHeight: 700)
        }
    }
}
