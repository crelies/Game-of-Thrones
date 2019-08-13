//
//  HouseSwornMembersView.swift
//  Game-of-Thrones-VIPER-SwiftUI
//
//  Created by Christian Elies on 03.08.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import SwiftUI

struct HouseSwornMembersView: View {
    @State private var collapsed: Bool = true
    
    let swornMembers: [URL]
    
    var body: some View {
        Group {
            HStack {
                if swornMembers.count > 0 {
                    Button(action: {
                        self.collapsed.toggle()
                    }) {
                        HStack {
                            Image(systemName: collapsed ? "plus" : "minus")
                            Text("\(swornMembers.count) Sworn members")
                        }
                    }
                } else {
                    Text("\(swornMembers.count) Sworn members")
                }
            }
            
            if !collapsed {
                ForEach(swornMembers, id: \.self) { swornMember in
                    Text(swornMember.absoluteString)
                }
            }
        }
    }
}
