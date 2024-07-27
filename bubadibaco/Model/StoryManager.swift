//
//  StoryManager.swift
//  bubadibaco
//
//  Created by Pelangi Masita Wati on 25/07/24.
//

import Foundation

class StoryManager {
    static let shared = StoryManager()
    private init() {}
    
    var stories: [Story] = [
        Story(name: "Terry and Trixie", isUnlocked: true),
        Story(name: "Another Story 1", isUnlocked: false),
        Story(name: "Another Story 2", isUnlocked: false)
    ]
    
    func unlockNextStory(after story: Story) {
        if let index = stories.firstIndex(where: { $0.name == story.name }) {
            let nextIndex = index + 1
            if nextIndex < stories.count {
                stories[nextIndex].isUnlocked = true
            }
        }
    }
    
    func unlockNextStoryIfNeeded() {
        if let firstLockedIndex = stories.firstIndex(where: { !$0.isUnlocked }) {
            if firstLockedIndex > 0 && stories[firstLockedIndex - 1].isUnlocked {
                stories[firstLockedIndex].isUnlocked = true
            }
        }
    }
}
