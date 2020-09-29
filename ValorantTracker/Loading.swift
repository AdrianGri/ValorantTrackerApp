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

struct Loading: View {
    
    @State var textToUpdate = "Update me!"
    @State var kdRatio = "0"
    @State var winPercent = "0"
    @State var killsPerRound = "0"
    @State var wins = "0"
    @State var rankName = "Gold 2"
    
    @State var matchInfo: [[String]] = [[],[],[],[],[],[],[],[]]
    
    @State var finishedLoading: Bool = false
    
//    let mainView = ContentView(textToUpdate: $textToUpdate, kdRatio: $kdRatio, winPercent: $winPercent, killsPerRound: $killsPerRound, wins: $wins, rankName: $rankName, matchInfo: $matchInfo)
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                ProgressView()
                NavigationLink(
                    destination: ContentView(textToUpdate: $textToUpdate, kdRatio: $kdRatio, winPercent: $winPercent, killsPerRound: $killsPerRound, wins: $wins, rankName: $rankName, matchInfo: $matchInfo),
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
                
                var tempMatchInfo: [[String]] = [[],[],[],[],[],[],[],[]]
                
                for i in 0...numMatches-1 {
                    if (mainData.data.matches[i].segments.count > 0) {
//                        print(mainData.data.matches[i].segments[0].stats?.kdRatio?.displayValue)
                        tempMatchInfo[0].append(mainData.data.matches[i].metadata.modeName!)
                        tempMatchInfo[1].append(mainData.data.matches[i].metadata.mapName!)
                        tempMatchInfo[2].append(mainData.data.matches[i].segments[0].stats.roundsWon.displayValue!)
                        tempMatchInfo[3].append(mainData.data.matches[i].segments[0].stats.roundsLost.displayValue!)
                        tempMatchInfo[4].append(mainData.data.matches[i].segments[0].stats.kdRatio.displayValue!)
                        tempMatchInfo[5].append(mainData.data.matches[i].segments[0].stats.score.displayValue!)
                        tempMatchInfo[6].append(mainData.data.matches[i].segments[0].stats.damagePerRound.displayValue!)
                        tempMatchInfo[7].append(mainData.data.matches[i].segments[0].stats.damage.displayValue!)
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
            
            
           let html = try String(contentsOf: URL(string: "https://tracker.gg/valorant/profile/riot/leafs%23000/overview?playlist=competitive")!)
//            var html = "empty html"
//
//            self.getHTML(aURL: "https://tracker.gg/valorant/profile/riot/leafs%23000/overview?playlist=competitive")
//                    { result in
//                        if result.isEmpty
//                        {
//                            print("Announcements could not be downloaded!")
//                        }
//                        else
//                        {
//                            print("Successful download of announcements.")
//                            html = result
//                            //print(html)
//                        }
//                        // Default
//                    }
//
            
           let doc: Document = try SwiftSoup.parse(html)

            //print(html)

            guard let rankIcon: Element = try doc.select("div.valorant-rank-bg").first() else {
                print("could not find rank-icon element, the player is most likely unrated")
                return
            }

            guard let rankIconInfo: String = try rankIcon.text() else {
                print("could not get rankicon info into text")
                return
            }

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

            self.kdRatio = getStatValue(doc: doc, stat: "K/D Ratio")
            self.winPercent = getStatValue(doc: doc, stat: "Win %")
            self.killsPerRound = getStatValue(doc: doc, stat: "Kills/Round")
            self.wins = getStatValue(doc: doc, stat: "Wins")
            self.rankName = rankIconInfo

            //print(kdRatioInfo)

            print(rankIconInfo)
            //let stuff: String = try masthead.text()
            self.textToUpdate = rankIconInfo
            
            //self.finishedLoading = true
            gotoLoginScreen()
        } catch Exception.Error(let type, let message) {
            print(message)
        } catch {
            print("error")
        }
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
}

struct Loading_Previews: PreviewProvider {
    static var previews: some View {
        Loading()
    }
}
