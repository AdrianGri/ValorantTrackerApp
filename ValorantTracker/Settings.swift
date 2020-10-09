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
    
    @State private var errorMessage: String = ""
    @State private var errorButtonVisible: Bool = false
    @Environment(\.openURL) var openURL
    
    @State private var enteredName: Bool = false
    
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
            ScrollView {
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
                                enteredName = true
                            }) {
                                Text("Submit")
                                    .padding(.horizontal, 50)
                                    .padding(.vertical, 10)
                            }
                            .frame(width: 180, height: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.bottom, 15)
                            .alert(isPresented: $errorButtonVisible, content: {
                                Alert(title: Text("Profile Private"), message: Text(errorMessage), primaryButton: .default(Text("Make profile public"), action: {openURL(URL(string: "https://tracker.gg/valorant/profile/riot/\(tempName)%23\(tempID)/overview")!)}), secondaryButton: .destructive(Text("Dismiss")))
                            })
                            Spacer()
                        }
                        if (enteredName) {
                            ProgressView(allData.progressMessage, value: allData.progress, total: 1)
                                .padding(.horizontal, 20)
                                .padding(.bottom, 15)
                                .progressViewStyle(AnimatedLinearProgressViewStyle())
                                .frame(height: 40)
                                .onAppear{
                                    buttonAction()
                                }
                        }
                    }.onAppear{
                        resetLoadingBar()
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            .navigationBarTitle("Settings")
            }
        }
    }
    
    private func resetLoadingBar() {
        allData.progressMessage = "Loading..."
        allData.progress = 0
    }
    
    private func buttonAction() {
        DispatchQueue.global().async {
                //self.presentationMode.wrappedValue.dismiss()
                print(self.tempName)
                print(self.tempID)
                UserDefaults.standard.set(self.tempName, forKey: "Name")
                UserDefaults.standard.set(self.tempID, forKey: "ID")
                var riotName: String = UserDefaults.standard.string(forKey: "Name") ?? "000"
                var riotId: String = UserDefaults.standard.string(forKey: "ID") ?? "000"
                print(riotName)
                print(riotId)
                var getData = GetData()
                var profilePrivate: Bool = getData.isProfilePrivate()
                if (profilePrivate) {
                    print("profile is private. adding error messages")
                    errorMessage = "Your Valorant profile is private and your stats cannot be found. Please click the make profile public button and follow the steps to make your profile public and allow your stats to be tracked."
                    errorButtonVisible = true
                } else {
                    print("profile is not private. getting data and pushing to the next page")
                    getData.fetchData(allData: allData)
                    usleep(500000)
//                    DispatchQueue.main.async {
//                        self.presentationMode.wrappedValue.dismiss()
//                    }
                }
        }
    }
}

struct AnimatedLinearProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        ProgressView(configuration)
            .animation(.linear(duration: 1))
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
