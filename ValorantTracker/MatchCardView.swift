//
//  MatchCardView.swift
//  ValorantTracker
//
//  Created by Adrian Gri on 2020-09-26.
//

import SwiftUI

struct MatchCardView: View {
    var mode: String
    var mapName: String
    var roundsWon: String
    var roundsLost: String
    var kdRatio: String
    var score: String
    var killsPerRound: String
    var damage: String
    
    
    var body: some View {
        VStack {
//            Image("turtlerock")
//                .resizable()
//                .aspectRatio(contentMode: .fit)
            HStack {
                VStack(alignment: .leading) {
                    Text(mode)
                        .font(.headline)
                        .foregroundColor(.secondary)
                    HStack {
                        Text(mapName)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                            .lineLimit(3)
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
                    }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, alignment: .leading)
                }
                .layoutPriority(100)
                Spacer()
            }
            .padding()
        }
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
                
        )
    }
}

struct MatchCardView_Previews: PreviewProvider {
    static var previews: some View {
        MatchCardView(mode: "Normal", mapName: "Bind", roundsWon: "11", roundsLost: "14", kdRatio: "1.0", score: "1000", killsPerRound: "10", damage: "2500")
    }
}
