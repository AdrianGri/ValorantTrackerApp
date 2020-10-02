//
//  MatchCardView.swift
//  ValorantTracker
//
//  Created by Adrian Gri on 2020-09-26.
//

import SwiftUI

struct MatchCardView: View {
    var id: Int //
    var mode: String //
    var mapName: String //
    var roundsWon: String //
    var roundsLost: String //
    var kdRatio: String //
    var score: String //
    var killsPerRound: String //
    var damage: String //
    var result: String //
    var kills: String
    var deaths: String
    var assists: String
    var econRating: String
    var agent: String
    @State var headshots: String //
    @State var bodyshots: String //
    @State var legshots: String //
    var combatScore: String
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            if (colorScheme == .dark) {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color(.sRGB, red: 27/255, green: 28/255, blue: 30/255, opacity: 1))
            } else {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color.white)
            }
            NavigationLink(destination: MatchView(id: id, mode: mode, mapName: mapName, roundsWon: roundsWon, roundsLost: roundsLost, kdRatio: kdRatio, score: score, killsPerRound: killsPerRound, damage: damage, result: result, kills: kills, deaths: deaths, assists: assists, econRating: econRating, agent: agent, headshots: headshots, bodyshots: headshots, legshots: legshots, combatScore: combatScore)) {
            VStack {
    //            Image("turtlerock")
    //                .resizable()
    //                .aspectRatio(contentMode: .fit)
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(mode) - \(mapName)")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        HStack {
                            if (result == "Victory") {
                                Text(result)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.green)
                                    .lineLimit(3)
                            } else if (result == "Defeat") {
                                Text(result)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.red)
                                    .lineLimit(3)
                            } else {
                                Text(result)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                                    .lineLimit(3)
                            }
    //                        Text(mapName)
    //                            .font(.title)
    //                            .fontWeight(.bold)
    //                            .foregroundColor(.primary)
    //                            .lineLimit(3)
    //                        Text(result)
                            Spacer()
                            Text(roundsWon)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.green)
                            Text(":")
                                .font(.title)
                                .fontWeight(.bold)
                            Text(roundsLost)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.red)
                        }.padding(.bottom, 5)
    //                    Text("Written by Simon Ng".uppercased())
    //                        .font(.caption)
    //                        .foregroundColor(.secondary)
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Score")
                                    .font(.body)
                                    .fontWeight(.semibold)
                                Text(score)
                                    .font(.body)
                            }
                            VStack(alignment: .leading) {
                                Text("K/D")
                                    .font(.body)
                                    .fontWeight(.semibold)
                                Text(kdRatio)
                                    .font(.body)
                            }
                            VStack(alignment: .leading) {
                                Text("Kills/Round")
                                    .font(.body)
                                    .fontWeight(.semibold)
                                Text(killsPerRound)
                                    .font(.body)
                            }
                            VStack(alignment: .leading) {
                                Text("Damage")
                                    .font(.body)
                                    .fontWeight(.semibold)
                                Text(damage)
                                    .font(.body)
                            }
                        }.frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .layoutPriority(100)
                    Spacer()
                }
                .padding()
            }
            }
            .cornerRadius(10)
            .buttonStyle(PlainButtonStyle())
//        .overlay(
//            RoundedRectangle(cornerRadius: 10)
//                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
//
//        )
        }
    }
}

struct MatchCardView_Previews: PreviewProvider {
    static var previews: some View {
        MatchCardView(id: 0, mode: "Normal", mapName: "Bind", roundsWon: "11", roundsLost: "14", kdRatio: "1.0", score: "1000", killsPerRound: "10", damage: "2500", result: "Draw", kills: "10", deaths: "10", assists: "10", econRating: "100", agent: "Pheonix", headshots: "10", bodyshots: "10", legshots: "10", combatScore: "100")
    }
}
