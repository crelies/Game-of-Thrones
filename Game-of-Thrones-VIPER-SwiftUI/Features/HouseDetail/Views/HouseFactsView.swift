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
                    Text("Name")
                        .font(.headline)
                        .frame(width: 110, alignment: .leading)
                    Text(self.name)
                        .lineLimit(nil)
                }
                
                HStack {
                    Text("Region")
                        .font(.headline)
                        .frame(width: 110, alignment: .leading)
                    Text(self.region)
                        .lineLimit(nil)
                }
                
                HStack {
                    Text("Coat of arms")
                        .font(.headline)
                        .frame(width: 110, alignment: .leading)
                    Text(self.coatOfArms)
                        .lineLimit(nil)
                }
                
                HStack {
                    Text("Words")
                        .font(.headline)
                        .frame(width: 110, alignment: .leading)
                    Text(self.words)
                        .lineLimit(nil)
                }
                
                HStack {
                    Text("Founded")
                        .font(.headline)
                        .frame(width: 110, alignment: .leading)
                    Text(self.founded)
                        .lineLimit(nil)
                }
                
                HStack {
                    Text("Died out")
                        .font(.headline)
                        .frame(width: 110, alignment: .leading)
                    Text(self.diedOut)
                        .lineLimit(nil)
                }
            }
                
            Section {
                HStack {
                    Text("Current lord")
                        .font(.headline)
                        .frame(width: 110, alignment: .leading)
                    Text(self.currentLord?.absoluteString ?? "-")
                        .lineLimit(nil)
                }
                
                HStack {
                    Text("Heir")
                        .font(.headline)
                        .frame(width: 110, alignment: .leading)
                    Text(self.heir?.absoluteString ?? "-")
                        .lineLimit(nil)
                }
                
                HStack {
                    Text("Overlord")
                        .font(.headline)
                        .frame(width: 110, alignment: .leading)
                    Text(self.overlord?.absoluteString ?? "-")
                        .lineLimit(nil)
                }
                
                HStack {
                    Text("Founder")
                        .font(.headline)
                        .frame(width: 110, alignment: .leading)
                    Text(self.founder?.absoluteString ?? "-")
                        .lineLimit(nil)
                }
            }
        }
    }
}

#if DEBUG
struct HouseFactsView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            HouseFactsView(name: "House name",
                           region: "House region",
                           coatOfArms: "House Code of Arms",
                           words: "House of Words",
                           currentLord: nil,
                           heir: nil,
                           overlord: nil,
                           founded: "1990",
                           founder: nil,
                           diedOut: "Unknown")
        }
    }
}
#endif
