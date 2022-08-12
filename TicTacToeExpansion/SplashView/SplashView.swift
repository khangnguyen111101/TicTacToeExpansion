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
import Lottie

// loop animated GIF for 3 seconds before going to the main list view
struct SplashView: View {
    
    @State var isActive:Bool = false
    @State var opacity: Double = 1
    
    var body: some View {
        VStack {
            if self.isActive {
                ContentView()
            } else {
                ZStack {
                    LottieView()
                    Text("Tic Tac Toe Expansion")
                        .font(
                            .system(.largeTitle)
                            .weight(.bold)
                        )
                        .offset(y: 220)
                }
                .opacity(self.opacity)
            }
        }
        // 5.
        .onAppear {
            // 6.
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                // 7.
                withAnimation {
                    self.isActive = true
                    self.opacity = 0
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
