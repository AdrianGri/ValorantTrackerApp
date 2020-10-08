//
//  StatsView.swift
//  ValorantTracker
//
//  Created by Adrian Gri on 2020-09-29.
//

import SwiftUI

struct StatsView: View {
    
//    @Binding var competitiveStats: [String: String]
//    @Binding var unratedStats: [String: String]
//    @Binding var deathmatchStats: [String: String]
    
    @State private var selectedTab: Int = 0
    
    var screenWidth = UIScreen.main.bounds.width
    
    @EnvironmentObject var allData: AllData
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            if (colorScheme == .dark) {
                Color.black
                    .ignoresSafeArea()
            } else {
                Color(.sRGB, red: 241/255, green: 242/255, blue: 246/255, opacity: 1)
                    .ignoresSafeArea()
            }
            VStack {
                Picker(selection: $selectedTab, label: Text("Chosen mode")) {
                                Text("Competitive").tag(0)
                                Text("Unrated").tag(1)
                                Text("Deathmatch").tag(2)
                            }.pickerStyle(SegmentedPickerStyle())
                if (selectedTab == 0) {
                    CompetitiveStatsView(competitiveStats: self.allData.competitiveStats)
                } else if (selectedTab == 1) {
                    CompetitiveStatsView(competitiveStats: self.allData.unratedStats)
                    //UnratedStatsView(unratedStats: $unratedStats)
                } else {
                    CompetitiveStatsView(competitiveStats: self.allData.deathmatchStats)
                    //DeathmatchStatsView(deathmatchStats: $deathmatchStats)
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
}

//struct StatsView_Previews: PreviewProvider {
//    static var previews: some View {
//        StatsView()
//    }
//}
