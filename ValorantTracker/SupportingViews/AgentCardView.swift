//
//  AgentCardView.swift
//  ValorantTracker
//
//  Created by Adrian Gri on 2020-10-02.
//

import SwiftUI

struct AgentCardView: View {
    var agentName: String
    var agentRole: String
    var winPercent: String
    var kdRatio: String
    var timePlayed: String
    
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
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        HStack {
                            VStack {
                                HStack {
                                    Text(agentRole)
                                        .font(.headline)
                                        .foregroundColor(.secondary)
                                    Spacer()
                                }
                            //HStack {
                                HStack {
                                    Text(agentName)
                                        .font(.title)
                                        .fontWeight(.bold)
                                    Spacer()
                                }
                                //Spacer()
    //                            Text(timePlayed)
    //                                .font(.title)
    //                                .fontWeight(.bold)
                            //}
                            }
                            Spacer()
                            Image("\(agentName.lowercased())_icon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40.0, height: 40.0)
                        }.padding(.bottom, 5)
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Time Played")
                                    .font(.body)
                                    .fontWeight(.semibold)
                                Text(timePlayed)
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
                                Text("K/D Ratio")
                                    .font(.body)
                                    .fontWeight(.semibold)
                                Text(kdRatio)
                                    .font(.body)
                            }
                        }
                    }
                }
                .padding()
            }
            .cornerRadius(10)
        }
    }
}

struct AgentCardView_Previews: PreviewProvider {
    static var previews: some View {
        AgentCardView(agentName: "Sage", agentRole: "Sentinel", winPercent: "50%", kdRatio: "1.0", timePlayed: "1d 1h 1m")
    }
}
