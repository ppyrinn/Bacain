//
//  SusunKataView.swift
//  MC3-SwiftUI
//
//  Created by Reyhan Rifqi on 18/07/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import SwiftUI

struct SusunKataView: View {
    
    @State private var textField = ""
    
    @State private var topRow = susunKataTop.shuffled()
    @State private var bottomRow = susunKataBot.shuffled()

    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    @State var queue: [String] = []
    

    
    fileprivate func titleBar() -> some View {
        return VStack{
            ZStack{
                Rectangle()
                    .foregroundColor(.white)
                .frame(width: screenWidth, height: screenHeight*15/100, alignment: .top)
                VStack{
                    HStack{
                        Text("Susun Kata")
                            .font(.system(size: 50, weight: .bold, design: .default))
                        Spacer()
                    }.padding(.top)
                }.padding(.top)
            }
            Spacer()
        }
    }

    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(Color(red: 1, green: 0.81, blue: 0.42))
            titleBar()
            VStack{
                HStack{
                    ForEach(0..<8) {  index in
                        Button(action: {
                            if self.textField == ""{
                                self.textField += "\(self.topRow[index])"

                            }else{
                                self.textField += " - \(self.topRow[index])"
                            }
                            self.queue.append(self.topRow[index])
                        }) {
                            Text(self.topRow[index].capitalized)
                                .font(.system(size: 28, weight: .bold, design: .default))
                        }
                        .buttonStyle(SelectableButtonStyle())

                    }
                    
                }
                .padding()
                HStack{
                    ForEach(0..<7) {  index in
                        Button(action: {
                            if self.textField == ""{
                                self.textField += "\(self.bottomRow[index])"

                            }else{
                                self.textField += " - \(self.bottomRow[index])"
                            }
                            self.queue.append(self.bottomRow[index])

                        }) {
                            Text(self.bottomRow[index].capitalized)
                            .font(.system(size: 28, weight: .bold, design: .default))
                        }
                    .buttonStyle(SelectableButtonStyle())
                    .padding()
                    }
                }
                .padding()
                
                HStack{
                    TextField("", text: $textField)
                        .multilineTextAlignment(.center)
                        .disabled(true)
                        .font(.system(size: 50, weight: .bold, design: .default))
                        .frame(width: 350, height: 80, alignment: .center)
                        .background(Color.white)
                        .cornerRadius(20)
                        .padding(.leading)
                    
                    Button(action: {
                        self.topRow = susunKataTop.shuffled()
                        self.bottomRow = susunKataBot.shuffled()
                        self.textField = ""
                        self.queue.removeAll()
                    }) {
                        Image(systemName: "arrow.counterclockwise")
                    }
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundColor(Color.red)

                .padding()
                }
                .padding()
                
                Button(action: {
                    print(self.queue)
                    music(queue: self.queue)
                }) {
                    Text("Btn SUARA")
                }
            .padding()
            }
        }
    }
}

struct SusunKataView_Previews: PreviewProvider {
    static var previews: some View {
        SusunKataView()
    }
}
