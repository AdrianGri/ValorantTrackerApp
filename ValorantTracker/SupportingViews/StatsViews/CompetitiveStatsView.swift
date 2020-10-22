//
//  CompetitiveStatsView.swift
//  ValorantTracker
//
//  Created by Adrian Gri on 2020-09-29.
//

import SwiftUI

struct CompetitiveStatsView: View {
    var competitiveStats: [String: String]
    
    var screenWidth = UIScreen.main.bounds.width
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ScrollView (showsIndicators: false){
        VStack {
//            if ((competitiveStats["rankName"]) != "unrated") {
//                HStack {
//                    Image(competitiveStats["rankName"] ?? "Gold 2")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 50, height: 50)
//                    Text(competitiveStats["rankName"] ?? "Gold 2")
//                        .font(.system(size: 40, weight: .bold))
//                        .font(.title)
//                        .fontWeight(.bold)
//                        .padding(.leading, 5)
//                    Spacer()
//                }
//            }
            HStack {
                VStack (alignment: .leading){
                    HStack {
                        ZStack {
                            if (colorScheme == .dark) {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                            .fill(Color(.sRGB, red: 27/255, green: 28/255, blue: 30/255, opacity: 1))
                        } else {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color.white)
                        }
                            HStack {
                                VStack (alignment: .leading){
                                    Text("Play Time")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                    Text(competitiveStats["playTime"] ?? "0")
                                        .font(.body)
                                }
                                Spacer()
                            }.padding(.all, 10)
                        }.padding(.bottom, 5)
                        Spacer()
                    }
                    HStack {
                        ZStack {
                            if (colorScheme == .dark) {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                            .fill(Color(.sRGB, red: 27/255, green: 28/255, blue: 30/255, opacity: 1))
                        } else {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color.white)
                        }
                            HStack {
                                VStack (alignment: .leading){
                                    Text("K/D Ratio")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                    Text(competitiveStats["kdRatio"] ?? "0")
                                        .font(.body)
                                }
                                Spacer()
                            }.padding(.all, 10)
                        }.padding(.bottom, 5)
                        Spacer()
                    }
                    HStack {
                        ZStack {
                            if (colorScheme == .dark) {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                            .fill(Color(.sRGB, red: 27/255, green: 28/255, blue: 30/255, opacity: 1))
                        } else {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color.white)
                        }
                            HStack {
                                VStack (alignment: .leading){
                                    Text("Kills")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                    Text(competitiveStats["kills"] ?? "0")
                                        .font(.body)
                                }
                                Spacer()
                            }.padding(.all, 10)
                        }.padding(.bottom, 5)
                        Spacer()
                    }
                    HStack {
                        ZStack {
                            if (colorScheme == .dark) {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                            .fill(Color(.sRGB, red: 27/255, green: 28/255, blue: 30/255, opacity: 1))
                        } else {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color.white)
                        }
                            HStack {
                                VStack (alignment: .leading){
                                    Text("Most Kills")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                    Text(competitiveStats["mostKills"] ?? "0")
                                        .font(.body)
                                }
                                Spacer()
                            }.padding(.all, 10)
                        }.padding(.bottom, 5)
                        Spacer()
                    }
                    HStack {
                        ZStack {
                            if (colorScheme == .dark) {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                            .fill(Color(.sRGB, red: 27/255, green: 28/255, blue: 30/255, opacity: 1))
                        } else {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color.white)
                        }
                            HStack {
                                VStack (alignment: .leading){
                                    Text("Headshot %")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                    Text(competitiveStats["headshotPercent"] ?? "0")
                                        .font(.body)
                                }
                                Spacer()
                            }.padding(.all, 10)
                        }.padding(.bottom, 5)
                        Spacer()
                    }
                    HStack {
                        ZStack {
                            if (colorScheme == .dark) {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                            .fill(Color(.sRGB, red: 27/255, green: 28/255, blue: 30/255, opacity: 1))
                        } else {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color.white)
                        }
                            HStack {
                                VStack (alignment: .leading){
                                    Text("Wins")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                    Text(competitiveStats["wins"] ?? "0")
                                        .font(.body)
                                }
                                Spacer()
                            }.padding(.all, 10)
                        }.padding(.bottom, 5)
                        Spacer()
                    }
                    Spacer()
                }.frame(width: (screenWidth - 40) / 2)
                VStack (alignment: .leading){
                    HStack {
                        ZStack {
                            if (colorScheme == .dark) {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                            .fill(Color(.sRGB, red: 27/255, green: 28/255, blue: 30/255, opacity: 1))
                        } else {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color.white)
                        }
                            HStack {
                                VStack (alignment: .leading){
                                    Text("Matches")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                    Text(competitiveStats["matches"] ?? "0")
                                        .font(.body)
                                }
                                Spacer()
                            }.padding(.all, 10)
                        }.padding(.bottom, 5)
                        Spacer()
                    }
                    HStack {
                        ZStack {
                            if (colorScheme == .dark) {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                            .fill(Color(.sRGB, red: 27/255, green: 28/255, blue: 30/255, opacity: 1))
                        } else {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color.white)
                        }
                            HStack {
                                VStack (alignment: .leading){
                                    Text("Kills/Round")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                    Text(competitiveStats["killsPerRound"] ?? "0")
                                        .font(.body)
                                }
                                Spacer()
                            }.padding(.all, 10)
                        }.padding(.bottom, 5)
                        Spacer()
                    }
                    HStack {
                        ZStack {
                            if (colorScheme == .dark) {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                            .fill(Color(.sRGB, red: 27/255, green: 28/255, blue: 30/255, opacity: 1))
                        } else {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color.white)
                        }
                            HStack {
                                VStack (alignment: .leading){
                                    Text("Deaths")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                    Text(competitiveStats["deaths"] ?? "0")
                                        .font(.body)
                                }
                                Spacer()
                            }.padding(.all, 10)
                        }.padding(.bottom, 5)
                        Spacer()
                    }
                    HStack {
                        ZStack {
                            if (colorScheme == .dark) {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                            .fill(Color(.sRGB, red: 27/255, green: 28/255, blue: 30/255, opacity: 1))
                        } else {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color.white)
                        }
                            HStack {
                                VStack (alignment: .leading){
                                    Text("Aces")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                    Text(competitiveStats["aces"] ?? "0")
                                        .font(.body)
                                }
                                Spacer()
                            }.padding(.all, 10)
                        }.padding(.bottom, 5)
                        Spacer()
                    }
                    HStack {
                        ZStack {
                            if (colorScheme == .dark) {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                            .fill(Color(.sRGB, red: 27/255, green: 28/255, blue: 30/255, opacity: 1))
                        } else {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color.white)
                        }
                            HStack {
                                VStack (alignment: .leading){
                                    Text("Win %")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                    Text(competitiveStats["winPercent"] ?? "0")
                                        .font(.body)
                                }
                                Spacer()
                            }.padding(.all, 10)
                        }.padding(.bottom, 5)
                        Spacer()
                    }
                    HStack {
                        ZStack {
                            if (colorScheme == .dark) {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                            .fill(Color(.sRGB, red: 27/255, green: 28/255, blue: 30/255, opacity: 1))
                        } else {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color.white)
                        }
                            HStack {
                                VStack (alignment: .leading){
                                    Text("Losses")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                    Text(competitiveStats["losses"] ?? "0")
                                        .font(.body)
                                }
                                Spacer()
                            }.padding(.all, 10)
                        }.padding(.bottom, 5)
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
    //                    }.padding(.bottom, 5)
    //                    VStack (alignment: .leading){
    //                        Text("Play Time")
    //                            .font(.title3)
    //                            .fontWeight(.semibold)
    //                        Text("7d")
    //                            .font(.body)
    //                    }.padding(.bottom, 5)
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
            .padding(.top, 5)
        }
        }
    }
}

//struct CompetitiveStatsView_Previews: PreviewProvider {
//    static var previews: some View {
//        CompetitiveStatsView()
//    }
//}
