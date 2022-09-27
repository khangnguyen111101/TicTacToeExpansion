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

struct PlayerMark : View {
    var imageSystemName: String
    
    var body: some View {
        Image(systemName: imageSystemName)
            .resizable()
            .foregroundColor(Color("#ff7000"))
            .frame(width: 30, height: 30)
    }
}
