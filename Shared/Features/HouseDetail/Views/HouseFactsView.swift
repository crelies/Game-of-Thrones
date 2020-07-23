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
        Section(header: Text("Facts")) {
            HStack {
                Text("Name")
                    .font(.headline)
                Spacer()
                Text(name)
                    .lineLimit(nil)
            }

            HStack {
                Text("Region")
                    .font(.headline)
                Spacer()
                Text(region)
                    .lineLimit(nil)
            }

            HStack {
                Text("Coat of arms")
                    .font(.headline)
                Spacer()
                Text(coatOfArms)
                    .lineLimit(nil)
            }

            HStack {
                Text("Words")
                    .font(.headline)
                Spacer()
                Text(words)
                    .lineLimit(nil)
            }

            HStack {
                Text("Founded")
                    .font(.headline)
                Spacer()
                Text(founded)
                    .lineLimit(nil)
            }

            HStack {
                Text("Died out")
                    .font(.headline)
                Spacer()
                Text(diedOut)
                    .lineLimit(nil)
            }

            HStack {
                Text("Current lord")
                    .font(.headline)
                Spacer()
                currentLord.map { currentLord in
                    Link(destination: currentLord) {
                        Text(currentLord.absoluteString)
                    }
                }
            }

            HStack {
                Text("Heir")
                    .font(.headline)
                Spacer()
                heir.map { heir in
                    Link(destination: heir) {
                        Text(heir.absoluteString)
                    }
                }
            }

            HStack {
                Text("Overlord")
                    .font(.headline)
                Spacer()
                overlord.map { overlord in
                    Link(destination: overlord) {
                        Text(overlord.absoluteString)
                    }
                }
            }

            HStack {
                Text("Founder")
                    .font(.headline)
                Spacer()
                founder.map { founder in
                    Link(destination: founder) {
                        Text(founder.absoluteString)
                    }
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
