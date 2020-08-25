//
//  SwiftUIView.swift
//  MC3-SwiftUI
//
//  Created by Reyhan Rifqi on 18/07/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import SwiftUI

struct FonikView: View {
    
    @State var buttonStyle = SelectableButtonStyle()

 
    @State private var gambar = "anggur"
    @State private var gambarDesc = "Anggur"
    @State private var title = "Aa"
    @State private var subTitle = "a..a..a.."
    @State private var sound = "Sound"
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    @State private var pressed = false

    




    fileprivate func scrollViewItem() -> some View {
        return ForEach(listOfFonik, id: \.alfabet){ fonik in
            Button(action: {
                self.buttonStyle.isSelected.toggle()
                self.gambarDesc = "\(fonik.gambarDesc)"
                self.gambar = "\(fonik.gambar)"
                self.title = "\(fonik.alfabet + fonik.alfabet.lowercased())"
                self.subTitle = "\(fonik.alfabet.lowercased())..\(fonik.alfabet.lowercased())..\(fonik.alfabet.lowercased()).."
                self.sound = "\(fonik.alfabet)"
                playFonik(title: self.sound)

                
            }) {
               
                Text("\(fonik.alfabet)")
                    .font(.system(size: 28, weight: .medium, design: .default))
                    
                
            }
            .frame(width: 60, height: 60, alignment: .center)
            .buttonStyle(self.buttonStyle)
//            .padding(.top, 5)
//            .padding(.bottom, 3)
//            .padding(.leading, 5)
//            .padding(.trailing, 5)
        }
        

    }
    
    fileprivate func titleBar() -> some View {
        return VStack{
            ZStack{
                Rectangle()
                .foregroundColor(.white)
                .frame(width: screenWidth, height: screenHeight*10/100, alignment: .top)
                VStack{
                    Spacer()
                    HStack{
                        Text("Fonik")
                            .font(.system(size: 34, weight: .bold, design: .default))
                            .foregroundColor(Color(red: 0.79, green: 0.26, blue: 0.00))

                            .padding(.top)
                        Spacer()
                    }.padding(.top)
                }.frame(width: screenWidth, height: screenHeight*10/100, alignment: .top)
            }
            Spacer()
        }
    }
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(Color(red: 1, green: 0.81, blue: 0.42))
            ZStack{
                titleBar()
                HStack{
                        ScrollView() {
                            scrollViewItem()
                        }
                            .frame(width: 80, height: screenHeight/2, alignment: .center)

                        .background(Color.white)
                            .cornerRadius(10)
                        .padding(.leading, screenWidth*5/100)

                        Spacer()
                    ZStack{
                        VStack{
                            Rectangle()
                                .frame(width: screenWidth*4/9, height: screenHeight*8/10, alignment: .center)
                            .cornerRadius(50)
                            .foregroundColor(Color.white)
                            Spacer()
<<<<<<< HEAD
=======
                            HStack{
                                
                                VStack(alignment: .leading){
                                    Text("   Lagu dari Capung Kuning")
                                        .bold()
                                        .foregroundColor(Color(red: 0.69, green: 0.48, blue: 0.06))
                                        .padding(.bottom, 10)
                                        .opacity(0.7)
                                    
                                }
                                Spacer()
                            }
                            
>>>>>>> 210887e... Merge pull request #22 from ppyrinn/KuisAndDetailMurid
                        }
                        VStack{
                            Image(gambar)
                                .resizable()
                                .frame(width: screenWidth/4, height: screenWidth/4, alignment: .center)
                            Text("\(gambarDesc)")
                            .font(.system(size: 34, weight: .bold, design: .default))
                        }
                        
                    }
                    Spacer(minLength: screenWidth/20)
                    VStack{
                        Text("\(title)")
                        .font(.system(size: 90, weight: .bold, design: .default))
                        Text("'\(subTitle)'")
                        .font(.system(size: 25, weight: .medium, design: .default))
                        Button(action: {
                            playFonik(title: self.sound)
                        }) {
                            Image("sound-button")
                                .renderingMode(.original)
                        }
                    
                        
                    }.padding(.trailing, screenWidth*15/100)
                }
            }
        }
    
    }
}

struct FonikView_Previews: PreviewProvider {
    static var previews: some View {
        FonikView()
    }
}

struct SelectableButtonStyle: ButtonStyle {

    var isSelected = false
    let color = Color(red: 0.60, green: 0.60, blue: 0.60)
    let color2 = Color(red: 0.79, green: 0.26, blue: 0.00)
    
    func makeBody(configuration: Self.Configuration) -> some View {
        
        configuration.label
            .frame(width: 25, height: 25, alignment: .center)
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
