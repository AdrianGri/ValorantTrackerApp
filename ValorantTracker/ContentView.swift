//
//  ContentView.swift
//  ValorantTracker
//
//  Created by Adrian Gri on 2020-09-22.
//

import SwiftUI
import SwiftSoup
import WebKit
import Foundation

struct ContentView: View {
    @EnvironmentObject var allData: AllData
//    override func viewDidLoad() {
        
//    }
//    @Binding var competitiveStats: [String: String]
//    @Binding var unratedStats: [String: String]
//    @Binding var deathmatchStats: [String: String]
//
////    @Binding var textToUpdate: String
////    @Binding var kdRatio: String
////    @Binding var winPercent: String
////    @Binding var killsPerRound: String
////    @Binding var wins: String
////    @Binding var rankName: String
//
//    @Binding var matchInfo: [String: [String]]
//    @Binding var competitiveAgentInfo: [String: [String]]
//    @Binding var unratedAgentInfo: [String: [String]]
    
    @State private var selectedTab: Int = 0
    
    //@State var i = 0
    var UIState: UIStateModel = UIStateModel()
    
    @Environment(\.colorScheme) var colorScheme
    
    @State private var showingChildView = false
    
    var body: some View {
        ZStack {
            if (colorScheme == .light) {
                Color(.sRGB, red: 241/255, green: 242/255, blue: 246/255, opacity: 1)
                    .ignoresSafeArea()
            } else {
                Color.black
                    .ignoresSafeArea()
            }
        //NavigationView {
            ScrollView {
                ZStack {
                    if (colorScheme == .dark) {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(Color(.sRGB, red: 27/255, green: 28/255, blue: 30/255, opacity: 1))
                            .frame(maxHeight: 80)
                    } else {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color.white)
                            .frame(maxHeight: 80)
                    }
                    VStack {
                        HStack {
                            Image("\(allData.competitiveAgentInfo["agentName"]![0].lowercased())_icon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40.0, height: 40.0)
                            Text("\(allData.accountName)#\(allData.accountID)")
                                .font(.title)
                                .fontWeight(.bold)
                                .padding(.horizontal, 10)
                            Spacer()
                        }
                        .padding()
                    }
                    .cornerRadius(10)
                }
                .padding(.horizontal, 20)
                HStack {
                    VStack(alignment: .leading) {
    //                    Text("Valorant Tracker").font(.title).fontWeight(.bold).foregroundColor(.black)
    //                    Text(textToUpdate)
    //                    Text(kdRatio)
                        HStack {
                            Text("Stats")
                                .font(.title)
                                .fontWeight(.bold)
                            Spacer()
                            NavigationLink(destination: StatsView()) {
                                Text("More >")
                            }
                        }
//                        OverviewCardView(id: 0, kdRatio: kdRatio, winPercent: winPercent, killsPerRound: killsPerRound, wins: wins, rankImage: rankName)
                        SnapCarousel(UIState: UIState, competitiveStats: self.allData.competitiveStats, unratedStats: self.allData.unratedStats, deathmatchStats: self.allData.deathmatchStats)
                        HStack {
                            Text("Recent Match")
                                .font(.title)
                                .fontWeight(.bold)
                            Spacer()
                            NavigationLink(destination: MatchHistoryView()) {
                                Text("Match History >")
                            }
                            .navigationBarTitle("Summary")
                        }
                        VStack {
                            if (self.allData.matchInfo["result"]!.count > 0) {
//                                MatchCardView(id: 0, mode: matchInfo[0][0], mapName: matchInfo[1][0], roundsWon: matchInfo[2][0], roundsLost: matchInfo[3][0], kdRatio: matchInfo[4][0], score: matchInfo[5][0], killsPerRound: matchInfo[6][0], damage: matchInfo[7][0], result: matchInfo[8][0])
//                            }
                                MatchCardView(id: 0, mode: self.allData.matchInfo["modeName"]![0], mapName: self.allData.matchInfo["mapName"]![0], roundsWon: self.allData.matchInfo["roundsWon"]![0], roundsLost: self.allData.matchInfo["roundsLost"]![0], kdRatio: self.allData.matchInfo["kdRatio"]![0], score: self.allData.matchInfo["score"]![0], killsPerRound: self.allData.matchInfo["killsPerRound"]![0], damage: self.allData.matchInfo["damage"]![0], result: self.allData.matchInfo["result"]![0], kills: self.allData.matchInfo["kills"]![0], deaths: self.allData.matchInfo["deaths"]![0], assists: self.allData.matchInfo["assists"]![0], econRating: self.allData.matchInfo["econRating"]![0], agent: self.allData.matchInfo["agent"]![0], headshots: self.allData.matchInfo["headshots"]![0], bodyshots: self.allData.matchInfo["bodyshots"]![0], legshots: self.allData.matchInfo["legshots"]![0], combatScore: self.allData.matchInfo["combatScore"]![0])
                            }
//                            ForEach(0 ..< matchInfo[0].count, id: \.self) { i in
//                                MatchCardView(mode: matchInfo[0][i] , mapName: matchInfo[1][i] , roundsWon: matchInfo[2][i] , roundsLost: matchInfo[3][i] , kdRatio: matchInfo[4][i] , score: matchInfo[5][i] , killsPerRound: matchInfo[6][i] , damage: matchInfo[7][i] )
//                            }
                        }
                        HStack {
                            Text("Agents")
                                .font(.title)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        VStack {
                            Picker(selection: $selectedTab, label: Text("Chosen mode")) {
                                Text("Competitive").tag(0)
                                Text("Unrated").tag(1)
                            }.pickerStyle(SegmentedPickerStyle())
                            if (selectedTab == 0) {
                                ForEach(0 ..< self.allData.competitiveAgentInfo["kdRatio"]!.count, id: \.self) { i in
                                    AgentCardView(agentName: self.allData.competitiveAgentInfo["agentName"]![i], agentRole: self.allData.competitiveAgentInfo["agentRole"]![i], winPercent: self.allData.competitiveAgentInfo["winPercent"]![i], kdRatio: self.allData.competitiveAgentInfo["kdRatio"]![i], timePlayed: self.allData.competitiveAgentInfo["timePlayed"]![i])
                                }
                            } else {
                                ForEach(0 ..< self.allData.unratedAgentInfo["kdRatio"]!.count, id: \.self) { i in
                                    AgentCardView(agentName: self.allData.unratedAgentInfo["agentName"]![i], agentRole: self.allData.unratedAgentInfo["agentRole"]![i], winPercent: self.allData.unratedAgentInfo["winPercent"]![i], kdRatio: self.allData.unratedAgentInfo["kdRatio"]![i], timePlayed: self.allData.unratedAgentInfo["timePlayed"]![i])
                                }
                            }
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    Spacer()
                    NavigationLink(
                        destination: Settings(), isActive: self.$showingChildView) {
                        EmptyView()
                        
                    }
                    .frame(width: 0, height: 0)
                    .disabled(true)
                }
                .navigationBarItems(
                trailing: Button(action:{ self.showingChildView = true }) { Text("Settings") })
            }
            //}
        }
//            .navigationBarItems(trailing: NavigationLink(destination: Settings()) {
//                Text("Settings")
//            })
        .navigationBarTitle("Summary")
        //.navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}



    
    
//    func getHTMLData(completionHandler: (_ result: String, _ error: String) -> Void){
//        var result: String = "nothing"
//        var error: String = "nothing error"
//
//        do {
//            let html = try String(contentsOf: URL(string: "https://tracker.gg/valorant/profile/riot/leafs%23000/overview?playlist=competitive")!)
//            result = html
//        } catch Exception.Error(let type, let message) {
//            print(message)
//        } catch {
//            //error = "there was an error"
//            print("error")
//        }
//        completionHandler(result, error) // return data & close
//    }


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
