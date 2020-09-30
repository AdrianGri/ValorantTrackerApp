//
//  DeathmatchStatsView.swift
//  ValorantTracker
//
//  Created by Adrian Gri on 2020-09-29.
//

import SwiftUI

struct DeathmatchStatsView: View {
    @Binding var deathmatchStats: [String: String]
    
    var screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        VStack {
            HStack {
                VStack (alignment: .leading){
                    HStack {
                        VStack (alignment: .leading){
                            Text("Play Time")
                                .font(.system(size: 27, weight: .semibold))
                            Text(deathmatchStats["playTime"] ?? "1d")
                                .font(.system(size: 27))
                        }.padding(.bottom, 10)
                        Spacer()
                    }
                    HStack {
                        VStack (alignment: .leading){
                            Text("K/D Ratio")
                                .font(.system(size: 27, weight: .semibold))
                            Text(deathmatchStats["kdRatio"] ?? "1.00")
                                .font(.system(size: 27))
                        }.padding(.bottom, 10)
                        Spacer()
                    }
                    HStack {
                        VStack (alignment: .leading){
                            Text("Kills")
                                .font(.system(size: 27, weight: .semibold))
                            Text(deathmatchStats["kills"] ?? "0")
                                .font(.system(size: 27))
                        }.padding(.bottom, 10)
                        Spacer()
                    }
                    HStack {
                        VStack (alignment: .leading){
                            Text("Most Kills")
                                .font(.system(size: 27, weight: .semibold))
                            Text(deathmatchStats["mostKills"] ?? "0")
                                .font(.system(size: 27))
                        }.padding(.bottom, 10)
                        Spacer()
                    }
                    HStack {
                        VStack (alignment: .leading){
                            Text("Headshot %")
                                .font(.system(size: 27, weight: .semibold))
                            Text(deathmatchStats["headshotPercent"] ?? "0")
                                .font(.system(size: 27))
                        }.padding(.bottom, 10)
                        Spacer()
                    }
                    HStack {
                        VStack (alignment: .leading){
                            Text("Wins")
                                .font(.system(size: 27, weight: .semibold))
                            Text(deathmatchStats["wins"] ?? "0")
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
                            Text(deathmatchStats["matches"] ?? "0")
                                .font(.system(size: 27))
                        }.padding(.bottom, 10)
                        Spacer()
                    }
                    HStack {
                        VStack (alignment: .leading){
                            Text("Kills/Round")
                                .font(.system(size: 27, weight: .semibold))
                            Text(deathmatchStats["killsPerRound"] ?? "0")
                                .font(.system(size: 27))
                        }.padding(.bottom, 10)
                        Spacer()
                    }
                    HStack {
                        VStack (alignment: .leading){
                            Text("Deaths")
                                .font(.system(size: 27, weight: .semibold))
                            Text(deathmatchStats["deaths"] ?? "0")
                                .font(.system(size: 27))
                        }.padding(.bottom, 10)
                        Spacer()
                    }
                    HStack {
                        VStack (alignment: .leading){
                            Text("Aces")
                                .font(.system(size: 27, weight: .semibold))
                            Text(deathmatchStats["aces"] ?? "0")
                                .font(.system(size: 27))
                        }.padding(.bottom, 10)
                        Spacer()
                    }
                    HStack {
                        VStack (alignment: .leading){
                            Text("Win %")
                                .font(.system(size: 27, weight: .semibold))
                            Text(deathmatchStats["winPercent"] ?? "0")
                                .font(.system(size: 27))
                        }.padding(.bottom, 10)
                        Spacer()
                    }
                    HStack {
                        VStack (alignment: .leading){
                            Text("Losses")
                                .font(.system(size: 27, weight: .semibold))
                            Text(deathmatchStats["losses"] ?? "0")
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

//struct DeathmatchStatsView_Previews: PreviewProvider {
//    static var previews: some View {
//        DeathmatchStatsView()
//    }
//}
