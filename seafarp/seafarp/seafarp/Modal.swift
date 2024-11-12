import SwiftUI

struct Modal: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("변경을 하세요")
                .font(.title)
                .padding()

            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("닫기")
                    
            }
            .padding()
        }
    }
}
