//
//  liveLiveActivity.swift
//  live
//
//  Created by Sam Roman on 2/6/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct ModelDownloadLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: ModelDownloadAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack(spacing: 12) {
                if let error = context.state.error {
                    HStack {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.title2)
                            .foregroundStyle(.red)
                        Text(error)
                            .font(.headline)
                    }
                } else {
                    HStack {
                        Image("Moon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 32, height: 32)
                            .mask(Circle().scale(0.99))
                        
                        Text("Downloading \(context.attributes.modelName)")
                            .font(.headline)
                    }
                    
                    ProgressView(value: context.state.progress, total: 1.0)
                        .tint(.blue)
                    
                    Text("\(Int(context.state.progress * 100))% Complete")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            .padding()
            .activityBackgroundTint(Color(.systemBackground))
            .activitySystemActionForegroundColor(.blue)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here
                DynamicIslandExpandedRegion(.leading) {
                    Label {
                        Text("\(Int(context.state.progress * 100))%")
                            .font(.headline)
                            .foregroundStyle(.primary)
                    } icon: {
                        Image("Moon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                            .mask(Circle().scale(0.99))
                    }
                }
                
                DynamicIslandExpandedRegion(.trailing) {
                    ProgressView(value: context.state.progress, total: 1.0)
                        .tint(.blue)
                }
                
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Downloading \(context.attributes.modelName)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            } compactLeading: {
                Image("Moon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .mask(Circle().scale(0.99))
            } compactTrailing: {
                Text("\(Int(context.state.progress * 100))%")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            } minimal: {
                Image("Moon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .mask(Circle().scale(0.99))
            }
        }
    }
}

// Preview provider for the Live Activity
#Preview("Live Activity", as: .content, using: ModelDownloadAttributes(modelName: "Mistral 7B")) {
    ModelDownloadLiveActivity()
} contentStates: {
    ModelDownloadAttributes.ContentState(progress: 0.25)
    ModelDownloadAttributes.ContentState(progress: 0.5)
    ModelDownloadAttributes.ContentState(progress: 0.75)
}

// Preview provider for the Dynamic Island
#Preview("Dynamic Island", as: .dynamicIsland(.expanded), using: ModelDownloadAttributes(modelName: "Mistral 7B")) {
    ModelDownloadLiveActivity()
} contentStates: {
    ModelDownloadAttributes.ContentState(progress: 0.65)
}

#Preview("Dynamic Island Compact", as: .dynamicIsland(.compact), using: ModelDownloadAttributes(modelName: "Mistral 7B")) {
    ModelDownloadLiveActivity()
} contentStates: {
    ModelDownloadAttributes.ContentState(progress: 0.65)
}

#Preview("Dynamic Island Minimal", as: .dynamicIsland(.minimal), using: ModelDownloadAttributes(modelName: "Mistral 7B")) {
    ModelDownloadLiveActivity()
} contentStates: {
    ModelDownloadAttributes.ContentState(progress: 0.65)
}
