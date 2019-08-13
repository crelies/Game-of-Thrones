//
//  HouseSeatsView.swift
//  Game-of-Thrones-VIPER-SwiftUI
//
//  Created by Christian Elies on 03.08.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import SwiftUI

struct HouseSeatsView: View {
    @State private var collapsed: Bool = true
    
    let seats: [String]
    
    var body: some View {
        Group {
            HStack {
                if seats.count > 0 {
                    Button(action: {
                        self.collapsed.toggle()
                    }) {
                        HStack {
                            Image(systemName: collapsed ? "plus" : "minus")
                            Text("\(seats.count) Seats")
                        }
                    }
                } else {
                    Text("\(seats.count) Seats")
                }
            }
            
            if !collapsed {
                ForEach(seats, id: \.self) { seat in
                    Text(seat)
                }
            }
        }
    }
}
