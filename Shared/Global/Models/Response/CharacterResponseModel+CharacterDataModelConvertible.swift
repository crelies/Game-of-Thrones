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
        var fatherURL: URL?
        if let father, !father.isEmpty {
            fatherURL = URL(string: father)!
        }

        var motherURL: URL?
        if let mother, !mother.isEmpty {
            motherURL = URL(string: mother)!
        }

        var spouseURL: URL?
        if let spouse, !spouse.isEmpty {
            spouseURL = URL(string: spouse)!
        }

        return CharacterDataModel(
            id: id,
            url: url,
            name: name ?? "",
            gender: gender ?? "",
            culture: culture ?? "",
            born: born ?? "",
            died: died ?? "",
            titles: titles?.filter { !$0.isEmpty } ?? [],
            aliases: aliases?.filter { !$0.isEmpty } ?? [],
            father: fatherURL,
            mother: motherURL,
            spouse: spouseURL,
            allegiances: allegiances ?? [],
            books: books ?? [],
            povBooks: povBooks ?? [],
            tvSeries: tvSeries?.filter { !$0.isEmpty } ?? [],
            playedBy: playedBy?.filter { !$0.isEmpty } ?? []
        )
    }
}
