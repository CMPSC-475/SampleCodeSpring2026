//
//  SketchifyManager.swift
//  Sketchify
//
//  Created by Nader Alfares on 1/26/26.
//
import SwiftUI

@Observable
class SketchifyManager {
    
    var drawingPages : [DrawingPage]
    
    private let persistenceManager: PersistenceManager
    
    init() {
        self.persistenceManager = PersistenceManager()
        self.drawingPages = persistenceManager.loadPages()
    }
    
    
    func addNewPage(_ page: DrawingPage? = nil) {
        if let page = page {
            drawingPages.append(page)
        } else {
            drawingPages.append(DrawingPage())
        }
        
        persistenceManager.savePages(drawingPages)
    }
    
    
    func deletePage(_ page: DrawingPage) {
        guard let index = drawingPages.firstIndex(where: { $0.id == page.id }) else {
            print("Could not find page with ID \(page.id) to delete")
            return
        }
        drawingPages.remove(at: index)
        persistenceManager.savePages(drawingPages)
    }
    
    func updatePage(_ page: DrawingPage) {
        guard let index = drawingPages.firstIndex(where: { $0.id == page.id }) else {
            print("Could not find page with ID \(page.id) to update")
            return
        }
        drawingPages[index] = page
        persistenceManager.savePages(drawingPages)
    }
    
    func deleteAllPages() {
        drawingPages.removeAll()
        persistenceManager.savePages(drawingPages)
    }
    
    
}

