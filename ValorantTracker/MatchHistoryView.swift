//
//  MatchHistoryView.swift
//  ValorantTracker
//
//  Created by Adrian Gri on 2020-09-27.
//

import SwiftUI

struct MatchHistoryView: View {
    //@Binding var matchInfo: [String: [String]]
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
            ScrollView {
                VStack {
                    ForEach(0 ..< self.allData.matchInfo["result"]!.count, id: \.self) { i in
//                        MatchCardView(id: i, mode: matchInfo[0][i] , mapName: matchInfo[1][i] , roundsWon: matchInfo[2][i] , roundsLost: matchInfo[3][i] , kdRatio: matchInfo[4][i] , score: matchInfo[5][i] , killsPerRound: matchInfo[6][i] , damage: matchInfo[7][i], result: matchInfo[8][i])
                        MatchCardView(id: i, mode: self.allData.matchInfo["modeName"]![i], mapName: self.allData.matchInfo["mapName"]![i], roundsWon: self.allData.matchInfo["roundsWon"]![i], roundsLost: self.allData.matchInfo["roundsLost"]![i], kdRatio: self.allData.matchInfo["kdRatio"]![i], score: self.allData.matchInfo["score"]![i], killsPerRound: self.allData.matchInfo["killsPerRound"]![i], damage: self.allData.matchInfo["damage"]![i], result: self.allData.matchInfo["result"]![i], kills: self.allData.matchInfo["kills"]![i], deaths: self.allData.matchInfo["deaths"]![i], assists: self.allData.matchInfo["assists"]![i], econRating: self.allData.matchInfo["econRating"]![i], agent: self.allData.matchInfo["agent"]![i], headshots: self.allData.matchInfo["headshots"]![i], bodyshots: self.allData.matchInfo["bodyshots"]![i], legshots: self.allData.matchInfo["legshots"]![i], combatScore: self.allData.matchInfo["combatScore"]![i])
                    }
                }
                .padding(.horizontal, 20)
            }
            .navigationBarTitle("Match History")
        }
    }
}

//struct MatchHistoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        MatchHistoryView()
//    }
//}
