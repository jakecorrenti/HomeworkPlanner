//
//  SettingsView.swift
//  HomeworkPlanner
//
//  Created by Jake Correnti on 8/24/20.
//  Copyright © 2020 Jake Correnti. All rights reserved.
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Image(Images.personalIcon)
                        .resizable()
                        .frame(width: 75, height: 75)
                        .clipShape(Circle())
                    VStack(alignment: .leading) {
                        Text("Hey, I'm Jake!")
                            .bold()
                            .font(Font(UIFont.preferredFont(forTextStyle: .title3)))
                        Text("I'm the one who made this app. I hope you like it 😁")
                            .foregroundColor(.secondary)
                            .font(.body)
                    }
                }
                .padding([.horizontal, .top])
                EmptyView()
                List {
                    Text("🙌 Thank you for the support")
                    Text("📷 My Instagram")
                        .onTapGesture {
                            let instagramHooks = "https://www.instagram.com/jaketheprogrammer/"
                            let instagramUrl = NSURL(string: instagramHooks)
                            if UIApplication.shared.canOpenURL(instagramUrl! as URL) {
                                UIApplication.shared.open(instagramUrl! as URL)
                            } else {
                              //redirect to safari because the user doesn't have Instagram
                                UIApplication.shared.open(NSURL(string: "https://www.instagram.com/jaketheprogrammer/")! as URL)
                            }
                    }
                    Text("🐦 My Twitter")
                        .onTapGesture {
                            let twitterHooks = "https://twitter.com/jaketheprogramr"
                            let twitterURL = NSURL(string: twitterHooks)
                            if UIApplication.shared.canOpenURL(twitterURL! as URL) {
                                UIApplication.shared.open(twitterURL! as URL)
                            } else {
                              //redirect to safari because the user doesn't have Instagram
                                UIApplication.shared.open(NSURL(string: "https://twitter.com/jaketheprogramr")! as URL)
                            }
                    }
                    Text("⭐️ Review BusyWork")
                        .onTapGesture {
                            SKStoreReviewController.requestReview()
                    }
                    Text("🛡 Privacy policy")
                        .onTapGesture {
                            let policyHooks = "https://busywork.flycricket.io/privacy.html"
                            let policyURL = NSURL(string: policyHooks)
                            if UIApplication.shared.canOpenURL(policyURL! as URL) {
                                UIApplication.shared.open(policyURL! as URL)
                            }
                    }
                    Text("📜 Terms and Conditions")
                        .onTapGesture {
                            let policyHooks = "https://busywork.flycricket.io/terms.html"
                            let policyURL = NSURL(string: policyHooks)
                            if UIApplication.shared.canOpenURL(policyURL! as URL) {
                                UIApplication.shared.open(policyURL! as URL)
                            }
                    }
                }
                .listStyle(GroupedListStyle())
                .font(.headline)
            }
            .navigationBarTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
