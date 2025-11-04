//
//  MyMapDiaryWidget.swift
//  MyMapDiaryWidget
//
//  Created by Jerico Villaraza on 11/4/25.
//

import WidgetKit
import SwiftUI

// MARK: - Provider

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        // You don’t need multiple entries for static widgets like this
        let entry = SimpleEntry(date: Date())
        return Timeline(entries: [entry], policy: .never)
    }
}

// MARK: - Entry

struct SimpleEntry: TimelineEntry {
    let date: Date
}

// MARK: - Widget View

struct MyMapDiaryWidgetEntryView: View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family

    var body: some View {
        switch family {
        case .accessoryCircular:
            ZStack {
                Image(systemName: "mappin.and.ellipse")
                    .font(.system(size: 30))
            }
            // Tap → open Add Entry in app
            .widgetURL(URL(string: "mymapdiary://addEntry"))

        case .accessoryRectangular:
            HStack {
                Image(systemName: "mappin.and.ellipse")
                Text("Add Diary ✨")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white.opacity(0.95))
            }
            .padding(6)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.accentColor.cornerRadius(8))
            .widgetURL(URL(string: "mymapdiary://addEntry"))

        default:
            ZStack {
                VStack {
                    Image(systemName: "mappin.and.ellipse")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundStyle(.white)
                        .padding(.bottom, 6)
                    
                    Text("Add Diary ✨")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white.opacity(0.95))
                }
            }
            .widgetURL(URL(string: "mymapdiary://addEntry"))
        }
    }
}

// MARK: - Widget Definition

struct MyMapDiaryWidget: Widget {
    let kind: String = "MyMapDiaryWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            MyMapDiaryWidgetEntryView(entry: entry)
                .containerBackground(for: .widget) {
                    Color.clear
                }
        }
        .configurationDisplayName("Quick Add")
        .description("Quickly add a new diary entry.")
        .supportedFamilies([
            .systemSmall,
            .accessoryCircular,
            .accessoryRectangular
        ])
    }
}

// MARK: - Preview

#Preview(as: .accessoryRectangular) {
    MyMapDiaryWidget()
} timeline: {
    SimpleEntry(date: .now)
}
