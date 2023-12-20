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

    @State private var isModalPresented = false

    var body: some View {
        VStack {
            VStack {
                Text(payload.notificationTitle)
                    .font(.system(size: 35))
                    .lineLimit(3)
                    .truncationMode(.tail)
                    .fontWeight(.heavy)
                    // Align text content to the leading edge
                    .multilineTextAlignment(.leading)
                    // Align the frame to the leading edge
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(payload.notificationSubtitle)
                    .font(.system(size: 30))
                    .lineLimit(5)
                    .truncationMode(.tail)
                    // Align text content to the leading edge
                    .multilineTextAlignment(.leading)
                    // Align the frame to the leading edge
                    .frame(maxWidth: .infinity, alignment: .leading)

                Spacer()

                HStack {
                    Text(payload.timestamp.formattedDate)
                        .font(.system(size: 10))
                    Text(formatTopicName())
                        // Align text content to the trailing edge
                        .multilineTextAlignment(.trailing)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
            // Make the entire VStack tappable
            .contentShape(Rectangle())
            .onTapGesture {
                isModalPresented.toggle()
            }
            .padding()
            .frame(width: 300, height: 400)
            .background(Color(K.Colors.backgroundColor, bundle: nil))
            .cornerRadius(15)
            .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 0, y: 5)
        }
        .sheet(isPresented: $isModalPresented) {
            UKNotificationDetailView(payload: payload)
        }
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
                    // Align text content to the leading edge
                    .multilineTextAlignment(.center)
                    // Align the frame to the leading edge
                    .frame(maxWidth: .infinity, alignment: .center)
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
