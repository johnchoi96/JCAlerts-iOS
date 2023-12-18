//
//  Card.swift
//  JCAlerts
//
//  Created by John Choi on 12/16/23.
//

import SwiftUI

struct Card: View {
    var payload: NotificationPayload

    let screenWidth = UIScreen.main.bounds.width

    var body: some View {
        VStack {
            Text(payload.notificationTitle)
                .font(.system(size: 35))
                .lineLimit(3)
                .truncationMode(.tail)
                .fontWeight(.heavy)
                .multilineTextAlignment(.leading) // Align text content to the leading edge
                .frame(maxWidth: .infinity, alignment: .leading) // Align the frame to the leading edge
            Text(payload.notificationSubtitle)
                .font(.system(size: 30))
                .lineLimit(5)
                .truncationMode(.tail)
                .multilineTextAlignment(.leading) // Align text content to the leading edge
                .frame(maxWidth: .infinity, alignment: .leading) // Align the frame to the leading edge

            Spacer()
            HStack {
                Text(payload.timestamp.formattedDate)
                    .font(.system(size: 10))
                Text(formatTopicName())
                    .multilineTextAlignment(.trailing) // Align text content to the trailing edge
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }

        }
        .padding()
        .frame(width: 300, height: 400)
        .background(Color(K.Colors.backgroundColor, bundle: nil))
        .cornerRadius(15)
        .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 0, y: 5)
    }

    private func formatTopicName() -> String {
        return "#\(payload.topic.getTopicName().lowercased())"
    }
}

struct MoreCard: View {
    let screenWidth = UIScreen.main.bounds.width

    var body: some View {
        NavigationLink(destination: UKAlertsView()) {
            VStack {
                Text("Tap to see more...")
                    .font(.system(size: 30))
                    .multilineTextAlignment(.center) // Align text content to the leading edge
                    .frame(maxWidth: .infinity, alignment: .center) // Align the frame to the leading edge
                Image(systemName: "arrowshape.right")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50)
            }
            .padding()
            .frame(width: 300, height: 400)
            .background(Color(K.Colors.backgroundColor, bundle: nil))
            .cornerRadius(15)
            .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 0, y: 5)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
//    Card(payload: NotificationPayload(id: UUID(), notificationTitle: "Title", notificationSubtitle: "Subtitle", notificationId: UUID().uuidString, message: "message", timestamp: Date.distantPast, topic: .ALL, isHtml: false, isTestMessage: true))
    MoreCard()
}
