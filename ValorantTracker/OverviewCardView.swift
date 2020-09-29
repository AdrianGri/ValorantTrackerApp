//
//  CardView.swift
//  ValorantTracker
//
//  Created by Adrian Gri on 2020-09-25.
//

import SwiftUI

struct OverviewCardView: View {
    var kdRatio: String
    var winPercent: String
    var killsPerRound: String
    var wins: String
    
    var rankImage: String
    
    var body: some View {
        VStack {
//            Image("turtlerock")
//                .resizable()
//                .aspectRatio(contentMode: .fit)
            HStack {
                VStack(alignment: .leading) {
//                    Text("SwiftUI")
//                        .font(.headline)
//                        .foregroundColor(.secondary)
                    HStack {
                        Text("Stats")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                            .lineLimit(3)
                        Spacer()
                        Image(rankImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40.0, height: 40.0)
                    }
//                    Text("Written by Simon Ng".uppercased())
//                        .font(.caption)
//                        .foregroundColor(.secondary)
                    HStack {
                        VStack(alignment: .leading) {
                            Text("K/D Ratio")
                                .font(.body)
                                .fontWeight(.semibold)
                            Text(kdRatio)
                                .font(.body)
                        }
                        VStack(alignment: .leading) {
                            Text("Win %")
                                .font(.body)
                                .fontWeight(.semibold)
                            Text(winPercent)
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
                            Text("Wins")
                                .font(.body)
                                .fontWeight(.semibold)
                            Text(wins)
                                .font(.body)
                        }
                    }
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

struct OverviewCardView_Previews: PreviewProvider {
    static var previews: some View {
        OverviewCardView(kdRatio: "k/d...", winPercent: "win%...", killsPerRound: "k/r...", wins: "wins...", rankImage: "Gold 2")
    }
}
