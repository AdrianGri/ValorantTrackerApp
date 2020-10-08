//
//  Settings.swift
//  ValorantTracker
//
//  Created by Adrian Gri on 2020-10-06.
//

import SwiftUI

struct Settings: View {
    @State private var name: String = ""
    @State private var id: String = ""
    
    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
    @State private var tempName = ""
    @State private var tempID = ""
    
    @State private var navigationActive = false
    
    @State private var isRefreshing = false
    
    @EnvironmentObject var allData: AllData
    
    @Environment(\.colorScheme) var colorScheme
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        ZStack {
            if (colorScheme == .light) {
                Color(.sRGB, red: 241/255, green: 242/255, blue: 246/255, opacity: 1)
                    .ignoresSafeArea()
            } else {
                Color.black
                    .ignoresSafeArea()
            }
            VStack (alignment: .leading) {
                HStack {
                    Text("Enter RiotID")
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
                    VStack (alignment: .leading) {
                        HStack {
                            TextField("Name", text: $tempName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            Text("#")
                                .font(.body)
                                .fontWeight(.bold)
                            TextField("ID", text: $tempID)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 100)
                        }.padding(.horizontal, 15)
                        .padding(.top, 15)
                        .padding(.bottom, 5)
                        HStack {
//                            if (isRefreshing) {
//                                ProgressView()
//                                Text("Refreshing Data")
//                            }
                            Spacer()
                            Button(action: {
                                //isRefreshing = true
                                //self.presentationMode.wrappedValue.dismiss()
                                print(self.tempName)
                                print(self.tempID)
                                UserDefaults.standard.set(self.tempName, forKey: "Name")
                                UserDefaults.standard.set(self.tempID, forKey: "ID")
                                print("mmmmmmmmmmmmmmm")
                                var riotName: String = UserDefaults.standard.string(forKey: "Name") ?? "000"
                                var riotId: String = UserDefaults.standard.string(forKey: "ID") ?? "000"
                                print(riotName)
                                print(riotId)
                                var getData = GetData()
                                getData.fetchData(allData: allData)
                                self.presentationMode.wrappedValue.dismiss()
                            }) {
                                Text("Submit")
                                    .padding(.horizontal, 50)
                                    .padding(.vertical, 10)
                            }
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.bottom, 15)
                            Spacer()
                        }
                        NavigationLink(
                            destination: Loading(),
                            isActive: $navigationActive,
                            label: {
                                EmptyView()
                            })
                    }
                }.frame(height: 100)
                //Spacer()
                Spacer()
            }
            .padding(.horizontal, 20)
            .frame(maxHeight: .infinity)
            .navigationBarTitle("Settings")
        }
    }
    
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
