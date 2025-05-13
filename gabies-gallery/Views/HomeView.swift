//
//  HomeView.swift
//  gabies-gallery
//
//  Created by Farrell Matthew Lim on 09/05/25.
//

import SwiftUI

struct HomeView: View {
    @State private var isDoorOpened = false
    @State private var startZoom = false
    @Binding var showGallery: Bool

    var body: some View {
        ZStack(alignment: .bottom) {
            WallView()

            VStack(spacing: 0) {
                VStack(spacing: 60) {
                    Text("Gabie's\nGallery")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.black)
                        .opacity(isDoorOpened ? 0 : 1)

                    ZStack {
                        if isDoorOpened {
                            OpenedDoorView()
                                .transition(.opacity)
                        } else {
                            Button(action: {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    isDoorOpened = true
                                }

                                DispatchQueue.main.asyncAfter(
                                    deadline: .now() + 0.5
                                ) {
                                    withAnimation(.easeInOut(duration: 1.0)) {
                                        startZoom = true
                                    }

                                    DispatchQueue.main.asyncAfter(
                                        deadline: .now() + 0.6
                                    ) {
                                        showGallery = true
                                    }
                                }
                            }) {
                                ClosedDoorView()
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }.zIndex(3)

                FloorView()
            }
        }
        .scaleEffect(startZoom ? 5 : 1)
        .opacity(startZoom ? 0 : 1)
        .edgesIgnoringSafeArea(.all)
    }
}

struct DoorCommonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 250, height: 450)
            .shadow(color: Color.black.opacity(0.1), radius: 8, x: 4, y: 4)
            .padding(.top, 10)
            .padding(.horizontal, 10)
            .border(Color(red: 45 / 255, green: 42 / 255, blue: 38 / 255))
            .padding(.bottom, -1)
    }
}

struct ClosedDoorView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(red: 45 / 255, green: 42 / 255, blue: 38 / 255))
            Rectangle()
                .fill(Color.gray.opacity(0.6))
                .frame(width: 8, height: 30)
                .offset(x: 80)
        }
        .modifier(DoorCommonStyle())
    }
}

struct OpenedDoorView: View {
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.black)
                .border(Color(red: 45 / 255, green: 42 / 255, blue: 38 / 255))
            Rectangle()
                .fill(Color(red: 45 / 255, green: 42 / 255, blue: 38 / 255))
                .frame(width: 20)
        }
        .modifier(DoorCommonStyle())
    }
}

#Preview {
    HomeView(showGallery: .constant(false))
}
