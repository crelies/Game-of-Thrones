//
//  HouseSwornMembersView.swift
//  Game-of-Thrones-SwiftUI
//
//  Created by Christian Elies on 03.08.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import SwiftUI

struct HouseSwornMembersView: View {
    let swornMembers: [URL]

    var body: some View {
        ForEach(swornMembers, id: \.self) { swornMember in
            NavigationLink(value: swornMember) {
                Label {
                    Text("Member (id: \(swornMember.pathComponents.last ?? ""))")
                } icon: {
                    if swornMember.absoluteString.contains("house") {
                        Image(systemName: "house")
                    } else if swornMember.absoluteString.contains("character") {
                        Image(systemName: "person")
                    }
                }
            }
        }
    }
}

struct HouseSwornMembersView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            HouseSwornMembersView(swornMembers: [
                URL(string: "https://duckduckgo.com")!
            ])
        }
    }
}
