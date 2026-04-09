//
//  WristDashWidgetBundle.swift
//  WristDashWidget
//
//  Created by Nader Alfares on 4/9/26.
//

import WidgetKit
import SwiftUI

@main
struct WristDashWidgetBundle: WidgetBundle {
    var body: some Widget {
        WristDashWidget()
        WristDashWidgetControl()
        WristDashWidgetLiveActivity()
    }
}
