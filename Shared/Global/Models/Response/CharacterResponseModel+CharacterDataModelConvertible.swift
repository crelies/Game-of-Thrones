//
//  CharacterResponseModel+CharacterDataModelConvertible.swift
//  GameOfThrones
//
//  Created by Christian Elies on 17/07/2022.
//  Copyright © 2022 Christian Elies. All rights reserved.
//

import Foundation

extension CharacterResponseModel: CharacterDataModelConvertible {
    func characterDataModel(id: String) throws -> CharacterDataModel {
        CharacterDataModel(
            id: id,
            url: url,
            name: name ?? "",
            gender: gender ?? "",
            culture: culture ?? "",
            born: born ?? "",
            died: died ?? "",
            titles: titles?.filter { !$0.isEmpty } ?? [],
            aliases: aliases?.filter { !$0.isEmpty } ?? [],
            father: father.map { $0 }.map { URL(string: $0)! },
            mother: mother.map { $0 }.map { URL(string: $0)! },
            spouse: spouse.map { $0 }.map { URL(string: $0)! },
            allegiances: allegiances ?? [],
            books: books ?? [],
            povBooks: povBooks ?? [],
            tvSeries: tvSeries?.filter { !$0.isEmpty } ?? [],
            playedBy: playedBy?.filter { !$0.isEmpty } ?? []
        )
    }
}
