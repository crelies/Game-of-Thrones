//
//  CharacterDetailView.swift
//  Game-of-Thrones-SwiftUI
//
//  Created Christian Elies on 17/07/2022.
//  Copyright © 2022 Christian Elies. All rights reserved.
//
//  Template generated by Christian Elies @crelies
//  https://www.christianelies.de
//

import ComposableArchitecture
import SwiftUI

struct CharacterDetailView: View {
    let store: Store<CharacterDetailState, CharacterDetailAction>

    var body: some View {
        WithViewStore(
            store.scope(
                state: { $0.view },
                action: { (viewAction: CharacterDetailView.Action) in
                    viewAction.feature
                }
            )
        ) { viewStore in
            VStack {
                switch viewStore.viewState {
                case .loading:
                    ProgressView()
                        .onAppear {
                            viewStore.send(.onAppear)
                        }
                case let .loaded(character):
                    loadedView(character: character, viewStore: viewStore)
                case let .failure(error):
                    Text(error.localizedDescription)
                }
            }
            #if os(macOS)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(viewStore.viewState.value?.name ?? "Character details")
                }
            }
            #else
            .navigationTitle(viewStore.viewState.value?.name ?? "Character details")
            #endif
        }
    }
}

private extension CharacterDetailView {
    @ViewBuilder
    func loadedView(
        character: CharacterDataModel,
        viewStore: ViewStore<CharacterDetailView.State, Action>
    ) -> some View {
        List {
            Section(header: Text("General")) {
                LabeledContent("Name", value: character.name)
                LabeledContent("Gender", value: character.gender)
                LabeledContent("Culture", value: character.culture)

                LabeledContent {
                    Text(character.born)
                } label: {
                    Label("Born", systemImage: "calendar")
                }

                LabeledContent {
                    Text(character.died)
                } label: {
                    Label("Died", systemImage: "clock")
                }
            }

            Section(header: Text("Titles")) {
                ForEach(character.titles, id: \.self) { title in
                    Text(title)
                }
            }

            Section(header: Text("Aliases")) {
                ForEach(character.aliases, id: \.self) { alias in
                    Text(alias)
                }
            }

            Section(header: Label("Family", systemImage: "person.3")) {
                if let father = character.father {
                    Button {
                        viewStore.send(.setSelectedCharacter(url: father))
                    } label: {
                        Label("Father", systemImage: "person")
                    }

                }

                if let mother = character.mother {
                    Button {
                        viewStore.send(.setSelectedCharacter(url: mother))
                    } label: {
                        Label("Mother", systemImage: "person")
                    }
                }

                if let spouse = character.spouse {
                    Button {
                        viewStore.send(.setSelectedCharacter(url: spouse))
                    } label: {
                        Label("Spouse", systemImage: "person")
                    }
                }
            }

            Section(header: Label("Allegiances", systemImage: "flag.2.crossed")) {
                ForEach(character.allegiances, id: \.self) { allegiance in
                    Button {
                        viewStore.send(.setSelectedHouse(url: allegiance))
                    } label: {
                        Label("House (id: \(allegiance.pathComponents.last ?? "-"))", systemImage: "house")
                    }
                }
            }

            Section(header: Label("Books", systemImage: "book")) {
                ForEach(character.books, id: \.self) { book in
                    Button {
                        viewStore.send(.setSelectedBook(url: book))
                    } label: {
                        Text("Book (id: \(book.pathComponents.last ?? "-"))")
                    }
                }
            }

            Section(header: Label("POV Books", systemImage: "book")) {
                ForEach(character.povBooks, id: \.self) { povBook in
                    Button {
                        viewStore.send(.setSelectedBook(url: povBook))
                    } label: {
                        Text("Book (id: \(povBook.pathComponents.last ?? "-"))")
                    }
                }
            }

            Section(header: Label("TV Series", systemImage: "tv")) {
                ForEach(character.tvSeries, id: \.self) { tvSeries in
                    Text(tvSeries)
                }
            }

            Section(header: Label("Played by", systemImage: "person")) {
                ForEach(character.playedBy, id: \.self) { playedBy in
                    Text(playedBy)
                }
            }
        }
    }
}

struct CharacterDetailView_Preview: PreviewProvider {
    static var previews: some View {
        CharacterDetailView(
            store: .init(
                initialState: .init(url: URL(string: "https://duckduckgo.com")!),
                reducer: CharacterDetailModule.reducer,
                environment: .init(
                    mainQueue: { .main.eraseToAnyScheduler() },
                    fetchCharacter: { _ in
                        Effect(
                            value: .mock()
                        )
                    }
                )
            )
        )
    }
}
