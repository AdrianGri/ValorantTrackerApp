//
//  GetData.swift
//  ValorantTracker
//
//  Created by Adrian Gri on 2020-10-07.
//

import Foundation
import SwiftUI
import SwiftSoup

class GetData {
    private var riotName: String = UserDefaults.standard.string(forKey: "Name") ?? "000"
    private var riotId: String = UserDefaults.standard.string(forKey: "ID") ?? "000"

    func isProfilePrivate() -> Bool {
        var result: Bool = true
        do {
            let html = try String(contentsOf: URL(string: "https://tracker.gg/valorant/profile/riot/\(riotName)%23\(riotId)/overview")!)
            let doc: Document = try SwiftSoup.parse(html)
            
            guard let errorElement: Element = try doc.select("p[class$=error-message]").first() else {
                print("profile is not private")
                result = false
                return(false)
            }
            
            print("profile is private")
        } catch Exception.Error(let type, let message) {
            print(message)
        } catch {
            print("error")
        }
        return(result)
    }
    
    func fetchData(allData: AllData) {
        riotName = UserDefaults.standard.string(forKey: "Name") ?? "000"
        riotId = UserDefaults.standard.string(forKey: "ID") ?? "000"
        let jsonUrlString = "https://api.tracker.gg/api/v2/valorant/rap-matches/riot/\(riotName)%23\(riotId)?type=competitive"
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            //perhaps check err
            //also perhaps check response status 200 OK
            
            guard let data = data else { return }
            
//            let dataAsString = String(data: data, encoding: .utf8)
//            print(dataAsString)
            DispatchQueue.main.async {
                allData.progressMessage = "Getting match history..."
                allData.progress += 0.25
            }
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
                
                DispatchQueue.main.async {
                    allData.matchInfo = tempMatchInfo
                }
                
                
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
            DispatchQueue.main.async {
                allData.progressMessage = "Getting agent stats..."
                allData.progress += 0.25
            }
            var competitiveAgentInfo = getAgentInfo(mode: "competitive")
            DispatchQueue.main.async {
                allData.progress += 0.125 //0.625
            }
            var unratedAgentInfo = getAgentInfo(mode: "unrated")
            
            DispatchQueue.main.async {
                allData.progressMessage = "Getting overall stats..."
                allData.progress += 0.15 //0.75
            }
            var competitiveStats = getStats(mode: "competitive")
            DispatchQueue.main.async {
                allData.progress += 0.125 //0.825
            }
            var unratedStats = getStats(mode: "unrated")
            DispatchQueue.main.async {
                allData.progress += 0.075 //0.9
            }
            var deathmatchStats = getStats(mode: "deathmatch")
            DispatchQueue.main.async {
                allData.progress += 0.05 //0.95
            }
            
            DispatchQueue.main.async {
                allData.competitiveAgentInfo = competitiveAgentInfo
                allData.unratedAgentInfo = unratedAgentInfo
    //            competitiveAgentInfo = getAgentInfo(mode: "competitive")
    //            unratedAgentInfo = getAgentInfo(mode: "unrated")
                
                allData.competitiveStats = competitiveStats
                allData.unratedStats = unratedStats
                allData.deathmatchStats = deathmatchStats
            }
            
//            competitiveStats = getStats(mode: "competitive")
//            unratedStats = getStats(mode: "unrated")
//            deathmatchStats = getStats(mode: "deathmatch")
            
            print(allData.competitiveStats)
            print(allData.unratedStats)
            print(allData.deathmatchStats)
            
            DispatchQueue.main.async {
                allData.progressMessage = "Complete"
                allData.progress = 1
            }
            //self.finishedLoading = true
            //gotoLoginScreen()
        } catch Exception.Error(let type, let message) {
            print(message)
        } catch {
            print("error")
        }
    }
    func getAgentInfo(mode: String) -> [String:[String]] {
        var result: [String: [String]] = ["agentName":[], "agentRole":[], "timePlayed":[], "kdRatio":[], "winPercent":[]]
        
        do {
            let html = try String(contentsOf: URL(string: "https://tracker.gg/valorant/profile/riot/\(riotName)%23\(riotId)/agents?playlist=\(mode)")!)
            let doc: Document = try SwiftSoup.parse(html)
            
            let agentNameAndRoles = getMultipleStatValues(doc: doc, tag: "div", property: "class", stat: "agent-stats__header-name")
            print(agentNameAndRoles)
            for nameAndRole: String in agentNameAndRoles {
                let splitAgentNameAndRoles = nameAndRole.split(separator: " ")
                print(splitAgentNameAndRoles)
                result["agentName"]?.append(String(splitAgentNameAndRoles[0]).capitalized)
                result["agentRole"]?.append(String(splitAgentNameAndRoles[1]).capitalized)
            }
            print(result)
            
            let tempAgentWinPercent = getMultipleStatValuesNextTag(doc: doc, tag: "span", property: "title", stat: "Win %", nextTag: "span")
            var agentWinPercent: [String] = []
            let i: Int = 0
            for j in stride(from: i, to: tempAgentWinPercent.count, by: 2) {
                agentWinPercent.append(tempAgentWinPercent[j])
                result["winPercent"]?.append(tempAgentWinPercent[j])
            }
            print(agentWinPercent)
            
            let agentKDRatio = getMultipleStatValuesNextTag(doc: doc, tag: "span", property: "title", stat: "K/D Ratio", nextTag: "span")
            print(agentKDRatio)
            for kd: String in agentKDRatio {
                result["kdRatio"]?.append(kd)
            }
            
            let agentTimePlayed = getMultipleStatValuesNextTag(doc: doc, tag: "span", property: "title", stat: "Time Played", nextTag: "span")
            print(agentTimePlayed)
            for timePlayed: String in agentTimePlayed {
                result["timePlayed"]?.append(timePlayed)
            }
            
            print(result)
            
        } catch Exception.Error(let type, let message) {
            print(message)
        } catch {
            print("error")
        }
        
        return(result)
    }
    func getStats(mode: String) -> [String: String] {
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
            let html = try String(contentsOf: URL(string: "https://tracker.gg/valorant/profile/riot/\(riotName)%23\(riotId)/overview?playlist=\(mode)")!)
             
            let doc: Document = try SwiftSoup.parse(html)

             //print(html)
             
             getRank(doc: doc)



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
    
    func getStatValue(doc: Document, stat: String) -> String {
        
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
    func getSpanValue(doc: Document, stat: String) -> String {
        
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
    func getMultipleStatValues(doc: Document, tag: String, property: String, stat: String) -> [String] {
        
        print("------------------")
        
        var result: [String] = []
        
        do {
            guard let statElements: Elements = try doc.select("\(tag)[\(property)$=\(stat)]") else {
                print("could not get stat elements for stat: \(stat)")
                return(["could not get stat elements for stat: \(stat)"])
            }
            for link: Element in statElements.array() {
                guard let statInfo: String = try link.text() else {
                    print("could not get stat info for stat: \(stat)")
                    return(["could not get stat info for stat: \(stat)"])
                }
                print(statInfo)
                result.append(statInfo)
            }
        } catch Exception.Error(let type, let message) {
            print("caught error. type: \"\(type)\" and message \"\(message)\"")
        } catch {
            print("error")
        }
        
        return(result)
    }
    func getMultipleStatValuesNextTag(doc: Document, tag: String, property: String, stat: String, nextTag: String) -> [String] {
        
        print("------------------")
        
        var result: [String] = []
        
        do {
            guard let statElements: Elements = try doc.select("\(tag)[\(property)$=\(stat)] + \(nextTag)") else {
                print("could not get stat elements for stat: \(stat)")
                return(["could not get stat elements for stat: \(stat)"])
            }
            for link: Element in statElements.array() {
                guard let statInfo: String = try link.text() else {
                    print("could not get stat info for stat: \(stat)")
                    return(["could not get stat info for stat: \(stat)"])
                }
                print(statInfo)
                result.append(statInfo)
            }
        } catch Exception.Error(let type, let message) {
            print("caught error. type: \"\(type)\" and message \"\(message)\"")
        } catch {
            print("error")
        }
        
        return(result)
    }
    func getRank(doc: Document) {
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
}
