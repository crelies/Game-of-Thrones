//
//  StyleConstants.swift
//  GameOfThrones
//
//  Created by Christian Elies on 17/07/2022.
//  Copyright © 2022 Christian Elies. All rights reserved.
//

import SwiftUI

enum StyleConstants {
    static var houseListStyle: some ListStyle {
        #if os(macOS)
        return InsetListStyle(alternatesRowBackgrounds: true)
        #else
        return InsetGroupedListStyle()
        #endif
    }
}
