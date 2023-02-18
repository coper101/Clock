//
//  ContentView.swift
//  Clock
//
//  Created by Wind Versi on 18/2/23.
//

import SwiftUI
import CoreData

enum TabItem: String {
    case worldClock = "World Clock"
    case alarm = "Alarm"
    case stopwatch = "Stop Watch"
    case timer = "Timer"
    
    var iconName: String {
        switch self {
        case .worldClock:
            return "globe"
        case .alarm:
            return "alarm.fill"
        case .stopwatch:
            return "stopwatch.fill"
        case .timer:
            return "timer"
        }
    }
}

struct AppView: View {
    // MARK: - Props
    @State private var selectedTabItem: TabItem = .worldClock
    
    let cities: [City] = [
        .init(name: "Singapore", time: "23:00"),
        .init(name: "Vienna", time: "18:00")
    ]
    
    // Core Data
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default
    )
    private var items: FetchedResults<Item>

    // MARK: - UI
    var body: some View {
        TabView(selection: $selectedTabItem) {
            WorldClockView(cities: cities)
                .tabItem {
                    Label(
                        TabItem.worldClock.rawValue,
                        systemImage: TabItem.worldClock.iconName
                    )
                }
            
            AlarmView()
                .tabItem {
                    Label(
                        TabItem.alarm.rawValue,
                        systemImage: TabItem.alarm.iconName
                    )
                }
            
            StopwatchView()
                .tabItem {
                    Label(
                        TabItem.stopwatch.rawValue,
                        systemImage: TabItem.stopwatch.iconName
                    )
                }
            
            TimerView()
                .tabItem {
                    Label(
                        TabItem.timer.rawValue,
                        systemImage: TabItem.timer.iconName
                    )
                }
        } //: TabView
    }

    // MARK: - Actions
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
