//
//  SusunKataView.swift
//  MC3-SwiftUI
//
//  Created by Reyhan Rifqi on 18/07/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import SwiftUI

struct SusunKataView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(fetchRequest: Eksplorasi.getAllSukuKata())
    var listEksplorasi: FetchedResults<Eksplorasi>
        
    
    
    @State public var textField = ""

    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    @State var queue: [String] = []
    
    
    func generateArr() -> [Eksplorasi]{
        var arr:[Eksplorasi] = []
        for i in 0..<listEksplorasi.count{
            if i < listEksplorasi.count/2{
               arr.append(listEksplorasi[i])
            }
        }
        return arr
    }
    func resetisSelected(){
        for object in listEksplorasi{
            
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
    
    fileprivate func titleBar() -> some View {
        return VStack{
            ZStack{
                Rectangle()
                .foregroundColor(.white)
                .frame(width: screenWidth, height: 74, alignment: .top)
                VStack{
                    Spacer()
                    HStack{
                        Text("Eksplorasi")
                            .font(.system(size: 34, weight: .bold, design: .default))
                            .foregroundColor(.black)
                            .padding()
                        .accessibility(label: Text("Eksplorasi"))
                    }
                }.frame(width: screenWidth, height: 74, alignment: .top)
            }
            Spacer()
        }
    }

    fileprivate func buttonsukuKata() -> some View{
        if self.listEksplorasi.isEmpty{
                for dummy in ArrsusunKata{
                    let eksplorasi = Eksplorasi(context: self.moc)
                    eksplorasi.sukuKata = dummy.sukuKata
                    eksplorasi.isSelected = dummy.isSelected
                    
                    do{
                        try self.moc.save()
                    }catch{
                        print(error)
                    }
                }
            }
        
        if eksplorasiTop.isEmpty && eksplorasiBot.isEmpty{
            for i in 0..<self.listEksplorasi.count{
                if i < self.listEksplorasi.count/2{
                    eksplorasiTop.append(self.listEksplorasi[i])
                }else{
                    eksplorasiBot.append(self.listEksplorasi[i])
                }
            }
        }
        
        return VStack{
                HStack{
                    ForEach(0..<8) { index in
                        eksplorasiDetil(eksplorasi: eksplorasiTop[index], eksplorasiView: self)
                    }
                }
                HStack{
                    ForEach(0..<7) { index in
                        eksplorasiDetil(eksplorasi: eksplorasiBot[index], eksplorasiView: self)
                    }
                }
        }
    }
    
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(Color(red: 1, green: 0.81, blue: 0.42))
            titleBar()
            VStack{
                buttonsukuKata()
                
                HStack{
                    TextField("", text: $textField)
                        .foregroundColor(.black)
                        .accessibility(label: Text(textField))

                        .multilineTextAlignment(.center)
                        .layoutPriority(1)
                        .disabled(true)
                        .font(.system(size: 50, weight: .bold, design: .default))
                        .frame(width: screenWidth*3/5, height: 80, alignment: .center)
                        .background(Color.white)
                        .cornerRadius(20)
                        .padding()
                    
                    Button(action: {
                        quePlayer.pause()
                        eksplorasiTop = eksplorasiTop.shuffled()
                        eksplorasiBot = eksplorasiBot.shuffled()
                        self.textField = ""
                        self.queue.removeAll()
                        self.resetisSelected()
                    }) {
                        Image("reset-button")
                            .renderingMode(.original)
                    }
                    .accessibility(label: Text("Reset"))

                .padding()
                }
                .padding()
                
                Button(action: {
                    music(queue: self.queue)
                }) {
                    Image("sound-button")
                        .renderingMode(.original)
                }
                    .accessibility(label: Text("Speaker"))

            .padding()
            }
        }
        .onDisappear{
            quePlayer.pause()
        }
    }
}

struct SusunKataView_Previews: PreviewProvider {
    static var previews: some View {
        SusunKataView()
    }
}
