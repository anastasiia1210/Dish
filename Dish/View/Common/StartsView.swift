import SwiftUI

struct StarsView: View {
    @Binding var rating: Double
    let isInteractive: Bool
    
    init(rating: Binding<Double>, isInteractive: Bool = true) {
        self._rating = rating
        self.isInteractive = isInteractive
    }
    
    var body: some View {
        HStack(spacing: 5) {
            ForEach(1...5, id: \.self) { index in
                Image(systemName: index <= Int(rating) ? "star.fill" : "star")
                    .foregroundColor(.yellow)
                    .aspectRatio(contentMode: .fit)
                    .onTapGesture {
                        if isInteractive { 
                            rating = (rating == Double(index)) ? 0 : Double(index)
                        }
                    }
            }
        }
    }
}
