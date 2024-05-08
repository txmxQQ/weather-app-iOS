//
//  SwiftUIView.swift
//  NamWeather
//
//  Created by tomo on 2024/04/26.
//

import SwiftUI

struct TabBar: View {
    
    var action: () -> Void
    
    var body: some View {
        
        ZStack {
            // MARK: シェイプの追加
            Arc()
                .fill(Color.tabBarBackground)
                .frame(height: 88)
                .overlay {
                    // MARK: Arcボーダー
                    Arc()
                    .stroke(Color.tabBarBorders, lineWidth: 0.5)
                }
            
            // MARK: タブアイテム
            HStack {
                // MARK: ボタンシートを展開
                Button {
                    action()
                } label: {
                    Image(systemName: "mappin.and.ellipse")
                        .frame(width: 44, height: 44)
                }
                
                Spacer()
                
                // MARK: ナビゲーションバー
                NavigationLink {
                    WeatherView()
                    
                } label: {
                    Image(systemName: "list.star")
                        .frame(width: 44, height: 44)
                }
            }
            .font(.title2)
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 30, leading: 32, bottom: 24, trailing: 32))
            
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
    }
}

#Preview {
    TabBar(action: {})
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
