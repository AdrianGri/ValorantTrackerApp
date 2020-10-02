//
//  MatchView.swift
//  ValorantTracker
//
//  Created by Adrian Gri on 2020-09-30.
//

import SwiftUI

struct MatchView: View {
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
    
    @State var headshotsPercent: String = "0" //
    @State var bodyshotsPercent: String = "0" //
    @State var legshotsPercent: String = "0" //
    
    var screenWidth = UIScreen.main.bounds.width
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            if (colorScheme == .dark) {
                Color.black
                    .ignoresSafeArea()
                    
            } else {
                Color(.sRGB, red: 241/255, green: 242/255, blue: 246/255, opacity: 1)
                    .ignoresSafeArea()
            }
            ScrollView {
                VStack {
                    HStack {
                        Text("Overview")
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    ZStack {
                        if (colorScheme == .dark) {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                            .fill(Color(.sRGB, red: 27/255, green: 28/255, blue: 30/255, opacity: 1))
                        } else {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color.white)
                        }
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
                        .cornerRadius(10)
                        .buttonStyle(PlainButtonStyle())
            //        .overlay(
            //            RoundedRectangle(cornerRadius: 10)
            //                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
            //
            //        )
                    }
                    HStack {
                        Text("More Stats")
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    HStack {
                        VStack (alignment: .leading){
                            HStack {
                                ZStack {
                                    if (colorScheme == .dark) {
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                                    .fill(Color(.sRGB, red: 27/255, green: 28/255, blue: 30/255, opacity: 1))
                                } else {
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(Color.white)
                                }
                                    HStack {
                                        VStack (alignment: .leading){
                                            Text("Agent")
                                                .font(.body)
                                                .fontWeight(.semibold)
                                            Text(agent)
                                                .font(.body)
                                        }
                                        Spacer()
                                    }.padding(.all, 10)
                                }.padding(.bottom, 5)
                                Spacer()
                            }
                            HStack {
                                ZStack {
                                    if (colorScheme == .dark) {
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                                    .fill(Color(.sRGB, red: 27/255, green: 28/255, blue: 30/255, opacity: 1))
                                } else {
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(Color.white)
                                }
                                    HStack {
                                        VStack (alignment: .leading){
                                            Text("Econ Rating")
                                                .font(.body)
                                                .fontWeight(.semibold)
                                            Text(econRating)
                                                .font(.body)
                                        }
                                        Spacer()
                                    }.padding(.all, 10)
                                }.padding(.bottom, 5)
                                Spacer()
                            }
                            HStack {
                                ZStack {
                                    if (colorScheme == .dark) {
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                                    .fill(Color(.sRGB, red: 27/255, green: 28/255, blue: 30/255, opacity: 1))
                                } else {
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(Color.white)
                                }
                                    HStack {
                                        VStack (alignment: .leading){
                                            Text("Deaths")
                                                .font(.body)
                                                .fontWeight(.semibold)
                                            Text(deaths)
                                                .font(.body)
                                        }
                                        Spacer()
                                    }.padding(.all, 10)
                                }.padding(.bottom, 5)
                                Spacer()
                            }
                            Spacer()
                        }.frame(width: (screenWidth - 40) / 2)
                        VStack (alignment: .leading){
                            HStack {
                                ZStack {
                                    if (colorScheme == .dark) {
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                                    .fill(Color(.sRGB, red: 27/255, green: 28/255, blue: 30/255, opacity: 1))
                                } else {
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(Color.white)
                                }
                                    HStack {
                                        VStack (alignment: .leading){
                                            Text("Combat Score")
                                                .font(.body)
                                                .fontWeight(.semibold)
                                            Text(combatScore)
                                                .font(.body)
                                        }
                                        Spacer()
                                    }.padding(.all, 10)
                                }.padding(.bottom, 5)
                                Spacer()
                            }
                            HStack {
                                ZStack {
                                    if (colorScheme == .dark) {
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                                    .fill(Color(.sRGB, red: 27/255, green: 28/255, blue: 30/255, opacity: 1))
                                } else {
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(Color.white)
                                }
                                    HStack {
                                        VStack (alignment: .leading){
                                            Text("Kills")
                                                .font(.body)
                                                .fontWeight(.semibold)
                                            Text(kills)
                                                .font(.body)
                                        }
                                        Spacer()
                                    }.padding(.all, 10)
                                }.padding(.bottom, 5)
                                Spacer()
                            }
                            HStack {
                                ZStack {
                                    if (colorScheme == .dark) {
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                                    .fill(Color(.sRGB, red: 27/255, green: 28/255, blue: 30/255, opacity: 1))
                                } else {
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(Color.white)
                                }
                                    HStack {
                                        VStack (alignment: .leading){
                                            Text("Assists")
                                                .font(.body)
                                                .fontWeight(.semibold)
                                            Text(assists)
                                                .font(.body)
                                        }
                                        Spacer()
                                    }.padding(.all, 10)
                                }.padding(.bottom, 5)
                                Spacer()
                            }
                            Spacer()
                        }
                        Spacer()
                    }.frame(maxWidth: .infinity)
                    HStack {
                        Text("Accuracy")
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                    }
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
                                Text("Headshots: ")
                                    .font(.body)
                                    .fontWeight(.semibold)
                                Spacer()
                                Text("\(headshots) | \(headshotsPercent)%")
                                    .font(.body)
                            }
                            HStack {
                                Text("Bodyshots: ")
                                    .font(.body)
                                    .fontWeight(.semibold)
                                Spacer()
                                Text("\(bodyshots) | \(bodyshotsPercent)%")
                                    .font(.body)
                            }
                            HStack {
                                Text("Legshots: ")
                                    .font(.body)
                                    .fontWeight(.semibold)
                                Spacer()
                                Text("\(legshots) | \(legshotsPercent)%")
                                    .font(.body)
                            }
                        }.padding()
                    }
                    Spacer()
                }
                .padding(.horizontal, 20)
            }
            .navigationBarTitle("Match")
            .onAppear {
                getData()
            }
            
        }
    }
    
    private func getData() {
        let doubleHeadshots: Double = Double(headshots) ?? 1
        let doubleBodyshots: Double = Double(bodyshots) ?? 1
        let doubleLegshots: Double = Double(legshots) ?? 1
        let totalShots: Double = doubleHeadshots + doubleBodyshots + doubleLegshots
        let headshotsPercentTemp = String(((doubleHeadshots / totalShots) * 100).rounded())
        let bodyshotsPercentTemp = String(((doubleBodyshots / totalShots) * 100).rounded())
        let legshotsPercentTemp = String(((doubleLegshots / totalShots) * 100).rounded())
        let splitHeadshotsPercent = headshotsPercentTemp.split(separator: ".")
        let splitBodyshotsPercent = bodyshotsPercentTemp.split(separator: ".")
        let splitLegshotsPercent = legshotsPercentTemp.split(separator: ".")
        
        headshotsPercent = String(splitHeadshotsPercent[0])
        bodyshotsPercent = String(splitBodyshotsPercent[0])
        legshotsPercent = String(splitLegshotsPercent[0])
    }
}

struct MatchView_Previews: PreviewProvider {
    static var previews: some View {
        MatchView(id: 0, mode: "Unrated", mapName: "Bind", roundsWon: "13", roundsLost: "13", kdRatio: "1.00", score: "1000", killsPerRound: "1", damage: "1000", result: "Victory", kills: "10", deaths: "10", assists: "10", econRating: "100", agent: "Pheonix", headshots: "10", bodyshots: "10", legshots: "10", combatScore: "100")
    }
}
