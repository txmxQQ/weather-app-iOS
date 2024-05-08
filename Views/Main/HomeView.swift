//
//  HomeView.swift
//  NamWeather
//
//  Created by tomo on 2024/04/26.
//

import SwiftUI
import BottomSheet

enum BottomSheetPosition: CGFloat, CaseIterable {
    case top = 0.83
    case middle =  0.3
}

struct HomeView: View {
    @State var bottomSheetPosition: BottomSheetPosition = .middle
    @State var bottomSheetTranslation: CGFloat =
    BottomSheetPosition.middle.rawValue
    
    var bottomSheetTranslationProrated: CGFloat {
        (bottomSheetTranslation - BottomSheetPosition.middle.rawValue) /
        (BottomSheetPosition.top.rawValue - BottomSheetPosition.middle.rawValue)
    }
    
    var bottomSheetTrandlationProrated: CGFloat {
        (bottomSheetTranslation - BottomSheetPosition.middle.rawValue) /
        (BottomSheetPosition.top.rawValue - BottomSheetPosition.middle.rawValue)
    }
    
    var body: some View {
        
        NavigationView {
            
            GeometryReader { geometry in
                let screenHeight = geometry.size.height + geometry.safeAreaInsets.top + geometry.safeAreaInsets.bottom
                let imageOffset = screenHeight + 36
                
                
                ZStack {
                    // MARK: 背景色を指定
                    Color.background
                        .ignoresSafeArea()
                    
                    // MARK: 背景画像を指定
                    Image("Background")
                        .resizable()
                        .ignoresSafeArea()
                        .offset(y: -bottomSheetTrandlationProrated * imageOffset)
                    
                     //MARK: 天気の画像を指定
                    Image("Weather")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .padding(.top, -100)
                    
                    // MARK: 現在の天気を表示
                    VStack(spacing: -10) {
                        Text("中央区")
                            .font(.largeTitle)
                            .padding(.top, 59)
                        
                        VStack {
                            
                            Text(attributedString)
                            
                            Text("H:19°c   L:14°c")
                                .font(.title3.weight(.semibold))
                        }.padding(.top, 0)
                        
                        Spacer()
                    }
                    .padding(.top, 51)
                    // MARK: ボトムシート
                    BottomSheetView(position: $bottomSheetPosition) {
                    } content: {
                        ForecastView()
                    }
                    .onBottomSheetDrag { translation in
                        bottomSheetTranslation = translation / screenHeight
                    }
                    //MARK: エリア調整
                    .padding(.bottom, 40)
                    
                    // MARK: タブバー
                    TabBar(action: {
                        bottomSheetPosition = .top
                    })
                }
                .ignoresSafeArea()
            }
            .navigationBarBackButtonHidden(true)
        }
    }
    
    private var attributedString: AttributedString {
        var string = AttributedString("19°c" + "\n                " + "雨")
        
        if let temp = string.range(of: "19°c") {
            string[temp].font = .system(size: 96, weight: .thin)
            string[temp].foregroundColor = .primary
        }
        
        if let pipe = string.range(of: " | ") {
            string[pipe].font = .title3.weight(.semibold)
            string[pipe].foregroundColor = .secondary
        }
        if let weather = string.range(of: "雨") {
            string[weather].font = .title3.weight(.semibold)
            string[weather].foregroundColor = .primary
        }
        
        return string
    }
}


#Preview {
    HomeView()
        .preferredColorScheme(.dark)
}
