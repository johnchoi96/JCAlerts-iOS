//
//  LandingPage.swift
//  JCAlerts
//
//  Created by John Choi on 12/17/23.
//

import SwiftUI

struct LandingPageView: View {
    @ObservedObject var cfService = CloudFirestoreService()

    init() {
        cfService.fetchNotificationPayloads()
    }

    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.horizontal) {
                    HStack(spacing: 15) {
                        ForEach(cfService.trimmedNotificationPayloads) { data in
                            Card(payload: data)
                        }
                        MoreCard()
                        Spacer()
                    }
                    .padding()
                }
                .scrollIndicators(.hidden)
                .padding()

                NavigationLink(destination: UKAlertsView()) {
                    Text("More...")
                        .foregroundStyle(Color(K.Colors.inverseTextColor, bundle: nil))
                        .font(.headline)
                        .frame(width: (UIScreen.current?.bounds.size.width)! * 0.75)
                        .padding()
                        .background(Color(K.Colors.backgroundColor, bundle: nil))
                        .cornerRadius(15)
                }
                .frame(maxWidth: .infinity, alignment: .center)

                Spacer()
            }
            .navigationTitle("Welcome")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    LandingPageView()
}
