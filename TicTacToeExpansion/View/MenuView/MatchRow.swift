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

import Foundation
import SwiftUI

struct MatchRow: View {
    var match: Match

    var body: some View {
        HStack {
            VStack {
                Text(match.user)
                    .font(.system(.body).bold())
                Text(String(match.goal))
                Text(match.difficulty)
            }
            Spacer()
            Text(match.result!).font(.system(.headline).bold())
        }
    }
}
