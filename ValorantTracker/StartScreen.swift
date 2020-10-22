//
//  StartScreen.swift
//  ValorantTracker
//
//  Created by Adrian Gri on 2020-10-08.
//

import SwiftUI

struct StartScreen: View {
    @State private var tempName: String = ""
    @State private var tempID: String = ""
    
    @State private var errorMessage: String = ""
    @State private var errorButtonVisible: Bool = false
    //@State private var errorMessageEnd: String = ""
    @Environment(\.openURL) var openURL
    
    @State private var enteredName: Bool = false
    
    @State private var finishedLoading: Bool = false
    
    var loadingProgress: String = "Loading..."
    
    @EnvironmentObject var allData: AllData
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            Text("ValTracker")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Image("Radiant")
            VStack (alignment: .leading) {
                Text("RiotID")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.horizontal, 20)
                    .foregroundColor(.white)
                HStack {
                    TextField("Name", text: $tempName)
                        .colorScheme(.light)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Text("#")
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    TextField("ID", text: $tempID)
                        .colorScheme(.light)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 100)
                }.padding(.horizontal, 20)
                .padding(.bottom, 10)
            }
            Button(action: {
                enteredName = true
            }) {
                Text("Submit")
            }
            .frame(width: 180, height: 50)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .alert(isPresented: $errorButtonVisible, content: {
                Alert(title: Text("Profile Private"), message: Text(errorMessage), primaryButton: .default(Text("Make profile public"), action: {openURL(URL(string: "https://tracker.gg/valorant/profile/riot/\(tempName)%23\(tempID)/overview")!)}), secondaryButton: .destructive(Text("Dismiss")))
            })
            if (enteredName) {
                ProgressView(allData.progressMessage, value: allData.progress, total: 1)
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    .progressViewStyle(WhiteTextProgressViewStyle())
                    .frame(height: 30)
                    .onAppear{
                        buttonAction()
                    }
            } else {
                Rectangle()
                    .frame(height: 30)
                    .opacity(0)
            }
            NavigationLink(
                destination: ContentView(),
                isActive: $finishedLoading,
                label: {
                    EmptyView()
                })
            Spacer()
        }
        .navigationBarHidden(true)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color(red: 250 / 255, green: 64 / 255, blue: 84 / 255), Color(red: 54 / 255, green: 73 / 255, blue: 102 / 255)]), startPoint: .top, endPoint: .bottom)
              .edgesIgnoringSafeArea(.all))
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
                    finishedLoading = true
                }
        }
    }
}

struct WhiteTextProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        ProgressView(configuration)
            .animation(.linear(duration: 1))
            .foregroundColor(.white)
    }
}

struct StartScreen_Previews: PreviewProvider {
    static var previews: some View {
        StartScreen()
    }
}
