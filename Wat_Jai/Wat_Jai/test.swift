import SwiftUI

struct Test : View {
    
    @State private var isAnimating: Bool = false
    
    var body: some View {
        ZStack {
            ForEach(0..<5) { index in
                Circle()
                    .foregroundColor(.blue)
                    .frame(width: 50 - CGFloat(index) * 10, height: 50 - CGFloat(index) * 10)
                    .offset(y: -100)
                    .rotationEffect(.degrees(isAnimating ? 360 : 0))
                    .animation(
                        Animation.easeInOut(duration: 2 - Double(index) * 0.2)
                            .delay(Double(index) * 0.2)
                            .repeatForever(autoreverses: false),
                        value: isAnimating
                    )
            }
        }
        .onAppear {
            isAnimating = true
        }
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
