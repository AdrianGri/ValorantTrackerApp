//
//  UnratedStatsView.swift
//  ValorantTracker
//
//  Created by Adrian Gri on 2020-09-29.
//

import SwiftUI

struct UnratedStatsView: View {
    @Binding var unratedStats: [String: String]
    
    var screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        VStack {
            HStack {
                VStack (alignment: .leading){
                    HStack {
                        VStack (alignment: .leading){
                            Text("Play Time")
                                .font(.system(size: 27, weight: .semibold))
                            Text(unratedStats["playTime"] ?? "1d")
                                .font(.system(size: 27))
                        }.padding(.bottom, 10)
                        Spacer()
                    }
                    HStack {
                        VStack (alignment: .leading){
                            Text("K/D Ratio")
                                .font(.system(size: 27, weight: .semibold))
                            Text(unratedStats["kdRatio"] ?? "1.00")
                                .font(.system(size: 27))
                        }.padding(.bottom, 10)
                        Spacer()
                    }
                    HStack {
                        VStack (alignment: .leading){
                            Text("Kills")
                                .font(.system(size: 27, weight: .semibold))
                            Text(unratedStats["kills"] ?? "0")
                                .font(.system(size: 27))
                        }.padding(.bottom, 10)
                        Spacer()
                    }
                    HStack {
                        VStack (alignment: .leading){
                            Text("Most Kills")
                                .font(.system(size: 27, weight: .semibold))
                            Text(unratedStats["mostKills"] ?? "0")
                                .font(.system(size: 27))
                        }.padding(.bottom, 10)
                        Spacer()
                    }
                    HStack {
                        VStack (alignment: .leading){
                            Text("Headshot %")
                                .font(.system(size: 27, weight: .semibold))
                            Text(unratedStats["headshotPercent"] ?? "0")
                                .font(.system(size: 27))
                        }.padding(.bottom, 10)
                        Spacer()
                    }
                    HStack {
                        VStack (alignment: .leading){
                            Text("Wins")
                                .font(.system(size: 27, weight: .semibold))
                            Text(unratedStats["wins"] ?? "0")
                                .font(.system(size: 27))
                        }.padding(.bottom, 10)
                        Spacer()
                    }
                    Spacer()
                }.frame(width: (screenWidth - 40) / 2)
                VStack (alignment: .leading){
                    HStack {
                        VStack (alignment: .leading){
                            Text("Matches")
                                .font(.system(size: 27, weight: .semibold))
                            Text(unratedStats["matches"] ?? "0")
                                .font(.system(size: 27))
                        }.padding(.bottom, 10)
                        Spacer()
                    }
                    HStack {
                        VStack (alignment: .leading){
                            Text("Kills/Round")
                                .font(.system(size: 27, weight: .semibold))
                            Text(unratedStats["killsPerRound"] ?? "0")
                                .font(.system(size: 27))
                        }.padding(.bottom, 10)
                        Spacer()
                    }
                    HStack {
                        VStack (alignment: .leading){
                            Text("Deaths")
                                .font(.system(size: 27, weight: .semibold))
                            Text(unratedStats["deaths"] ?? "0")
                                .font(.system(size: 27))
                        }.padding(.bottom, 10)
                        Spacer()
                    }
                    HStack {
                        VStack (alignment: .leading){
                            Text("Aces")
                                .font(.system(size: 27, weight: .semibold))
                            Text(unratedStats["aces"] ?? "0")
                                .font(.system(size: 27))
                        }.padding(.bottom, 10)
                        Spacer()
                    }
                    HStack {
                        VStack (alignment: .leading){
                            Text("Win %")
                                .font(.system(size: 27, weight: .semibold))
                            Text(unratedStats["winPercent"] ?? "0")
                                .font(.system(size: 27))
                        }.padding(.bottom, 10)
                        Spacer()
                    }
                    HStack {
                        VStack (alignment: .leading){
                            Text("Losses")
                                .font(.system(size: 27, weight: .semibold))
                            Text(unratedStats["losses"] ?? "0")
                                .font(.system(size: 27))
                        }.padding(.bottom, 10)
                        Spacer()
                    }
                    Spacer()
                }//.frame(width: (screenWidth - 40) / 2)
    //                VStack {
    //                    VStack (alignment: .leading){
    //                        Text("Play Time")
    //                            .font(.title3)
    //                            .fontWeight(.semibold)
    //                        Text("7d")
    //                            .font(.body)
    //                    }.padding(.bottom, 10)
    //                    VStack (alignment: .leading){
    //                        Text("Play Time")
    //                            .font(.title3)
    //                            .fontWeight(.semibold)
    //                        Text("7d")
    //                            .font(.body)
    //                    }.padding(.bottom, 10)
    //                    VStack (alignment: .leading){
    //                        Text("Play Time")
    //                            .font(.title3)
    //                            .fontWeight(.semibold)
    //                        Text("7d")
    //                            .font(.body)
    //                    }
    //                    Spacer()
    //                }.frame(width: (screenWidth - 40) / 3.33)
                Spacer()
            }.frame(maxWidth: .infinity)
        }
    }
}

//struct UnratedStatsView_Previews: PreviewProvider {
//    static var previews: some View {
//        UnratedStatsView()
//    }
//}
