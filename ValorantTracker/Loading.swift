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

struct Loading: View {
    
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
    
    @State var matchInfo: [String: [String]] = ["modeName":[], "mapName": [], "roundsWon": [], "roundsLost": [], "kdRatio": [], "score": [], "killsPerRound": [], "damage": [], "result": [], "kills": [], "deaths":[], "assists":[], "econRating":[], "agent":[], "headshots":[], "bodyshots":[], "legshots":[], "combatScore":[]]
    
    @State var competitiveStats: [String: String] = [:]
    @State var unratedStats: [String: String] = [:]
    @State var deathmatchStats: [String: String] = [:]
    
    @State var finishedLoading: Bool = false
    
    
    
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
                    ProgressView()
                    NavigationLink(
                        destination: ContentView(competitiveStats: $competitiveStats, unratedStats: $unratedStats, deathmatchStats: $deathmatchStats, matchInfo: $matchInfo),
                        isActive: $finishedLoading,
                        label: {
                            EmptyView()
                        })
                }
                .onAppear {
                    fetch()
                }
            }
        }
    }
    
    func gotoLoginScreen() {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.finishedLoading = true
            }
        }
    
    private func getHTML(aURL: String, completion: ( (String) -> (Void) )?)
    {
                let url = URL(string: aURL)!
                let task = URLSession.shared.dataTask(with: url)
                {
                    (data, response, error) in
                    guard let data = data else { return }
        //            print(String(data: data, encoding: .utf8)!)
                    let tempHTML = String(data: data, encoding: .utf8)!
                    
                    //print(tempHTML)

                    completion?(tempHTML)
                }
        task.resume()
    }
    
    
    private func fetch() {
        let jsonUrlString = "https://api.tracker.gg/api/v2/valorant/rap-matches/riot/Leafs%23000?type=competitive"
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            //perhaps check err
            //also perhaps check response status 200 OK
            
            guard let data = data else { return }
            
//            let dataAsString = String(data: data, encoding: .utf8)
//            print(dataAsString)
            
            do {
//                let websiteDescription = try JSONDecoder().decode(WebsiteDescription.self, from: data)
//                print(websiteDescription.name, websiteDescription.description)
                
                let mainData = try JSONDecoder().decode(mainJSONData.self, from: data)
                
                let numMatches: Int = mainData.data.matches.count
                
                var tempMatchInfo: [String: [String]] = ["modeName":[], "mapName": [], "roundsWon": [], "roundsLost": [], "kdRatio": [], "score": [], "killsPerRound": [], "damage": [], "result": [], "kills": [], "deaths":[], "assists":[], "econRating":[], "agent":[], "headshots":[], "bodyshots":[], "legshots":[], "combatScore":[]]
                
                for i in 0...numMatches-1 {
                    if (mainData.data.matches[i].segments.count > 0) {
//                        print(mainData.data.matches[i].segments[0].stats?.kdRatio?.displayValue)
                        var modeName = mainData.data.matches[i].metadata.modeName!
                        if (modeName == "Normal") {
                            modeName = "Unrated"
                        }
                        //tempMatchInfo["modeName"] = []
                        tempMatchInfo["modeName"]?.append(modeName)
                        tempMatchInfo["mapName"]?.append(mainData.data.matches[i].metadata.mapName!)
                        tempMatchInfo["roundsWon"]?.append(mainData.data.matches[i].segments[0].stats.roundsWon.displayValue!)
                        tempMatchInfo["roundsLost"]?.append(mainData.data.matches[i].segments[0].stats.roundsLost.displayValue!)
                        tempMatchInfo["kdRatio"]?.append(mainData.data.matches[i].segments[0].stats.kdRatio.displayValue!)
                        tempMatchInfo["score"]?.append(mainData.data.matches[i].segments[0].stats.score.displayValue!)
//                        tempMatchInfo["killsPerRound"]?.append(mainData.data.matches[i].segments[0].stats.damagePerRound.displayValue!)
                        tempMatchInfo["damage"]?.append(mainData.data.matches[i].segments[0].stats.damage.displayValue!)
//                        tempMatchInfo[0].append(modeName)
//                        tempMatchInfo[1].append(mainData.data.matches[i].metadata.mapName!)
//                        tempMatchInfo[2].append(mainData.data.matches[i].segments[0].stats.roundsWon.displayValue!)
//                        tempMatchInfo[3].append(mainData.data.matches[i].segments[0].stats.roundsLost.displayValue!)
//                        tempMatchInfo[4].append(mainData.data.matches[i].segments[0].stats.kdRatio.displayValue!)
//                        tempMatchInfo[5].append(mainData.data.matches[i].segments[0].stats.score.displayValue!)
//                        tempMatchInfo[6].append(mainData.data.matches[i].segments[0].stats.damagePerRound.displayValue!)
//                        tempMatchInfo[7].append(mainData.data.matches[i].segments[0].stats.damage.displayValue!)
                        let roundsWon: Double = Double(mainData.data.matches[i].segments[0].stats.roundsWon.displayValue!) ?? 13
                        let roundsLost: Double = Double(mainData.data.matches[i].segments[0].stats.roundsLost.displayValue!) ?? 13
                        let kills: Double = Double(mainData.data.matches[i].segments[0].stats.kills.displayValue!) ?? 26
                        let killsPerRound: Double = ((Double(kills / (roundsWon + roundsLost))*10)).rounded()/10
                        tempMatchInfo["killsPerRound"]?.append(String(killsPerRound))
                        if (roundsWon > roundsLost) {
                            tempMatchInfo["result"]?.append("Victory")
                            //tempMatchInfo[8].append("Victory")
                        } else if (roundsWon < roundsLost) {
                            tempMatchInfo["result"]?.append("Defeat")
                            //tempMatchInfo[8].append("Defeat")
                        } else {
                            tempMatchInfo["result"]?.append("Draw")
                            //tempMatchInfo[8].append("Draw")
                        }
                        
                        tempMatchInfo["kills"]?.append(mainData.data.matches[i].segments[0].stats.kills.displayValue!)
                        tempMatchInfo["deaths"]?.append(mainData.data.matches[i].segments[0].stats.deaths.displayValue!)
                        tempMatchInfo["assists"]?.append(mainData.data.matches[i].segments[0].stats.assists.displayValue!)
                        tempMatchInfo["econRating"]?.append(mainData.data.matches[i].segments[0].stats.econRating.displayValue!)
                        tempMatchInfo["agent"]?.append(mainData.data.matches[i].metadata.agentName!)
                        tempMatchInfo["headshots"]?.append(mainData.data.matches[i].segments[0].stats.dealtHeadshots.displayValue!)
                        tempMatchInfo["bodyshots"]?.append(mainData.data.matches[i].segments[0].stats.dealtBodyshots.displayValue!)
                        tempMatchInfo["legshots"]?.append(mainData.data.matches[i].segments[0].stats.dealtLegshots.displayValue!)
                        tempMatchInfo["combatScore"]?.append(mainData.data.matches[i].segments[0].stats.scorePerRound.displayValue!)
                    }
                }
                print(tempMatchInfo)
                
                self.matchInfo = tempMatchInfo
                
//                DispatchQueue.main.async {
//                    globals.matchInfo = tempMatchInfo
//                }
//                print(globals.matchInfo)
                
                
                //print(mainData)
                
                //Swift 2/3/ObjC
//                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else { return }
//
//                let course = Course(json: json)
//                print(course.name)
                
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
            
                        
            
        }.resume()
        
        
        
//        let urlString = "https://tracker.gg/valorant/profile/riot/leafs%23000/overview"
//
//        let url = URL(string: urlString)!
//
//        let task = URLSession.shared.dataTask(with: url) { (data, resp, error) in
//            do {
//            guard let data = data else {
//                print("data was nil")
//                return
//            }
//
//            guard let html = String(data: data, encoding: String.Encoding.utf8) else {
//                print("cannot case data into string")
//                return
//            }
//
//            let doc: Document = try SwiftSoup.parse(html)
//
//             print(html)
//
//             guard let rankIcon: Element = try doc.select("div.valorant-rank-bg").first() else {
//                 print("could not find rank-icon element, the player is most likely unrated")
//                 return
//             }
//
//             guard let rankIconInfo: String = try rankIcon.text() else {
//                 print("could not get rankicon info into text")
//                 return
//             }
//
//             //gets the value of the span right after the span with the title "K/D Ratio"
// //            guard let kdRatio: Element = try doc.select("span[title$=K/D Ratio] + span").first() else {
// //                print("slfjsf")
// //                return
// //            }
// //
// //
// //            guard let kdRatioInfo: String = try kdRatio.text() else {
// //                print("cadfasdfsf")
// //                return
// //            }
//
// //
//             //self.kdToUpdate = kdRatioInfo
//
//             self.kdRatio = getStatValue(doc: doc, stat: "K/D Ratio")
//             self.winPercent = getStatValue(doc: doc, stat: "Win %")
//             self.killsPerRound = getStatValue(doc: doc, stat: "Kills/Round")
//             self.wins = getStatValue(doc: doc, stat: "Wins")
//             self.rankName = rankIconInfo
//
//             //print(kdRatioInfo)
//
//             print(rankIconInfo)
//             //let stuff: String = try masthead.text()
//             self.textToUpdate = rankIconInfo
//            } catch Exception.Error(let type, let message) {
//                print(message)
//            } catch {
//                print("error")
//            }
//        }
//
//        task.resume()
        
        do {
//           let json = try String(contentsOf: URL(string: "https://api.tracker.gg/api/v2/valorant/rap-matches/riot/Leafs%23000?type=competitive&next=null")!)

//
//            let otherDoc: Document = try SwiftSoup.parse(json)
//
//            let jsonData = json.data(using: .utf8)!
//
//            let blogPost: BlogPost = try! JSONDecoder().decode(BlogPost.self, from: jsonData)
//
//            print(blogPost.Headshots)
            
            
            //print(json)
            

            
            competitiveStats = getStats(mode: "competitive")
            unratedStats = getStats(mode: "unrated")
            deathmatchStats = getStats(mode: "deathmatch")
            
            print(competitiveStats)
            print(unratedStats)
            print(deathmatchStats)
            //self.finishedLoading = true
            gotoLoginScreen()
        } catch Exception.Error(let type, let message) {
            print(message)
        } catch {
            print("error")
        }
    }
    
    
}

