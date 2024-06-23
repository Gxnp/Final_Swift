//
//  home.swift
//  Wat_Jai
//
//  Created by Nontakorn Pulakkeaw on 23/6/2567 BE.
//

import SwiftUI

struct home: View {
    var body: some View {
        NavigationStack{
            ZStack{
                
        
                LinearGradient(gradient: Gradient(colors: [.white, .nevBlue]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea(.all)
                
                VStack{
                    Spacer()
                    Text("Heart Disease Disorders")
                        .fontWeight(.heavy)
                        .font(.title)
                    Spacer()
                    
                    Image("Home")
                        .resizable()
                        .frame(width:450 , height: 400)
                    Spacer()
                    
                    HStack{
                        
                        NavigationLink{
                            ContentView()
                        } label: {
                            Text("Get Start")
                                .fontWeight(.heavy)
                                                        .font(.title)
                                                        .padding(10)
                                                        .foregroundStyle(Color.nevBlue)
                                                        .background(.white)
                                                        .clipShape(RoundedRectangle(cornerRadius: 19))
                        }
                    }
                    
                    
                    
                    
                }.padding()
                
                
                
            }
        }
        
        
        
        
    }
}

#Preview {
    home()
}
