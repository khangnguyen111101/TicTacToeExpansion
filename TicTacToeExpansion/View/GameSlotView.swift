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

struct GameSlotView: View {
    var geometryProxy: GeometryProxy
    var goal: Int
     
    var body: some View {
        Circle()
            .foregroundColor(Color("#ffd2b3"))
            .frame(width: geometryProxy.size.width / CGFloat(goal) - 10,
                   height: geometryProxy.size.width / CGFloat(goal) - 10)
    }
}
