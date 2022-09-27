/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 1
    Author: Nguyen Bao Khang
    ID: s3817970
    Created  date: 15/08/2022
    Last modified: 07/08/2022
    Acknowledgement: Mobiraft (https://mobiraft.com/ios/swiftui/how-to-add-splash-screen-in-swiftui/)
*/

import Foundation
import SwiftUI

struct MenuView: View {
    @State private var instructionPopupShow = false
    @State private var gameConfigPopupShow = false
    @State private var isPlayNow = false
    @State private var goal = 3
    @State private var difficulty = 1
    @State private var historyPopupShow = false
    @State private var user = "Player"
    @State private var newUser = ""
    @State var users = allUser
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Image("AppIcon-bgremove")
                    .resizable()
                    .frame(width: 150, height: 150)
                
                Text("Tic Tac Toe Expansion")
                    .font(.system(.largeTitle).bold())
                    .foregroundColor(Color("#ff7000"))
                
                Spacer()
                NavigationLink(destination: GameView(goal: goal, difficulty: difficulty, user: user), isActive: $isPlayNow) { EmptyView() }
                
                // play now
                Button("Play Now") { isPlayNow = true }
                .font(.system(size: 25).bold())
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color(0xff7000), lineWidth: 5)
                )
                .foregroundColor(Color("#ff7000"))
                
                // game configuration
                Button("Game Configuration") {
                    gameConfigPopupShow = true
                    playSound(sound: "swhoosh", type: "mp3")
                }
                .font(.system(size: 25).bold())
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color(0xff7000), lineWidth: 5)
                )
                .foregroundColor(Color("#ff7000"))
                
                // game instruction
                Button("Instruction") {
                    instructionPopupShow = true
                    playSound(sound: "swhoosh", type: "mp3")
                }
                .font(.system(size: 25).bold())
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color(0xff7000), lineWidth: 5)
                )
                .foregroundColor(Color("#ff7000"))
                
                // game history button
                Button("Game History") {
                    historyPopupShow = true
                    playSound(sound: "swhoosh", type: "mp3")
                }
                .font(.system(size: 25).bold())
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                    .stroke(Color(0xff7000), lineWidth: 5)
                )
                .foregroundColor(Color("#ff7000"))
                Spacer()
            }
            .popover(isPresented: $instructionPopupShow) {
                InstructionView()
            }
            .popover(isPresented: $gameConfigPopupShow) {
                Text("Game Configuration")
                    .font(.system(.largeTitle).bold())
                    .foregroundColor(Color("#ff7000"))
                    .padding()
                
                
                Text("Goal and Board size")
                    .font(.system(.headline).bold())
                Picker("Goal and Board size", selection: $goal) {
                    Text("3 - 3x3").tag(3)
                    Text("4 - 4x4").tag(4)
                    Text("5 - 5x5").tag(5)
                    Text("6 - 6x6").tag(6)
                }.pickerStyle(SegmentedPickerStyle())
                
                
                Text("Computer Difficulty")
                .font(.system(.headline).bold())
                Picker("Computer Difficulty", selection: $difficulty) {
                    Text("Easy").tag(1)
                    Text("Normal").tag(2)
                }.pickerStyle(SegmentedPickerStyle())
                
                Text("User Selection")
                .font(.system(.headline).bold())
                Picker("User", selection: $user) {
                    Text("Player").tag("Player")
                    ForEach(users) {user in
                        Text(user.name).tag(user.name)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                
                TextField("User name", text: $newUser)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    users.append(User(name: newUser))
                    allUser.append(User(name: newUser))
                    newUser = ""
                    saveUser()
                }, label: {
                    Text("Add User")
                        .font(.system(.body).bold())
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color(0xff7000), lineWidth: 5)
                        )
                        .foregroundColor(Color("#ff7000"))
                })
                Spacer()
            }
            .popover(isPresented: $historyPopupShow) {
                GameHistoryView()
            }
        }
    }
}

struct MenuView_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            MenuView()
        }
    }
}
