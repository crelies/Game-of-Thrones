//
//  CharacterClient.swift
//  GameOfThrones
//
//  Created by Christian Elies on 17/07/2022.
//  Copyright © 2022 Christian Elies. All rights reserved.
//

import ComposableArchitecture
import Foundation

struct CharacterClient {
    var fetchCharacters: (_ page: Int, _ pageSize: Int) -> Effect<[CharacterMetadataModel], CharacterClientError>
    var fetchCharacter: (URL) -> Effect<CharacterDataModel, CharacterClientError>
}

extension CharacterClient {
    static func live() -> Self {
        .init(
            fetchCharacters: { page, pageSize in
                Effect.task {
                    try await dependencies.apiService.getCharacters(
                        page: page,
                        pageSize: pageSize
                    )
                        .compactMap { character in
                            var name = character.name ?? ""
                            name = name.isEmpty ? "id: \(character.url.pathComponents.last ?? "-")" : name
                            return CharacterMetadataModel(url: character.url, name: name)
                        }
                }
                .mapError { CharacterClientError.fetchError(underlying: $0 as NSError) }
                .eraseToEffect()
            },
            fetchCharacter: { url in
                Effect.task {
                    try await dependencies.apiService.getCharacter(atURL: url).characterDataModel(id: url.absoluteString)
                }
                .mapError { CharacterClientError.fetchError(underlying: $0 as NSError) }
                .eraseToEffect()
            }
        )
    }
}

#if DEBUG
extension CharacterClient {
    static func mock() -> Self {
        .init(
            fetchCharacters: { _, _ in .none },
            fetchCharacter: { _ in .none }
        )
    }
}
#endif
