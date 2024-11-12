import SwiftUI

enum ComponentType {
    case text
    case linear
    case circular
}

struct SimpleTimer: View {
    @Binding var timeRemaining: TimeInterval
    @State private var initialTime: TimeInterval
    @State private var isRunning = false
    @State private var startTime: Date?
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var timeFormat: String
    let components: Set<ComponentType>
    
    init(timeRemaining: Binding<TimeInterval>, timeFormat: String = "mm:ss", components: Set<ComponentType> = [.text]) {
        self._timeRemaining = timeRemaining
        self._initialTime = State(initialValue: timeRemaining.wrappedValue)
        self.timeFormat = timeFormat
        self.components = components
    }
    
    var body: some View {
        VStack {
            ZStack {
                if components.contains(.text) {
                    Text(formattedTime)
                        .font(.system(size: 45, weight: .bold))
                }
                if components.contains(.linear) {
                    LinearTimerView(progress: progress)
                        .frame(height: 50)
                        .padding()
                }
                if components.contains(.circular) {
                    CircularTimerView(progress: progress)
                                    .frame(width: 280)
                }
            }

            
            HStack(spacing: 20) {
                Button(action: {
                    if isRunning {
                        pauseTimer()
                    } else {
                        startTimer()
                    }
                }) {
                    Text(isRunning ? "일시정지" : "재시작")
                        .fontWeight(.heavy)
                        .frame(width: 145, height: 40)
                        .background(isRunning ? Color.init(red: 217/255, green: 25/255, blue: 25/255) : Color.white)
                        .foregroundColor(isRunning ? Color.white : Color.black)
                        .cornerRadius(30)
                        .shadow(color: .gray.opacity(0.2), radius: 10,x:5,y:5)
                }
                
                Button(action: {
                    resetTimer()
                    
                }) {
                    Text("휴식 끝")
                        .fontWeight(.heavy)
                        .frame(width: 145, height: 40)
                        .background(Color.init(red: 25/255, green: 61/255, blue: 241/255))
                        .foregroundColor(.white)
                        .cornerRadius(30)
                        .shadow(color: .gray.opacity(0.2), radius: 10,x:5,y:5)
                }
            }
        }
        .onReceive(timer) { _ in
            if isRunning {
                updateTimer()
            }
        }
    }
    
    private func startTimer() {
        startTime = Date()
        isRunning = true
    }
    
    private func pauseTimer() {
        startTime = nil
        isRunning = false
    }
    
    private func resetTimer() {
        timeRemaining = initialTime
        startTime = nil
        isRunning = false
    }
    
    private func updateTimer() {
        guard let startTime = startTime else { return }
        let elapsedTime = Date().timeIntervalSince(startTime)
        timeRemaining = max(0, initialTime - elapsedTime)
        
        if timeRemaining == 0 {
            isRunning = false
            self.startTime = nil
        }
    }
    
    var progress: Double {
        1 - (timeRemaining / initialTime)
    }
    
}

struct GallaryView: View {
    @State private var time: TimeInterval = 60 * 60 * 3
    
    var body: some View {
        ScrollView {
            VStack(spacing: 150) {
                SimpleTimer(timeRemaining: $time, timeFormat: "HH:mm:ss", components: [.text])
                    
                Divider()
                SimpleTimer(timeRemaining: $time, timeFormat: "mm:ss", components: [.text, .linear])
                Divider()
                SimpleTimer(timeRemaining: $time, timeFormat: "mm:ss.SSS", components: [.text, .circular])
            }
        }
    }
}

#Preview {
    GallaryView()
}