private func getRank(doc: Document) {
    do {
        guard let rankIcon: Element = try doc.select("div.valorant-rank-bg").first() else {
            print("could not find rank-icon element, the player is most likely unrated")
            rankIconInfo = "unrated"
            return
        }

        guard let rankIconInfoTemp: String = try rankIcon.text() else {
            print("could not get rankicon info into text")
            return
        }
        
        rankIconInfo = rankIconInfoTemp
        
        print(rankIconInfo)
    } catch Exception.Error(let type, let message) {
        print("caught error. type: \"\(type)\" and message \"\(message)\"")
    } catch {
        print("error")
    }
}

private func getStats(mode: String) -> [String: String] {
    var kdRatio: String = ""
    var winPercent: String = ""
    var killsPerRound: String = ""
    var wins: String = ""
    var rankName: String = ""
    var textToUpdate: String = ""
    
    var playTime: String = ""
    var matches: String = ""
    var kills: String = ""
    var deaths: String = ""
    var mostKills: String = ""
    var aces: String = ""
    var headshotPercent: String = ""
    var losses: String = ""
    
    var allStats: [String: String] = [:]
    
    do {
        let html = try String(contentsOf: URL(string: "https://tracker.gg/valorant/profile/riot/leafs%23000/overview?playlist=\(mode)")!)
         
        let doc: Document = try SwiftSoup.parse(html)

         //print(html)
         
         getRank(doc: doc)

        let newHtml = try String(contentsOf: URL(string: "https://tracker.gg/valorant/profile/riot/leafs%23000/agents")!)
        let newDoc: Document = try SwiftSoup.parse(newHtml)
        getMultipleStatValues(doc: newDoc, stat: "Win %")

         //gets the value of the span right after the span with the title "K/D Ratio"
//            guard let kdRatio: Element = try doc.select("span[title$=K/D Ratio] + span").first() else {
//                print("slfjsf")
//                return
//            }
//
//
//            guard let kdRatioInfo: String = try kdRatio.text() else {
//                print("cadfasdfsf")
//                return
//            }

//
         //self.kdToUpdate = kdRatioInfo
        allStats["mode"] = mode.capitalized

         kdRatio = getStatValue(doc: doc, stat: "K/D Ratio")
        allStats["kdRatio"] = kdRatio
         winPercent = getStatValue(doc: doc, stat: "Win %")
        allStats["winPercent"] = winPercent
         killsPerRound = getStatValue(doc: doc, stat: "Kills/Round")
        allStats["killsPerRound"] = killsPerRound
         wins = getStatValue(doc: doc, stat: "Wins")
        allStats["wins"] = wins
         rankName = rankIconInfo
        allStats["rankName"] = rankName
        
        playTime = getSpanValue(doc: doc, stat: "playtime")
        let playTimeSplit = playTime.components(separatedBy: " Play")
        playTime = playTimeSplit[0]
        print(playTime)
        allStats["playTime"] = playTime
        matches = getSpanValue(doc: doc, stat: "matches")
        let matchesSplit = matches.components(separatedBy: " Match")
        matches = matchesSplit[0]
        print(matches)
        allStats["matches"] = matches
        kills = getStatValue(doc: doc, stat: "Kills")
        print(kills)
        allStats["kills"] = kills
        deaths = getStatValue(doc: doc, stat: "Deaths")
        print(deaths)
        allStats["deaths"] = deaths
        mostKills = getStatValue(doc: doc, stat: "Most Kills (Match)")
        print(mostKills)
        allStats["mostKills"] = mostKills
        aces = getStatValue(doc: doc, stat: "Aces")
        print(aces)
        allStats["aces"] = aces
        headshotPercent = getStatValue(doc: doc, stat: "Headshots %")
        headshotPercent = headshotPercent + "%"
        print(headshotPercent)
        allStats["headshotPercent"] = headshotPercent
        let matchesInt: Int = Int(matches) ?? 0
        let winsInt: Int = Int(wins) ?? 0
        losses = String(matchesInt - winsInt)
        print(losses)
        allStats["losses"] = losses

         //print(kdRatioInfo)

         print(rankIconInfo)
        
        print(allStats)
        
         //let stuff: String = try masthead.text()
         textToUpdate = rankIconInfo
    } catch Exception.Error(let type, let message) {
        print("caught error. type: \"\(type)\" and message \"\(message)\"")
    } catch {
        print("error")
    }
    
    return allStats
}

