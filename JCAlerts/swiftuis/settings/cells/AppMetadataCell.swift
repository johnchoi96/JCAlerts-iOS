//
//  AppMetadataCell.swift
//  JCAlerts
//
//  Created by John Choi on 12/28/23.
//

import SwiftUI

struct AppMetadataCell: View {
    var label: String
    var data: String

    var body: some View {
        HStack { // TODO: spread out
            Text(label)
            Text(data)
        }
    }
}

#Preview {
    AppMetadataCell(label: "LABEL", data: "DATA")
}
