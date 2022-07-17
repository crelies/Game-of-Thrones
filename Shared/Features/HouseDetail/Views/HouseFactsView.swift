//
//  HouseFactsView.swift
//  Game-of-Thrones-SwiftUI
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
            VStack(alignment: .leading) {
                Text("Name")
                    .font(.caption)
                    .foregroundColor(.secondary)

                Text(name)
                    .lineLimit(nil)
            }

            VStack(alignment: .leading) {
                Text("Region")
                    .font(.caption)
                    .foregroundColor(.secondary)

                Label(region, systemImage: "mappin.and.ellipse")
            }

            VStack(alignment: .leading) {
                Text("Coat of arms")
                    .font(.caption)
                    .foregroundColor(.secondary)

                Label(coatOfArms, systemImage: "bookmark")
            }

            VStack(alignment: .leading) {
                Text("Words")
                    .font(.caption)
                    .foregroundColor(.secondary)

                Text(words)
                    .lineLimit(nil)
            }

            VStack(alignment: .leading) {
                Text("Founded")
                    .font(.caption)
                    .foregroundColor(.secondary)

                Label(founded, systemImage: "calendar")
            }

            VStack(alignment: .leading) {
                Text("Died out")
                    .font(.caption)
                    .foregroundColor(.secondary)

                Label(diedOut, systemImage: "calendar")
            }
        }

        Section(header: Text("Links")) {
            VStack(alignment: .leading) {
                if let currentLord {
                    NavigationLink(value: currentLord) {
                        Label {
                            Text("Current lord (id: \(currentLord.pathComponents.last ?? ""))")
                        } icon: {
                            Image(systemName: "crown")
                        }
                    }
                } else {
                    Text("Current lord")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Text("-")
                }
            }

            VStack(alignment: .leading) {
                if let heir {
                    NavigationLink(value: heir) {
                        Label {
                            Text("Heir (id: \(heir.pathComponents.last ?? ""))")
                        } icon: {
                            Image(systemName: "person")
                        }
                    }
                } else {
                    Text("Heir")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Text("-")
                }
            }

            VStack(alignment: .leading) {
                if let overlord {
                    NavigationLink(value: overlord) {
                        Label {
                            Text("Overlord (id: \(overlord.pathComponents.last ?? ""))")
                        } icon: {
                            Image(systemName: "house")
                        }
                    }
                } else {
                    Text("Overlord")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Text("-")
                }
            }

            VStack(alignment: .leading) {
                if let founder {
                    NavigationLink(value: founder) {
                        Label {
                            Text("Founder (id: \(founder.pathComponents.last ?? ""))")
                        } icon: {
                            if founder.absoluteString.contains("house") {
                                Image(systemName: "house")
                            } else if founder.absoluteString.contains("character") {
                                Image(systemName: "person")
                            }
                        }
                    }
                } else {
                    Text("Founder")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Text("-")
                }
            }
        }
    }
}

struct HouseFactsView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            HouseFactsView(
                name: "House name",
                region: "House region",
                coatOfArms: "House Code of Arms House Code of Arms House Code of Arms House Code of Arms House Code of Arms House Code of Arms House Code of Arms House Code of Arms",
                words: "House of Words",
                currentLord: URL(string: "https://duckduckgo.com")!,
                heir: URL(string: "https://duckduckgo.com")!,
                overlord: URL(string: "https://duckduckgo.com")!,
                founded: "1990",
                founder: URL(string: "https://duckduckgo.com")!,
                diedOut: "Unknown"
            )
        }
    }
}
