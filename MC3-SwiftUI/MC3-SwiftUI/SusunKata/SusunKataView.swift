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
    

    
    fileprivate func titleBar() -> some View {
        return VStack{
            ZStack{
                Rectangle()
                .foregroundColor(.white)
                .frame(width: screenWidth, height: screenHeight*1/10, alignment: .top)
                VStack{
                    Spacer()
                    HStack{
                        Text("Susun Kata")
                            .font(.system(size: 34, weight: .bold, design: .default))
                        .foregroundColor(Color(red: 0.79, green: 0.26, blue: 0.00))
                            .padding(.top)
                        Spacer()
                    }.padding(.top)
                }.frame(width: screenWidth, height: screenHeight*1/10, alignment: .top)
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
                                self.textField += "\(self.topRow[index].capitalized)"

                            }else{
                                self.textField += " - \(self.topRow[index].capitalized)"
                            }
                        }) {
                            Text(self.topRow[index].capitalized)
                                .font(.system(size: 28, weight: .bold, design: .default))
                        }
                        .buttonStyle(SelectableBtnStyle())

                    }
                    
                }
                .padding()
                HStack{
                    ForEach(0..<7) {  index in
                        Button(action: {
                            if self.textField == ""{
                                self.textField += "\(self.bottomRow[index].capitalized)"

                            }else{
                                self.textField += " - \(self.bottomRow[index].capitalized)"
                            }
                        }) {
                            Text(self.bottomRow[index].capitalized)
                            .font(.system(size: 28, weight: .bold, design: .default))
                        }
                            
                    .buttonStyle(SelectableBtnStyle())
//                    .padding()
                    }
                }
                .padding()
                
                HStack{
                    TextField("", text: $textField)
                        .multilineTextAlignment(.center)
                    .layoutPriority(1)
                        .disabled(true)
                        .font(.system(size: 50, weight: .bold, design: .default))
                        .frame(width: screenWidth*3/5, height: 80, alignment: .center)
                        .background(Color.white)
                        .cornerRadius(20)
                        .padding()
                    
                    Button(action: {
                        self.textField = ""
                    }) {
                        Image("reset-button")
                    }
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundColor(Color.red)

                .padding()
                }
                .padding()
                
                Button(action: {
                    print("btn")
                }) {
                    Image("sound-button")
                        .renderingMode(.original)
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

struct SelectableBtnStyle: ButtonStyle {

    var isSelected = false
    let color = Color(red: 0.60, green: 0.60, blue: 0.60)
    let color2 = Color(red: 0.79, green: 0.26, blue: 0.00)
    
    func makeBody(configuration: Self.Configuration) -> some View {
        
        configuration.label
            .frame(width: 50, height: 50, alignment: .center)
            .padding()
            //.frame(width: 70, height: 70, alignment: .center)
            .background(configuration.isPressed ?  color2 : color)
            //.background(isSelected ? color2 : color)
            //.clipShape(RoundedRectangle(cornerRadius: isSelected ? 16.0 : 0.0))
            //.overlay(RoundedRectangle(cornerRadius: isSelected ? 16.0 : 0.0).stroke(lineWidth: isSelected ? 2.0 : 0.0).foregroundColor(Color.pink))
            .animation(.linear(duration: 0.1))
            .cornerRadius(10)
    }
}
