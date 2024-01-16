//
//  CategoryCell.swift
//  JCAlerts
//
//  Created by John Choi on 12/18/23.
//

import SwiftUI
import os

struct CategoryCell: View {
    @State var isOn: Bool = false

    var topic: FCMTopic

    private let logger = Logger()

    private let topicService = FCMTopicService.instance

    var body: some View {
        HStack {
            Toggle(isOn: $isOn, label: {
                Text(topic.getTopicName())
            })
            .onChange(of: isOn) { _, newValue in
                if newValue {
                    topicService.subscribe(toTopic: topic)
                } else {
                    topicService.unsubscribe(fromTopic: topic)
                }
                logger.info("\(topicService.getTopicsAsStrings())")
            }
            .padding()
        }
        .onAppear(perform: {
            isOn = topicService.topicIsSubscribed(topic: topic)
        })
    }
}

#Preview {
    CategoryCell(topic: .ALL)
}
