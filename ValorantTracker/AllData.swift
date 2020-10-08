//
//  AllData.swift
//  ValorantTracker
//
//  Created by Adrian Gri on 2020-10-07.
//

import Foundation

class AllData: ObservableObject {
    @Published var competitiveStats: [String: String] = [:]
    @Published var unratedStats: [String: String] = [:]
    @Published var deathmatchStats: [String: String] = [:]
    @Published var matchInfo: [String: [String]] = ["modeName":[], "mapName": [], "roundsWon": [], "roundsLost": [], "kdRatio": [], "score": [], "killsPerRound": [], "damage": [], "result": [], "kills": [], "deaths":[], "assists":[], "econRating":[], "agent":[], "headshots":[], "bodyshots":[], "legshots":[], "combatScore":[]]
    @Published var competitiveAgentInfo: [String: [String]] = ["agentName":[], "agentRole":[], "timePlayed":[], "kdRatio":[], "winPercent":[]]
    @Published var unratedAgentInfo: [String: [String]] = ["agentName":[], "agentRole":[], "timePlayed":[], "kdRatio":[], "winPercent":[]]
}
