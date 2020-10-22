//
//  Loading.swift
//  ValorantTracker
//
//  Created by Adrian Gri on 2020-09-28.
//

import SwiftUI
import SwiftSoup
import WebKit
import Foundation

struct mainJSONData: Decodable {
    let data: matches
}

struct matches: Decodable {
    let matches: [matchData]
    let metadata: dataMetadata
    let paginationType: Int
    let requestingPlayerAttributes: playerAttributes
}

struct dataMetadata: Decodable {
    let schema: String
    let next: Int
}

struct playerAttributes: Decodable {
    let platformSlug: String
    let platformUserIdentifier: String
}

struct matchData: Decodable {
    let attributes: matchAttribute?
    let metadata: matchMetadata
    let segments: [matchSegments]
}

struct matchAttribute: Decodable {
    let id: String
    let mapId: Int?
    let modeId: Int?
}

struct matchMetadata: Decodable {
    let modeKey: String?
    let modeName: String?
    let modeImageUrl: String?
    let modeMaxRounds: Int?
    let hasWon: Bool?
    let timestamp: String?
    let result: String?
    let map: String?
    let mapName: String?
    let mapImageUrl: String?
    let agent: String?
    let agentName: String?
    let agentImageUrl: String?
}

struct matchSegments: Decodable {
    let type: String?
    let attributes: segmentAttributes?
    let metadata: segmentMetadata?
    let expiryDate: String?
    let stats: segmentStats
}

struct segmentAttributes: Decodable {
    let platformSlug: String?
}

struct segmentMetadata: Decodable {
    let platformUserHandle: String?
    let isAvailable: Bool?
    let timestamp: String?
}

struct segmentStats: Decodable {
    let score: statInfo
    let roundsPlayed: statInfo
    let kills: statInfo
    let headshots: statInfo
    let deaths: statInfo
    let assists: statInfo
    let damage: statInfo
    let damageReceived: statInfo
    let econRating: statInfo
    let plants: statInfo
    let defuses: statInfo
    let firstBloods: statInfo
    let playtime: statInfo
    let grenadeCasts: statInfo
    let ability1Casts: statInfo
    let ability2Casts: statInfo
    let ultimateCasts: statInfo
    let dealtHeadshots: statInfo
    let dealtBodyshots: statInfo
    let dealtLegshots: statInfo
    let recievedHeadshots: statInfo
    let recievedBodyshots: statInfo
    let recievedLegshots: statInfo
    let deathsFirst: statInfo
    let deathsLast: statInfo
    let roundsWon: statInfo
    let roundsLost: statInfo
    let placement: statInfo
    let kdRatio: statInfo
    let scorePerRound: statInfo
    let damagePerRound: statInfo
}

struct statInfo: Decodable {
    let rank: String?
    let percentile: String?
    let displayName: String?
    let displayCategory: String?
    let category: String?
    let metadata: statMetadata?
    let value: Double?
    let displayValue: String?
    let displayType: String?
}

struct statMetadata: Decodable {
}

var rankIconInfo: String = "unrated"

private var riotName: String = UserDefaults.standard.string(forKey: "Name") ?? "000"
private var riotId: String = UserDefaults.standard.string(forKey: "ID") ?? "000"

struct Loading: View {
    @ObservedObject var allData = AllData()
    
    @State var textToUpdate = "Update me!"
    @State var kdRatio = "0"
    @State var winPercent = "0"
    @State var killsPerRound = "0"
    @State var wins = "0"
    @State var rankName = "unrated"
    
    @State var playTime = "0"
    @State var matches = "0"
    @State var kills = "0"
    @State var deaths = "0"
    @State var mostKills = "0"
    @State var aces = "0"
    @State var headshotPercent = "0"
    @State var losses = "0"
    
//    @State var matchInfo: [String: [String]] = ["modeName":[], "mapName": [], "roundsWon": [], "roundsLost": [], "kdRatio": [], "score": [], "killsPerRound": [], "damage": [], "result": [], "kills": [], "deaths":[], "assists":[], "econRating":[], "agent":[], "headshots":[], "bodyshots":[], "legshots":[], "combatScore":[]]
//
//    @State var competitiveStats: [String: String] = [:]
//    @State var unratedStats: [String: String] = [:]
//    @State var deathmatchStats: [String: String] = [:]
//
//    @State var competitiveAgentInfo: [String: [String]] = ["agentName":[], "agentRole":[], "timePlayed":[], "kdRatio":[], "winPercent":[]]
//    @State var unratedAgentInfo: [String: [String]] = ["agentName":[], "agentRole":[], "timePlayed":[], "kdRatio":[], "winPercent":[]]
    
    @State var finishedLoading: Bool = false
    @State var goToStartScreen: Bool = false
    
//    let mainView = ContentView(textToUpdate: $textToUpdate, kdRatio: $kdRatio, winPercent: $winPercent, killsPerRound: $killsPerRound, wins: $wins, rankName: $rankName, matchInfo: $matchInfo)
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            if (colorScheme == .light) {
                Color(.sRGB, red: 241/255, green: 242/255, blue: 246/255, opacity: 1)
                    .ignoresSafeArea()
            } else {
                Color.black
                    .ignoresSafeArea()
            }
            NavigationView {
                VStack(alignment: .center) {
                    Image("Radiant")
                        .frame(width: 250, height: 250)
                    Text("ValTracker")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    ProgressView()
                    NavigationLink(
                        destination: ContentView(),
                        isActive: $finishedLoading,
                        label: {
                            EmptyView()
                        })
                    NavigationLink(
                        destination: StartScreen(),
                        isActive: $goToStartScreen,
                        label: {
                            EmptyView()
                        })
                }
            }.environmentObject(allData)
        }
        .onAppear {
            checkFirstLaunch()
        }
    }
    
    func checkFirstLaunch() {
        var isFirstLaunch: Bool = UserDefaults.standard.bool(forKey: "HasLaunchedOnce") ?? false
        isFirstLaunch = false
        if (!isFirstLaunch) {
            UserDefaults.standard.set(true, forKey: "HasLaunchedOnce")
            print("going to start screen")
            goToStartScreen = true
        } else {
            getAllData()
        }
    }
    
    func gotoLoginScreen() {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.finishedLoading = true
            }
        }
    
    func getAllData() {
        print("getAllData() run from loading screen")
        var getData = GetData()
        print("fetching data from GetData object")
        getData.fetchData(allData: allData)
        print("going to next screen")
        allData.progressMessage = "Loading..."
        allData.progress = 0
        print(self.allData.matchInfo)
        gotoLoginScreen()
    }
    
//    private func getHTML(aURL: String, completion: ( (String) -> (Void) )?)
//    {
//                let url = URL(string: aURL)!
//                let task = URLSession.shared.dataTask(with: url)
//                {
//                    (data, response, error) in
//                    guard let data = data else { return }
//        //            print(String(data: data, encoding: .utf8)!)
//                    let tempHTML = String(data: data, encoding: .utf8)!
//
//                    //print(tempHTML)
//
//                    completion?(tempHTML)
//                }
//        task.resume()
//    }
}

struct Loading_Previews: PreviewProvider {
    static var previews: some View {
        Loading()
    }
}
