//
//  CompetitiveStatsView.swift
//  ValorantTracker
//
//  Created by Adrian Gri on 2020-09-29.
//

import SwiftUI

struct CompetitiveStatsView: View {
    @Binding var competitiveStats: [String: String]
    
    var screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        VStack {
            HStack {
                Image(competitiveStats["rankName"] ?? "Gold 2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                Text(competitiveStats["rankName"] ?? "Gold 2")
                    .font(.system(size: 40, weight: .bold))
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.leading, 5)
                Spacer()
            }
            HStack {
                VStack (alignment: .leading){
                    HStack {
                        VStack (alignment: .leading){
                            Text("Play Time")
                                .font(.system(size: 27, weight: .semibold))
                            Text(competitiveStats["playTime"] ?? "1d")
                                .font(.system(size: 27))
                        }.padding(.bottom, 10)
                        Spacer()
                    }
                    HStack {
                        VStack (alignment: .leading){
                            Text("K/D Ratio")
                                .font(.system(size: 27, weight: .semibold))
                            Text(competitiveStats["kdRatio"] ?? "1.00")
                                .font(.system(size: 27))
                        }.padding(.bottom, 10)
                        Spacer()
                    }
                    HStack {
                        VStack (alignment: .leading){
                            Text("Kills")
                                .font(.system(size: 27, weight: .semibold))
                            Text(competitiveStats["kills"] ?? "0")
                                .font(.system(size: 27))
                        }.padding(.bottom, 10)
                        Spacer()
                    }
                    HStack {
                        VStack (alignment: .leading){
                            Text("Most Kills")
                                .font(.system(size: 27, weight: .semibold))
                            Text(competitiveStats["mostKills"] ?? "0")
                                .font(.system(size: 27))
                        }.padding(.bottom, 10)
                        Spacer()
                    }
                    HStack {
                        VStack (alignment: .leading){
                            Text("Headshot %")
                                .font(.system(size: 27, weight: .semibold))
                            Text(competitiveStats["headshotPercent"] ?? "0")
                                .font(.system(size: 27))
                        }.padding(.bottom, 10)
                        Spacer()
                    }
                    HStack {
                        VStack (alignment: .leading){
                            Text("Wins")
                                .font(.system(size: 27, weight: .semibold))
                            Text(competitiveStats["wins"] ?? "0")
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
                            Text(competitiveStats["matches"] ?? "0")
                                .font(.system(size: 27))
                        }.padding(.bottom, 10)
                        Spacer()
                    }
                    HStack {
                        VStack (alignment: .leading){
                            Text("Kills/Round")
                                .font(.system(size: 27, weight: .semibold))
                            Text(competitiveStats["killsPerRound"] ?? "0")
                                .font(.system(size: 27))
                        }.padding(.bottom, 10)
                        Spacer()
                    }
                    HStack {
                        VStack (alignment: .leading){
                            Text("Deaths")
                                .font(.system(size: 27, weight: .semibold))
                            Text(competitiveStats["deaths"] ?? "0")
                                .font(.system(size: 27))
                        }.padding(.bottom, 10)
                        Spacer()
                    }
                    HStack {
                        VStack (alignment: .leading){
                            Text("Aces")
                                .font(.system(size: 27, weight: .semibold))
                            Text(competitiveStats["aces"] ?? "0")
                                .font(.system(size: 27))
                        }.padding(.bottom, 10)
                        Spacer()
                    }
                    HStack {
                        VStack (alignment: .leading){
                            Text("Win %")
                                .font(.system(size: 27, weight: .semibold))
                            Text(competitiveStats["winPercent"] ?? "0")
                                .font(.system(size: 27))
                        }.padding(.bottom, 10)
                        Spacer()
                    }
                    HStack {
                        VStack (alignment: .leading){
                            Text("Losses")
                                .font(.system(size: 27, weight: .semibold))
                            Text(competitiveStats["losses"] ?? "0")
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

//struct CompetitiveStatsView_Previews: PreviewProvider {
//    static var previews: some View {
//        CompetitiveStatsView()
//    }
//}
