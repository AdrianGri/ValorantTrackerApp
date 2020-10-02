//
//  MatchHistoryView.swift
//  ValorantTracker
//
//  Created by Adrian Gri on 2020-09-27.
//

import SwiftUI

struct MatchHistoryView: View {
    @Binding var matchInfo: [String: [String]]
    
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
                    ForEach(0 ..< matchInfo["result"]!.count, id: \.self) { i in
//                        MatchCardView(id: i, mode: matchInfo[0][i] , mapName: matchInfo[1][i] , roundsWon: matchInfo[2][i] , roundsLost: matchInfo[3][i] , kdRatio: matchInfo[4][i] , score: matchInfo[5][i] , killsPerRound: matchInfo[6][i] , damage: matchInfo[7][i], result: matchInfo[8][i])
                        MatchCardView(id: i, mode: matchInfo["modeName"]![i], mapName: matchInfo["mapName"]![i], roundsWon: matchInfo["roundsWon"]![i], roundsLost: matchInfo["roundsLost"]![i], kdRatio: matchInfo["kdRatio"]![i], score: matchInfo["score"]![i], killsPerRound: matchInfo["killsPerRound"]![i], damage: matchInfo["damage"]![i], result: matchInfo["result"]![i], kills: matchInfo["kills"]![i], deaths: matchInfo["deaths"]![i], assists: matchInfo["assists"]![i], econRating: matchInfo["econRating"]![i], agent: matchInfo["agent"]![i], headshots: matchInfo["headshots"]![i], bodyshots: matchInfo["bodyshots"]![i], legshots: matchInfo["legshots"]![i], combatScore: matchInfo["combatScore"]![i])
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
