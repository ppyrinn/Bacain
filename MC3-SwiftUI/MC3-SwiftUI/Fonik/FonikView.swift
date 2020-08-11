//
//  SwiftUIView.swift
//  MC3-SwiftUI
//
//  Created by Reyhan Rifqi on 18/07/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import SwiftUI

struct FonikView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(fetchRequest: FonikCD.getAllFonik())
    var listFonik: FetchedResults<FonikCD>
 
    @State public var gambar = "anggur"
    @State public var gambarDesc = "Anggur"
    @State public var title = "Aa"
    @State public var subTitle = "a..a..a"
    @State public var sound = "A"
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    @State private var pressed = false
        
    func resetisSelected(){
        for object in listFonik{
            
            object.setValue(false, forKey: "isSelected")
            do{
                try self.moc.save()
            }
            catch
            {
                print(error)
            }
        }
    }
    
    func starting(){
        let object = listFonik.first
        object?.setValue(true, forKey: "isSelected")
            do{
                try self.moc.save()
            }
            catch
            {
                print(error)
            }
        gambar = "anggur"
        gambarDesc = "Anggur"
        title = "Aa"
        subTitle = "a..a..a"
        sound = "A"
    }
    

    fileprivate func scrollViewItem() -> some View {
        if listFonik.isEmpty{
            for dummy in listOfFonik{
                let fonikCD = FonikCD(context: self.moc)
                fonikCD.alfabet = dummy.alfabet
                fonikCD.gambar = dummy.gambar
                fonikCD.gambarDesc = dummy.gambarDesc
                fonikCD.subTitle = dummy.subTitle
                fonikCD.isSelected = dummy.isSelected
                
                do{
                    try self.moc.save()
                }catch{
                    print(error)
                }
            }
        }
        
        var fonikAwal: [FonikCD] = []
        var fonikTengah: [FonikCD] = []
        var fonikAkhir: [FonikCD] = []

        for i in 0..<listFonik.count{
            if i < 11{
                fonikAwal.append(listFonik[i])
            }else if i < 20{
                fonikTengah.append(listFonik[i])
            }else{
                fonikAkhir.append(listFonik[i])
            }
        }
        return VStack{
            HStack{
                ForEach(fonikAwal, id: \.self){ fonik in
                    buttonDetail(fonik: fonik, fonikView: self).padding(5)
                }
            }
            HStack{
                ForEach(fonikTengah, id: \.self){ fonik in
                    buttonDetail(fonik: fonik, fonikView: self).padding(5)
                }
            }
            HStack{
                ForEach(fonikAkhir, id: \.self){ fonik in
                    buttonDetail(fonik: fonik, fonikView: self).padding(5)
                }
            }
        }
    

    }
    
    fileprivate func titleBar() -> some View {
        return VStack{
            ZStack{
                Rectangle()
                .foregroundColor(.white)
                .frame(width: screenWidth, height: 74, alignment: .top)
                VStack{
                    Spacer()
                    HStack{
                        Text("Fonik")
                            .font(.system(size: 34, weight: .bold, design: .default))
                            .foregroundColor(.black)
                        .accessibility(label: Text("Fonik"))

                            .padding()
                    }
                }.frame(width: screenWidth, height: 74, alignment: .top)
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
                
               
                    VStack{
                        Spacer().frame(height: 74)
                        VStack{
                            
                            Spacer()
                            ZStack{
                                Rectangle()
                                    .frame(width: screenWidth*6/8, height: screenHeight*5/10, alignment: .center)
                                    
                                .cornerRadius(50)
                                .foregroundColor(Color.white)
                                HStack{
                                    Spacer()
                                        VStack{
                                            Image(gambar)
                                                .resizable()
                                                .frame(width: screenWidth/4, height: screenWidth/4, alignment: .center)
                                                .accessibility(label: Text(gambarDesc))
                                            Text("\(gambarDesc)")
                                            .font(.system(size: 34, weight: .bold, design: .default))
                                                .foregroundColor(.black)
                                            .accessibility(label: Text(gambarDesc))
                                        }.frame(width: screenWidth*3/8, height: screenHeight*5/10, alignment: .center)

                                    
                                    Spacer()
                                    Rectangle()
                                        .frame(width: 1, height: screenHeight*4/10, alignment: .center)
                                    .cornerRadius(50)
                                    .foregroundColor(Color.black)
                                    Spacer()
                                    
                                        VStack{
                                            Text("\(title)")
                                            .font(.system(size: 90, weight: .bold, design: .default))
                                                .multilineTextAlignment(.center)
                                                .foregroundColor(.black)
                                            .accessibility(label: Text(title))
                                            Text("'\(subTitle)'")
                                            .font(.system(size: 25, weight: .medium, design: .default))
                                                .foregroundColor(.black)

                                            .multilineTextAlignment(.center)
                                            .accessibility(label: Text(subTitle))

                                            Button(action: {
                                                playFonik(title: self.sound)
                                            }) {
                                                Image("sound-button")
                                                    .renderingMode(.original)
                                            }
                                            .accessibility(label: Text("Speaker"))
                                        
                                            
                                        }.frame(width: screenWidth*3/8, height: screenHeight*5/10, alignment: .center)
                                    Spacer()
                                }
                                .frame(width: screenWidth*6/8, height: screenHeight*5/10, alignment: .center)
                            }
                            Spacer()
                            scrollViewItem()
                                .onAppear{
                                    self.starting()
                            }
                            Spacer()
                            HStack{
                                
                                VStack(alignment: .leading){
                                    Text("   Lagu dari Capung Kuning")
                                        .bold()
                                        .foregroundColor(Color(red: 0.69, green: 0.48, blue: 0.06))
                                        .padding(.bottom, 10)
                                        .opacity(0.3)
                                    
                                }
                                Spacer()
                            }
                            
                        }
                    }
                
                
            }
        }.onDisappear{
            player.stop()
            self.resetisSelected()
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
            .frame(width: 44, height: 44, alignment: .center)
            //.frame(width: 70, height: 70, alignment: .center)
            .background(configuration.isPressed ?  color2 : color)
            //.background(isSelected ? color2 : color)
            //.clipShape(RoundedRectangle(cornerRadius: isSelected ? 16.0 : 0.0))
            //.overlay(RoundedRectangle(cornerRadius: isSelected ? 16.0 : 0.0).stroke(lineWidth: isSelected ? 2.0 : 0.0).foregroundColor(Color.pink))
            .animation(.linear(duration: 0.1))
            .cornerRadius(10)
    }
}
