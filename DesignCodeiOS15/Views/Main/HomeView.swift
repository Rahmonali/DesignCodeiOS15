//
//  HomeView.swift
//  DesignCodeiOS15
//
//  Created by Rahmonali on 23/10/23.
//

import SwiftUI

struct HomeView: View {
    
    @Namespace var namespace
    @State var hasScrolled = false
    @State var show = false
    @State var showStatusBar = true
    @State var selectedID = UUID()
    @State var showCourse = false
    @State var selectedIndex = 0
    @EnvironmentObject var model: Model
    @AppStorage("isLiteMode") var isLiteMode = true
    
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            
            ScrollView {
                scrollDetection
                
                featured
                
                Text("Courses".uppercased())
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 300), spacing: 20)], spacing: 20) {
                    if !show {
                        cards
                    } else {
                        ForEach(courses) { course in
                            Rectangle()
                                .fill(.white)
                                .frame(height: 300)
                                .cornerRadius(30)
                                .shadow(color: Color("Shadow"), radius: 20, x: 0, y: 10)
                                .opacity(0.3)
                                .padding(.horizontal, 30)
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
            .coordinateSpace(name: "scroll")
            .safeAreaInset(edge: .top, content: {
                Color.clear.frame(height: 70)
            })
            .overlay(
                NavigationBar(title: "Featured", hasScrolled: $hasScrolled)
            )
            
            if show {
                detail
            }
        }
        .statusBar(hidden: !showStatusBar)
        .onChange(of: show) { newValue in
            withAnimation (.closeCard) {
                if newValue {
                    showStatusBar = false
                } else {
                    showStatusBar = true
                }
            }
        }
    }
}

#Preview {
    HomeView()
        .preferredColorScheme(.dark)
        .environmentObject(Model())
}

extension HomeView {
    private var scrollDetection: some View {
        GeometryReader { proxy in
            Color.clear.preference(key: ScrollPreferenceKey.self, value: proxy.frame(in: .named("scroll")).minY)
        }
        .frame(height: 0)
        .onPreferenceChange(ScrollPreferenceKey.self, perform: { value in
            withAnimation(.easeOut) {
                if value < 0 {
                    hasScrolled = true
                } else {
                    hasScrolled = false
                }
            }
        })
    }
    
    private var featured: some View {
        TabView {
            ForEach(Array(featuredCourses.enumerated()), id: \.offset) { index, course in
                GeometryReader { proxy in
                    let minX = proxy.frame(in: .global).minX
                    
                    FeaturedItem(course: course)
                        .frame(maxWidth: 500)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 40)
                        .rotation3DEffect(
                            .degrees(minX / -10), axis: (x: 0, y: 1, z: 0)
                        )
                        .shadow(color: Color.shadow.opacity(isLiteMode ? 0 : 0.3), radius: 5, x: 0, y: 3)
                        .blur(radius: abs(minX / 40))
                        .overlay {
                            Image(course.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 230)
                                .offset(x: 32, y: -80)
                                .offset(x: minX / 2)
                        }
                        .onTapGesture {
                            showCourse = true
                            selectedIndex = index
                        }
                        .accessibilityElement(children: .combine)
                        .accessibilityAddTraits(.isButton)
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(height: 430)
        .background(
            Image("Blob 1")
                .offset(x: 250, y: -100)
                .accessibilityHidden(true)
        )
        .sheet(isPresented: $showCourse) {
            CourseView(namespace: namespace, course: featuredCourses[selectedIndex], show: $showCourse)
        }
    }
    
    private var cards: some View {
        ForEach(courses) { course in
            CourseItem(namespace: namespace, course: course, show: $show)
                .onTapGesture {
                    withAnimation(.openCard) {
                        show.toggle()
                        model.showDetail.toggle()
                        showStatusBar = false
                        selectedID = course.id
                    }
                }
                .accessibilityElement(children: .combine)
                .accessibilityAddTraits(.isButton)
        }
    }
    
    private var detail: some View {
        ForEach(courses) { course in
            if course.id == selectedID {
                CourseView(namespace: namespace, course: course, show: $show)
                    .zIndex(1)
                    .transition(.asymmetric(
                        insertion: .opacity.animation(.easeInOut(duration: 0.1)),
                        removal: .opacity.animation(.easeInOut(duration: 0.3).delay(0.2)))
                    )
            }
        }
    }
}
