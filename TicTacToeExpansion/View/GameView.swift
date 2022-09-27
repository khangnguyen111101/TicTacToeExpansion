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


struct GameView: View {
    @ObservedObject private var viewModel: GameViewModel
    @Environment(\.colorScheme) var colorScheme

    init (goal: Int, difficulty: Int, user: String) {
        viewModel = GameViewModel(goal: goal, difficulty: difficulty, user: user)
    }
    
    var body: some View {
        GeometryReader  { geometry in
            VStack {
                Text("Beat The Computer!")
                    .font(.system(.largeTitle).bold())
                    .foregroundColor(Color("#ff7000"))
                    .padding()
                Spacer()
                LazyVGrid (columns: viewModel.columns ) {
                    ForEach(0 ..< viewModel.slot!, id: \.self) {i in
                        ZStack {
                            GameSlotView(geometryProxy: geometry, goal: viewModel.goal!)
                            
                            PlayerMark(imageSystemName: viewModel.moves[i]? .indicator ?? "")
                        }
                        .onTapGesture {
                            viewModel.onPlayerMove(for: i)
                        }
                    }
                }
                Spacer()
            }
            .disabled(viewModel.isGameDisabled)
            .padding()
            .alert(item: $viewModel.alertItem, content: {alertItem in
                Alert(title: alertItem.title,
                      message: alertItem.message,
                      dismissButton: .default(alertItem.buttonTitle, action: { viewModel.resetGame() }))
            })
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(goal: 6, difficulty: 2, user: "Player")
    }
}
