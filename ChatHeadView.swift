//
//  ChatHeadView.swift
//  SwiftTestJul7
//
//  Created by Minsang Choi on 7/10/24.
//

import SwiftUI

struct ChatHeadView : View {

  @State private var circleSize : CGFloat = 80
  @State private var pos_1 : CGSize = .zero
  @State private var offset_1 : CGSize = .zero
  @State private var scale : CGFloat = 1
  @State private var offsetFactor : CGPoint = .zero
  @State private var opacity: CGFloat = 0.1

  var body: some View {
    ZStack{
      Image("bgImage")
        .resizable()
        .scaledToFill()
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
      Color.black.opacity(opacity)
      GeometryReader{ proxy in

        let circlePos_1 = CGPoint(x: proxy.size.width / 2 + pos_1.width + offset_1.width, y: proxy.size.height / 2 + pos_1.height + offset_1.height)
        let circlePos_2 = CGPoint(x: circlePos_1.x + offsetFactor.x, y: circlePos_1.y + offsetFactor.y)
        let circlePos_3 = CGPoint(x: circlePos_2.x + offsetFactor.x, y: circlePos_2.y + offsetFactor.y)

        Image("profile_image_03")
          .resizable()
          .scaledToFill()
          .frame(width: circleSize, height: circleSize)
          .cornerRadius(circleSize / 2)
          .overlay(
            Circle()
              .strokeBorder(Color.white.opacity(0.2), lineWidth: 1)
              .frame(width: circleSize, height: circleSize)
              .foregroundColor(.clear)
          )
          .scaleEffect(scale)
          .position(circlePos_3)
          .shadow(radius: 8)

        Image("profile_image_02")
          .resizable()
          .scaledToFill()
          .frame(width: circleSize, height: circleSize)
          .cornerRadius(circleSize / 2)
          .overlay(
            Circle()
              .strokeBorder(Color.white.opacity(0.2), lineWidth: 1)
              .frame(width: circleSize, height: circleSize)
              .foregroundColor(.clear)
          )
          .scaleEffect(scale)
          .position(circlePos_2)
          .shadow(radius: 8)

        Image("profile_image")
          .resizable()
          .scaledToFill()
          .frame(width: circleSize, height: circleSize)
          .cornerRadius(circleSize / 2)
          .overlay(
            Circle()
              .strokeBorder(Color.white.opacity(0.2), lineWidth: 1)
              .frame(width: circleSize, height: circleSize)
              .foregroundColor(.clear)
          )
          .position(circlePos_1)
          .scaleEffect(scale)
          .shadow(radius: 8)
          .onTapGesture {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0)){
              if pos_1.width >= 0 {
                pos_1.width = proxy.size.width / 2 - circleSize * 3
              } else {
                pos_1.width = -proxy.size.width / 2 + circleSize / 2
              }
              offsetFactor.x = 90
              pos_1.height = -300
              opacity = 0.8
            }
          }
          .gesture(
            DragGesture()
              .onChanged { value in
                offset_1 = value.translation
                offsetFactor.x = mapRange(value: value.translation.width, fromMin: 400, fromMax: -400, toMin: -120, toMax: 120)
                offsetFactor.y = mapRange(value: value.translation.height, fromMin: 400, fromMax: -400, toMin: -40, toMax: 40)
                scale = 0.9
                withAnimation(.linear(duration: 0.3)){
                  opacity = 0.1
                }
              }
              .onEnded { value in
                pos_1.width += value.translation.width
                pos_1.height += value.translation.height
                offset_1 = .zero

                withAnimation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0)){
                  offsetFactor = .zero

                  if pos_1.width >= 0 {
                    pos_1.width = proxy.size.width / 2 - circleSize / 2
                  } else {
                    pos_1.width = -proxy.size.width / 2 + circleSize / 2
                  }
                  scale = 1
                }
              }
          )
      }
    }
    .ignoresSafeArea()
  }

  func mapRange(value: CGFloat, fromMin: CGFloat, fromMax: CGFloat, toMin: CGFloat, toMax: CGFloat) -> CGFloat {
    return (value - fromMin) / (fromMax - fromMin) * (toMax - toMin) + toMin
  }
}

#Preview {
    ChatHeadView()
}
