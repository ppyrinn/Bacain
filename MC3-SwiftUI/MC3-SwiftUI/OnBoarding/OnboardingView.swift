//
//  OnboardingView.swift
//  MC3-SwiftUI
//
//  Created by Muhamad Vicky on 24/07/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import SwiftUI

struct OnboardingView: View {
    
    var subviews = ["onBoard1","onBoard2","onBoard3","onBoard4"
    ]
    
    var titles = ["Daftar Sekolah & Kelas", "Kuis", "Track Progress Murid", "Eksplorasi"]
    
    var captions =  ["Kamu bisa memasukkan nama sekolah dan kelas yang kamu ajar.", "Kamu bisa memberikan kuis kepada murid - muridmu untuk melihat perkembangan membaca mereka.", "Kamu bisa melihat perkembangan membaca muridmu melalui progress bar.", "Kamu bisa mengajak muridmu untuk lebih mengenal fonik dan suku kata."]
    
    @State var step = 0
    @ObservedObject var viewRouter: ViewRouter
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Welcom to Bacain")
                .font(.system(size: 50, weight: .bold, design: .default))
                .padding()
            GeometryReader{ gr in
                HStack{
                    ForEach(0..<4) { index in
                        HStack(alignment: .center){
                            Image(self.subviews[index])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipped()
                                .frame(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height/2)
                                .padding()
                            VStack(alignment: .leading) {
                                Text(self.titles[index])
                                    .font(.system(size: 25, weight: .bold, design: .default))
                                .animation(Animation.interpolatingSpring(stiffness: 48, damping: 7).delay(0.1))

                                Text(self.captions[index])
                                    .font(.system(size: 17, weight: .medium, design: .default))

                                .foregroundColor(.gray)
                                .frame(width: 300, height: 50, alignment: .leading)
                                .lineLimit(nil)
                            }.padding()
                        }
                        .frame(width: gr.frame(in: .global).width)
                    }
                }
                .frame(maxHeight: .infinity)
                .animation(Animation.interpolatingSpring(stiffness: 48, damping: 8))
                .offset(x: self.calculateOffsetFor(currentPage: self.step,
                                                   basedOnPageWidth: gr.frame(in: .global).width,
                                                   andPageCount: self.subviews.count))
            }
            
                .padding()
            
            PageControl(numberOfPages: subviews.count, currentPageIndex: $step)
                Button(action: {
                    if self.step+1 == self.subviews.count {
                        self.viewRouter.currentPage = "homeView"
                    } else {
                        self.step += 1
                    }
                }) {
                    if self.step+1 == self.subviews.count{
                        Image("mulai-button")
                        .renderingMode(.original)
                        .padding()
                        .cornerRadius(30)
                    }else{
                        Image("lanjut-button")
                        .renderingMode(.original)
                        .padding()
                        .cornerRadius(30)
                    }
                    //.resizable()
                    //.foregroundColor(.white)
                    //.background(Color.orange)

                }
            
                .padding()
        }
    }
}





extension OnboardingView{
    func calculateOffsetFor(currentPage: Int, basedOnPageWidth pageWidth: CGFloat, andPageCount pageCount: Int) -> CGFloat {
        let alignToLeadingEdge = pageWidth * CGFloat(pageCount - 1)/2
        let presentCurrentPage = pageWidth * -CGFloat(currentPage)
        // Compensate for odd margins: If the currentPage is the first one, it is offset 2 to the left. Any subsequent view is first offset to the left and some more per page progression.
        let compensateForOddMargins = currentPage == 0 ? CGFloat(-2) : CGFloat(currentPage * -7 - 5)

        return alignToLeadingEdge + presentCurrentPage + compensateForOddMargins
    }
}