private func getStatValue(doc: Document, stat: String) -> String {
    
    var result: String = ""
    
    do {
        guard let statElement: Element = try doc.select("span[title$=\(stat)] + span").first() else {
            print("could not get stat element for stat: \(stat)")
            return("could not get stat element for stat \(stat)")
        }
        
        guard let statInfo: String = try statElement.text() else {
            print("could not get stat info for stat: \(stat)")
            return("could not get stat info for stat: \(stat)")
        }
            
        result = statInfo
        
    } catch Exception.Error(let type, let message) {
        print("caught error. type: \"\(type)\" and message \"\(message)\"")
    } catch {
        print("error")
    }
    
    return(result)
}

private func getSpanValue(doc: Document, stat: String) -> String {
    
    var result: String = ""
    
    do {
        guard let statElement: Element = try doc.select("span[class$=\(stat)]").first() else {
            print("could not get stat element for stat: \(stat)")
            return("could not get stat element for stat \(stat)")
        }
        
        guard let statInfo: String = try statElement.text() else {
            print("could not get stat info for stat: \(stat)")
            return("could not get stat info for stat: \(stat)")
        }
            
        result = statInfo
        
    } catch Exception.Error(let type, let message) {
        print("caught error. type: \"\(type)\" and message \"\(message)\"")
    } catch {
        print("error")
    }
    
    return(result)
}

struct Loading_Previews: PreviewProvider {
    static var previews: some View {
        Loading()
    }
}

private func getMultipleStatValues(doc: Document, stat: String) /*-> [String]*/ {
    
    print("------------------")
    
    var result: [String] = []
    
    do {
        guard let statElements: Elements = try doc.select("span[title$=Time Played] + span") else {
            print("could not get stat elements for stat: \(stat)")
            //return(["could not get stat elements for stat: \(stat)"])
        }
        for link: Element in statElements.array() {
            guard let statInfo: String = try link.text() else {
                print("could not get stat info for stat: \(stat)")
                //return(["could not get stat info for stat: \(stat)"])
            }
            print(statInfo)
            //result.append(statInfo)
        }
    } catch Exception.Error(let type, let message) {
        print("caught error. type: \"\(type)\" and message \"\(message)\"")
    } catch {
        print("error")
    }
    
    //return(result)
}
