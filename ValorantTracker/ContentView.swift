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
//    override func viewDidLoad() {
        
//    }
    @Binding var competitiveStats: [String: String]
    @Binding var unratedStats: [String: String]
    @Binding var deathmatchStats: [String: String]
    
//    @Binding var textToUpdate: String
//    @Binding var kdRatio: String
//    @Binding var winPercent: String
//    @Binding var killsPerRound: String
//    @Binding var wins: String
//    @Binding var rankName: String
    
    @Binding var matchInfo: [[String]]
    
    //@State var i = 0
    var UIState: UIStateModel = UIStateModel()
    
    var body: some View {
        //NavigationView {
            ScrollView {
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
                            NavigationLink(destination: StatsView(competitiveStats: $competitiveStats, unratedStats: $unratedStats, deathmatchStats: $deathmatchStats)) {
                                Text("More >")
                            }
                        }
//                        OverviewCardView(id: 0, kdRatio: kdRatio, winPercent: winPercent, killsPerRound: killsPerRound, wins: wins, rankImage: rankName)
                        SnapCarousel(UIState: UIState, competitiveStats: competitiveStats, unratedStats: unratedStats, deathmatchStats: deathmatchStats)
                        HStack {
                            Text("Recent Match")
                                .font(.title)
                                .fontWeight(.bold)
                            Spacer()
                            NavigationLink(destination: MatchHistoryView(matchInfo: self.$matchInfo)) {
                                Text("Match History >")
                            }
                            .navigationBarTitle("Summary")
                        }
                        VStack {
                            if (matchInfo[0].count > 0) {
                                MatchCardView(id: 0, mode: matchInfo[0][0], mapName: matchInfo[1][0], roundsWon: matchInfo[2][0], roundsLost: matchInfo[3][0], kdRatio: matchInfo[4][0], score: matchInfo[5][0], killsPerRound: matchInfo[6][0], damage: matchInfo[7][0], result: matchInfo[8][0])
                            }
//                            ForEach(0 ..< matchInfo[0].count, id: \.self) { i in
//                                MatchCardView(mode: matchInfo[0][i] , mapName: matchInfo[1][i] , roundsWon: matchInfo[2][i] , roundsLost: matchInfo[3][i] , kdRatio: matchInfo[4][i] , score: matchInfo[5][i] , killsPerRound: matchInfo[6][i] , damage: matchInfo[7][i] )
//                            }
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    Spacer()
                }
            //}
        }
        .navigationBarTitle("Summary")
        //.navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
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
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
