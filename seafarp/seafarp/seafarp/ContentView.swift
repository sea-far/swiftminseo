import SwiftUI

struct ContentView: View {
    @State private var remain: TimeInterval = 900
    @State private var show_alert = false
    @State private var todo_input : String = ""
    
    @State private var lists = ["국어 비문학", "수학문제 풀기","영어 공부","swift 공부하기"]
    

    var body: some View {
        VStack {
            ZStack {
                VStack {
                    SimpleTimer(timeRemaining: $remain, timeFormat: "HH:mm:ss", components: [.circular, .text])
                }
            }
            .padding(.top, 30)
            
            ScrollView {
                VStack (spacing:30){
                    ForEach(lists.indices, id: \.self) {
                        index in
                        
                        Button(action: {
                            
                        }) {
                            HStack {
                                Image("play-circle")
                                    .padding()
                                Text("\(lists[index])")
                                    .fontWeight(.heavy)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                                Button("...") {
                                    lists.remove(at: index)
                                }
                                .padding()
                            }
                            
                            .frame(width: 300, height: 50)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }.shadow(color: .gray.opacity(0.2), radius: 10, x: 5, y: 5)
                            .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.top, 150)
                .frame(height: 200)
                
                
                
            }
                
                Button(action: {
                    
                }) {
                    Image("Group 17")
                }
                .frame(width: 90, height: 30)
                .background(Color.init(red: 25/255, green: 61/255, blue: 249/255))
                .clipShape(RoundedRectangle(cornerRadius: 15))
            }.shadow(color: .gray.opacity(0.2), radius: 10, x: 5, y: 5)
                .buttonStyle(PlainButtonStyle())
                .padding(.top, 0)
                //.alert(isPresented: $show_alert, content: {
                    //alert.addTextField()
                    
                //})
            //.position(x: 200, y: 210)
            //}
            
            
        }
    }


#Preview {
    ContentView()
}
