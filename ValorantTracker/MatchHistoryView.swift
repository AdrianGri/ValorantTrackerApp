//
//  MatchHistoryView.swift
//  ValorantTracker
//
//  Created by Adrian Gri on 2020-09-27.
//

import SwiftUI

struct MatchHistoryView: View {
    @Binding var matchInfo: [[String]]
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(0 ..< matchInfo[0].count, id: \.self) { i in
                    MatchCardView(id: i, mode: matchInfo[0][i] , mapName: matchInfo[1][i] , roundsWon: matchInfo[2][i] , roundsLost: matchInfo[3][i] , kdRatio: matchInfo[4][i] , score: matchInfo[5][i] , killsPerRound: matchInfo[6][i] , damage: matchInfo[7][i], result: matchInfo[8][i])
                }
            }
            .padding(.horizontal, 20)
        }
        .navigationBarTitle("Match History")
    }
}

//struct MatchHistoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        MatchHistoryView()
//    }
//}
