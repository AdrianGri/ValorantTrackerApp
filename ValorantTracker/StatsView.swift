//
//  StatsView.swift
//  ValorantTracker
//
//  Created by Adrian Gri on 2020-09-29.
//

import SwiftUI

struct StatsView: View {
    
    @Binding var competitiveStats: [String: String]
    @Binding var unratedStats: [String: String]
    @Binding var deathmatchStats: [String: String]
    
    @State private var selectedTab: Int = 0
    
    var screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        VStack {
            Picker(selection: $selectedTab, label: Text("Chosen mode")) {
                            Text("Competitive").tag(0)
                            Text("Unrated").tag(1)
                            Text("Deathmatch").tag(2)
                        }.pickerStyle(SegmentedPickerStyle())
            if (selectedTab == 0) {
                CompetitiveStatsView(competitiveStats: $competitiveStats)
            } else if (selectedTab == 1) {
                UnratedStatsView(unratedStats: $unratedStats)
            } else {
                DeathmatchStatsView(deathmatchStats: $deathmatchStats)
            }
//            HStack {
//                VStack (alignment: .leading) {
//                    Text("Time Played")
//                        .font(.title3)
//                        .fontWeight(.semibold)
//                    Text("7d")
//                        .font(.body)
//                }
//                VStack (alignment: .leading) {
//                    Text("Matches")
//                        .font(.title3)
//                        .fontWeight(.semibold)
//                    Text("100")
//                        .font(.body)
//                }
//                VStack (alignment: .leading) {
//                    Text("Aces")
//                        .font(.title3)
//                        .fontWeight(.semibold)
//                    Text("3")
//                        .font(.body)
//                }
//                Spacer()
//            }.padding(.bottom, 10)
//            HStack {
//                VStack (alignment: .leading) {
//                    Text("K/D Ratio")
//                        .font(.title3)
//                        .fontWeight(.semibold)
//                    Text("100")
//                        .font(.body)
//                }
//                VStack (alignment: .leading) {
//                    Text("Kills")
//                        .font(.title3)
//                        .fontWeight(.semibold)
//                    Text("100")
//                        .font(.body)
//                }
//                VStack (alignment: .leading) {
//                    Text("Deaths")
//                        .font(.title3)
//                        .fontWeight(.semibold)
//                    Text("100")
//                        .font(.body)
//                }
//                Spacer()
//            }
            Spacer()
        }
        .padding(.horizontal, 20)
        .navigationBarTitle("Stats")
    }
}

//struct StatsView_Previews: PreviewProvider {
//    static var previews: some View {
//        StatsView()
//    }
//}
