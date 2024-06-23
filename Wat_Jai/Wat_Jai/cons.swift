//
//  Congrat.swift
//  DemoGithub
//
//  Created by napon narkphan on 23/6/2567 BE.
//

import SwiftUI

struct con: View {
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.white, .nevBlue]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea(.all)
            VStack{
                Text("RESULT")
                    .font(.largeTitle)
                    .foregroundStyle(.nevBlue)
                    .fontWeight(.black)
                Image("con")
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal)
                VStack{
                    Text("No Heart Disease")
                        .font(.largeTitle)
                        .foregroundStyle(.green)
                        .fontWeight(.bold)
//                    Text("Confident")
//                        .font(.largeTitle)
//                        .foregroundStyle(.black)
//                        .fontWeight(.bold)
                }
                Spacer()
                
            }
        }
    }
}

#Preview {
    con()
}
