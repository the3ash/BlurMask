import SwiftUI

// MARK: - Main Example Views

// MARK: - Standard Material Navigation Example

struct MaterialNavigationExample: View {
  @State private var topBarHeight: CGFloat = 0

  var body: some View {
    ZStack(alignment: .top) {
      // Main content list
      ScrollView {
        LazyVStack(spacing: 16) {
          ForEach(0..<8, id: \.self) { index in
            DemoCard(index: index)
          }
        }
        .padding(.horizontal, 32)
        .padding(.top, 16)
      }
      .scrollContentBackground(.hidden)
      .safeAreaInset(edge: .top) {
        Color.clear.frame(height: topBarHeight)
      }

      // Material navigation bar
      TitleBar(title: "Material Nav")
        .background(
          GeometryReader { geometry in
            ZStack {
              // System material effect
              Rectangle()
                .fill(.ultraThinMaterial)
                .ignoresSafeArea(edges: .top)

              // Background overlay
              Color(.secondarySystemBackground).opacity(0.4)
                .ignoresSafeArea(edges: .top)

              Color.clear.onAppear {
                topBarHeight = geometry.size.height
              }
            }
          }
        )
    }
    .background(Color(.secondarySystemBackground))
  }
}

// MARK: - BlurMask Navigation Example

struct BlurMaskNavigationExample: View {
  @State private var topBarHeight: CGFloat = 0

  var body: some View {
    ZStack(alignment: .top) {
      // Main content list
      ScrollView {
        LazyVStack(spacing: 16) {
          ForEach(0..<8, id: \.self) { index in
            DemoCard(index: index)
          }
        }
        .padding(.horizontal, 32)
        .padding(.top, 16)
      }
      .scrollContentBackground(.hidden)
      .safeAreaInset(edge: .top) {
        Color.clear.frame(height: topBarHeight)
      }

      // Navigation bar with BlurMask
      TitleBar(title: "BlurMask Nav")
        .background(
          GeometryReader { geometry in
            ZStack {
              // BlurMask effect
              BlurMask()
                .ignoresSafeArea(edges: .top)

              // Background overlay
              Color(.secondarySystemBackground).opacity(0.4)
                .ignoresSafeArea(edges: .top)

              Color.clear.onAppear {
                topBarHeight = geometry.size.height
              }
            }
          }
        )
    }
     // the backgroundcolor of view must be without opacity
     // or remove the background of TitleBar
    .background(Color(.secondarySystemBackground))
  }
}

struct TitleBar: View {
  let title: String

  var body: some View {
    HStack {
      Text(title)
        .font(.headline)
        .fontWeight(.semibold)
        .foregroundColor(.primary)
      Spacer()
    }
    .padding(.horizontal, 32)
    .padding(.vertical, 16)
    .frame(height: 52)
  }
}

struct DemoCard: View {
  let index: Int

  var body: some View {
    Rectangle()
      .fill(.blue)
      .frame(height: 128)
      .cornerRadius(12)
      .contentShape(Rectangle())
  }
}

// MARK: - SwiftUI Previews

#Preview("Material Navigation") {
  MaterialNavigationExample()
}

#Preview("BlurMask Navigation") {
  BlurMaskNavigationExample()
}
