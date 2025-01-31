//
//  AppView.swift
//  HomeworkPlanner
//
//  Created by Jake Correnti on 8/17/20.
//  Copyright © 2020 Jake Correnti. All rights reserved.
//

import SwiftUI

struct AppView: View {
    var body: some View {
        TabView {
            AssignmentsView()
                .tabItem {
                    Text("Assignments")
                    Image(systemName: Images.clipboard)
            }
            
            CoursesView()
                .tabItem {
                    Text("Courses")
                    Image(systemName: Images.book)
            }
            
            SettingsView()
                .tabItem {
                    Text("Settings")
                    Image(systemName: Images.gear)
            }
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
