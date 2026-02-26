//
//  RaceSample.swift
//  TopApps
//
//  Created by Nader Alfares on 2/23/26.
//
import SwiftUI

// MARK: - Not thread-safe on purpose
class UnsafeCounter {
    private(set) var value: Int = 0
    
    func increment() {
        // Simulate some work so threads overlap
        let old = value
        usleep(1_000) // 1 ms
        value = old + 1
    }
    
    func reset() {
        value = 0
    }
}

// MARK: - Thread-safe via actor
actor SafeCounter {
    private(set) var value: Int = 0
    
    func increment() {
        // Actor guarantees serialized access
        let old = value
        usleep(1_000)
        value = old + 1
    }
    
    func reset() {
        value = 0
    }
}

// MARK: - SwiftUI View showing both
struct RaceVsActorView: View {
    @State private var classLog = ""
    @State private var actorLog = ""
    
    // Same counters reused between runs
    private let unsafeCounter = UnsafeCounter()
    private let safeCounter = SafeCounter()
    
    private let iterations = 1000
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                
                Text("Race Condition: Class vs Actor")
                    .font(.title)
                    .bold()
                
                // MARK: Class (Not thread-safe)
                RunBlockView(
                    title: "Class (Not Thread-safe)",
                    codeLog: $classLog,
                    codeBlock:{ runUnsafe() }
                    )
                
                    
                // MARK: Actor (Thread-safe)
                RunBlockView(
                    title: "Actor (Thread-Safe)",
                    codeLog: $actorLog,
                    codeBlock:{ runSafe() }
                )
            }
            .padding()
        }
    }
    
    // MARK: - Actor race: fixed with Swift concurrency
    private func runSafe() {
        actorLog = "Running actor race…"
        
        Task {
            await safeCounter.reset()
            
            // Use same DispatchQueue approach, but actor protects access
            let queue = DispatchQueue(label: "safe.race.queue", attributes: .concurrent)
            let group = DispatchGroup()
            
            for _ in 0..<iterations {
                group.enter() // Manually track the async work
                queue.async(group: group) {
                    // Multiple threads hit this at the same time
                    // But the actor serializes access automatically
                    Task {
                        await self.safeCounter.increment()
                        group.leave() // Signal completion after actor work is done
                    }
                }
            }
            
            // Notify when all work is done (non-blocking)
            group.notify(queue: .main) { [self] in
                Task {
                    let final = await self.safeCounter.value
                    
                    self.actorLog = """
                    Expected: \(self.iterations)
                    Actual:   \(final)
                    """
                }
            }
        }
    }
    
    private func runUnsafe() {
        classLog = "Running class race…"
        
        unsafeCounter.reset()
        
        // Use DispatchQueue to guarantee concurrent thread access
        let queue = DispatchQueue(label: "race.queue", attributes: .concurrent)
        let group = DispatchGroup()
        
        for _ in 0..<iterations {
            group.enter()
            queue.async(group: group) { [unsafeCounter] in
                // Multiple threads hit this at the same time
                unsafeCounter.increment()
                group.leave()
            }
        }
        
        // Notify when all work is done (non-blocking)
        group.notify(queue: .main) { [self, unsafeCounter] in
            let final = unsafeCounter.value
            
            self.classLog = """
            Expected: \(self.iterations)
            Actual:   \(final)
            """
        }
    }
}


struct RunBlockView : View {
    var title : String = "No Title"
    @Binding var codeLog : String
    var codeBlock : () -> Void
    var body : some View {
        GroupBox(title) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Button("Run code block") {
                        codeBlock()
                    }
                    Spacer()
                }
                .buttonStyle(.borderedProminent)
                
                Text(codeLog)
                    .font(.system(.body, design: .monospaced))
                    .padding(.top, 4)
            }
        }
    }
}


#Preview {
    RaceVsActorView()
}
