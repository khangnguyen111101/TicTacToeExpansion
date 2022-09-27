/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 1
    Author: Nguyen Bao Khang
    ID: s3817970
    Created  date: 12/08/2022
    Last modified: 07/08/2022
    Acknowledgement: Mobiraft (https://mobiraft.com/ios/swiftui/how-to-add-splash-screen-in-swiftui/)
*/

import SwiftUI

struct InstructionView: View {
    var body: some View {
        VStack {
            Text("Instruction")
                .font(.system(.largeTitle).bold())
                .foregroundColor(Color("#ff7000"))
                .padding()
            
            Group {
                Image("AppIcon-bgremove")
                    .resizable()
                    .frame(width: 150, height: 150)
                
                Text("Select Game Configuration to change Goal with Board size, Difficulty and User").font(.system(.body).bold())
                Text("Select Game History to view all games played").font(.system(.body).bold())
                Text("Select Play Now to start playing").font(.system(.body).bold())
                Text("User will be X and computer will be O").font(.system(.body).bold())
                Text("Reach a continous line (vertical, horizontal, or diagonal) to win").font(.system(.body).bold())
            }
            .padding()
            
            Spacer()
        }
    }
}
