//
//  STime.swift
//  STime
//
//  Created by Punit Thakali on 05/04/2024.
//

import DeviceActivity
import SwiftUI

@main
struct STime: DeviceActivityReportExtension {
    var body: some DeviceActivityReportScene {
        // Create a report for each DeviceActivityReport.Context that your app supports.
        TotalActivityReport { totalActivity in
            TotalActivityView(totalActivity: totalActivity)
        }
        // Add more reports here...
    }
}
