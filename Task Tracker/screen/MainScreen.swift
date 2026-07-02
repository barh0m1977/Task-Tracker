//
//  MainScreen.swift
//  Task Tracker
//
//  Created by Indexer on 7/7/26.
//

import SwiftUI

struct MainScreen: View {
    @State var isHome = false
    @State var scaleAmount: CGFloat = 1
    var body: some View {
        ZStack{
            if isHome {
                MainTabView()
            } else {
                Image("TaskImage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaleEffect(scaleAmount)
                    .frame(width: 88)
            }
        }
      .ignoresSafeArea()
        .onAppear {
            withAnimation(.easeOut(duration: 1)) {
                scaleAmount = 0.6
            }
            withAnimation(.easeInOut(duration: 1).delay(1)){
                scaleAmount = 100
                
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                isHome = true
            }
        }
    }
}

#Preview {
    MainScreen()
}
