//
//  HouseFactsView.swift
//  Game-of-Thrones-VIPER-SwiftUI
//
//  Created by Christian Elies on 03.08.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import SwiftUI

struct HouseFactsView: View {
    let name: String
    let region: String
    let coatOfArms: String
    let words: String
    let currentLord: URL?
    let heir: URL?
    let overlord: URL?
    let founded: String
    let founder: URL?
    let diedOut: String
    
    var body: some View {
        Group {
            Section {
                HStack {
                    Text("Name:")
                        .font(.headline)
                    Text(name)
                        .lineLimit(nil)
                }
                
                HStack {
                    Text("Region:")
                        .font(.headline)
                    Text(region)
                        .lineLimit(nil)
                }
                
                HStack {
                    Text("Coat of arms:")
                        .font(.headline)
                    Text(coatOfArms)
                        .lineLimit(nil)
                }
                
                HStack {
                    Text("Words:")
                        .font(.headline)
                    Text(words)
                        .lineLimit(nil)
                }
                
                HStack {
                    Text("Founded:")
                        .font(.headline)
                    Text(founded)
                        .lineLimit(nil)
                }
                
                HStack {
                    Text("Died out:")
                        .font(.headline)
                    Text(diedOut)
                        .lineLimit(nil)
                }
            }
                
            Section {
                HStack {
                    Text("Current lord:")
                        .font(.headline)
                    Text(currentLord?.absoluteString ?? "-")
                        .lineLimit(nil)
                }
                
                HStack {
                    Text("Heir:")
                        .font(.headline)
                    Text(heir?.absoluteString ?? "-")
                        .lineLimit(nil)
                }
                
                HStack {
                    Text("Overlord:")
                        .font(.headline)
                    Text(overlord?.absoluteString ?? "-")
                        .lineLimit(nil)
                }
                
                HStack {
                    Text("Founder:")
                        .font(.headline)
                    Text(founder?.absoluteString ?? "-")
                        .lineLimit(nil)
                }
            }
        }
    }
}
