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
    
    @State private var fc = Color.red
    @State private var delay: Double = 3


    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    @State var queue: [String] = []
    @State var highlight: [Text] = []

    
    
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
                        eksplorasiDetil(eksplorasi: eksplorasiTop[index], eksplorasiView: self).padding(5)
                    }
                }
                HStack{
                    ForEach(0..<7) { index in
                        eksplorasiDetil(eksplorasi: eksplorasiBot[index], eksplorasiView: self).padding(5)
                    }
                }
        }
    }
    
    
    fileprivate func highlightWord() ->  some View {
        
        return ForEach(0..<highlight.count, id :\.self){ i in
    
                self.highlight[i]
                .foregroundColor(self.fc)

//            Text("\(self.highlight[i]) •")
                .font(.system(size: 28))
                .font(.custom("SF Compact Text", size: 28))
                .foregroundColor(Color(red: 0.79, green: 0.26, blue: 0.00))
//                .foregroundColor(Color.red)
//                .animation(Animation.easeIn(duration: 2).delay(self.delay*Double(i)))

                
        }
    }
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(Color(red: 1, green: 0.81, blue: 0.42))
            titleBar()
            VStack{
                Spacer()
                    .frame(height: 74)
                VStack{
                    Spacer()
                    buttonsukuKata()
                    Spacer()
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
                            self.highlight.removeAll()
                        }) {
                            Image("reset-button")
                                .renderingMode(.original)
                        }
                        .accessibility(label: Text("Reset"))

                    .padding()
                    }
                    .padding()
                    HStack{
                        highlightWord()
                    }.frame(height: 30)
                    Spacer()
                    Button(action: {
                        self.highlight.removeAll()
                        music(queue: self.queue)
                        for i in 0..<self.queue.count{
                            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                                self.highlight.append(Text("\(self.queue[i]) •"))
                            }
                        }
                        

                    }) {
                        Image("sound-button")
                            .renderingMode(.original)
                    }
                    .accessibility(label: Text("Speaker"))
                    .padding()
                    Spacer()
                }
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
