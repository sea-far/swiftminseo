
import SwiftUI

struct MyApp: View {
    @State private var showModal = false
     let now = Date.now

    var body: some View {
        VStack {
            Spacer()
                .frame(height: 20)

            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 330, height: 45)
                    .cornerRadius(30)
                    .shadow(color: .gray.opacity(0.2), radius: 10, x: 5, y: 5)
                    .overlay(
                        VStack {
                            Rectangle()
                                Text("국어 비문학 격파 하는 중..🔥")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.red)
                        }
                    )
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 400, height: 900)
                    .cornerRadius(30)
                    .shadow(color: .gray.opacity(0.2), radius: 10, x: 5, y: 5)
                    .overlay(
                        VStack {
                            Rectangle()
                                .fill(Color.white)
                                .frame(width: 330, height: 45)
                                .cornerRadius(30)
                                .shadow(color: .gray.opacity(0.2), radius: 10, x: 5, y: 5)
                                .overlay(
                                    Text("국어 비문학 격파 하는 중..🔥")
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.red)
                                )
                                
                            
                            Image(.image)
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                            
                            StopwatchView(size: .medium, colorTheme: .black)
                            
                            Text("현재 아수라백작님은")
                                .font(.title)
                                .fontWeight(.bold)
                            Text("키스 갈기는 물고기 1단계 입니다.")
                                .fontWeight(.bold)
                            
                            Button(action: {
                                showModal = true
                            }) {
                                Rectangle()
                                    .fill(Color.white)
                                    .frame(width: 193.054, height: 50)
                                    .cornerRadius(30)
                                    .shadow(color: .gray.opacity(0.2), radius: 10, x: 5, y: 5)
                                    .overlay(
                                        Text("활동 바꾸기")
                                            .fontWeight(.bold)
                                            .foregroundColor(Color.red)
                                    )
                            }
                        }
                        .padding(11.0)
                    )
                Rectangle()
                    .fill(Color.white)
                    .padding([.top, .leading, .trailing], 307.349)
                    .cornerRadius(30)
                    //.shadow(color: .gray.opacity(0.2), radius: 10, x: 5, y: 5)
                    .frame(width: 330, height: 114.032)
                    .overlay(
                        VStack {
                            
                        
                        }
                    )
            }
            
            
        }
        // 모달 창을 표시하는 sheet
        .sheet(isPresented: $showModal) {
            Modal() // Modal 파일에서 만든 뷰를 표시
        }
    }
}
