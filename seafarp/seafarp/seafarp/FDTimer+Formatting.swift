import SwiftUI

extension SimpleTimer {
    var formattedTime: String {
        let totalSeconds = Int(timeRemaining)
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        let milliseconds = Int((timeRemaining.truncatingRemainder(dividingBy: 1)) * 100)
        
        let showHours = timeFormat.contains("H")
        let showMinutes = timeFormat.contains("m")
        let showSeconds = timeFormat.contains("s")
        let showMilliseconds = timeFormat.contains("S")
        
        var components: [String] = []
        var totalValue = 0
        
        if showHours {
            totalValue = hours
            components.append(String(format: "%02d", totalValue))
        }
        
        if showMinutes {
            totalValue = showHours ? minutes : hours * 60 + minutes
            components.append(String(format: "%02d", totalValue))
        }
        
        if showSeconds {
            totalValue = showMinutes ? seconds : (hours * 3600 + minutes * 60 + seconds)
            components.append(String(format: "%02d", totalValue))
        }
        
        if showMilliseconds {
            components.append(String(format: "%02d", milliseconds))
        }
        
        let separator = timeFormat.contains("분") ? "분 " : ":"
        var result = components.joined(separator: separator)
        
        if timeFormat.contains("분") && showSeconds {
            result += "초"
        }
        
        return result
    }
}

struct LinearTimerView: View {
    var progress: Double
    
    var body: some View {
        GeometryReader { context in
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: CGFloat(progress) * context.size.width)
                    .animation(.linear, value: progress)
            }
        }
        .cornerRadius(5)
    }
}
struct CircularTimerView: View {
    var progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 17)
                .opacity(0.3)
                .foregroundColor(.init(red: 210/255, green: 215/255, blue: 225/255))
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(progress, 900.0)))
                .stroke(style: StrokeStyle(lineWidth: 17, lineCap: .round, lineJoin: .round))
                .foregroundColor(.init(red: 25/255, green: 61/255, blue: 249/255))
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear, value: progress)
        }
    }
}
