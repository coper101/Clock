//
//  WorldClockView.swift
//  Clock
//
//  Created by Wind Versi on 18/2/23.
//

import SwiftUI

struct City: Identifiable {
    let id = UUID()
    let name: String
    let time: String
}

struct WorldClockView: View {
    // MARK: - Props
    var cities: [City]
    
    // MARK: - UI
    var body: some View {
        NavigationView {
            List {
                
                ForEach(cities) { city in
                    Button(action: {}) {
                        HStack(spacing: 0) {
                            
                            // COUNTRY
                            VStack {
                                Text(city.name)
                                    .font(.headline)

                                Text(city.name)
                                    .font(.headline)
                            }
                            
                            // TIME
                            Spacer()
                            Text(city.time)
                                .font(.largeTitle)
                                .fontWeight(.light)
                        }
                        .padding(.vertical, 12)
                    }
                }
                .onDelete(perform: { _ in })
                
            }
            .listStyle(.plain)
            .navigationBarTitle(TabItem.worldClock.rawValue)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {}) {
                        Label("Add", systemImage: "plus")
                    }
                }
            }
        }
    }
    
    // MARK: - Actions
}

// MARK: - Preview
struct WorldClockView_Previews: PreviewProvider {
    static var cities: [City] = [
        .init(name: "Singapore", time: "23:00"),
        .init(name: "Vienna", time: "18:00")
    ]
    static var previews: some View {
        WorldClockView(cities: cities)
            .previewLayout(.sizeThatFits)
    }
}
