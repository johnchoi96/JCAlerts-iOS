//
//  ResourceCell.swift
//  JCAlerts
//
//  Created by John Choi on 1/15/24.
//

import SwiftUI

struct ResourceCell: View {
    var label: String
    var url: URL

    var body: some View {
        HStack {
            Link(destination: url, label: {
                Text(label)
            })
            .foregroundStyle(.primary)
            Spacer()
            Image(systemName: "link.circle")
        }
    }
}
