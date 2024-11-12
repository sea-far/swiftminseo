import SwiftUI

struct StopwatchView: View {
    @State private var startTime: Date?
    @State private var accumulatedTime: TimeInterval = 0
    
    let size: Size
    let colorTheme: Color
    
    var body: some View {
        VStack {
            TimelineView(.animation(minimumInterval: 0.01)) { timeline in
                Text(timerString(from: elapsedTime(date: timeline.date)))
                    .font(size.font)
                    .foregroundStyle(colorTheme)
                    .monospacedDigit()
            }
            
            HStack {
                Button(startTime == nil ? "시작" : "일시정지") {
                    if startTime == nil {
                        startTime = Date()
                    } else {
                        accumulatedTime += Date().timeIntervalSince(startTime!)
                        startTime = nil
                    }
                }
                .buttonStyle(CustomButtonStyle())
                
                Button("끝내기") {
                    startTime = nil
                    accumulatedTime = 0
                }
                .buttonStyle(CustomButtonStyle())
            }
        }
    }
    
    private func elapsedTime(date: Date) -> TimeInterval {
        if let startTime = startTime {
            return accumulatedTime + date.timeIntervalSince(startTime)
        } else {
            return accumulatedTime
        }
    }
    
    private func timerString(from interval: TimeInterval) -> String {
        let hundredths = Int((interval.truncatingRemainder(dividingBy: 1)) * 100)
        let seconds = Int(interval.truncatingRemainder(dividingBy: 60))
        let minutes = Int(interval / 60)
        
        return String(format: "%02d:%02d:%02d", minutes, seconds, hundredths)
    }
    
    enum Size {
        case small
        case medium
        case large
        case extraLarge
        
        var font: Font {
            switch self {
            case .small:
                return Font.headline
            case .medium:
                return Font.largeTitle
            case .large:
                return Font.system(size: 70, weight: .regular)
            case .extraLarge:
                return Font.system(size: 100, weight: .regular)
            }
        }
    }
}

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .cornerRadius(30)
            .scaleEffect(configuration.isPressed ? 0.5 : 1)
            .fontWeight(.heavy)
            .frame(width: 145, height: 40)
            .background(Color.init(red: 25/255, green: 61/255, blue: 241/255))
            .foregroundColor(.white)
            .cornerRadius(30)
            .shadow(color: .gray.opacity(0.2), radius: 10,x:5,y:5)
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

#Preview("Font-small") {
    StopwatchView(size: .small, colorTheme: .blue)
}

#Preview("Font-medium") {
    StopwatchView(size: .medium, colorTheme: .red)
}

#Preview("Font-large") {
    StopwatchView(size: .large, colorTheme: .purple)
}

#Preview("Font-extraLarge") {
    StopwatchView(size: .extraLarge, colorTheme: .primary)
}
