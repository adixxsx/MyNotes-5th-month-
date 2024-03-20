//
//  HomeModel.swift
//  MyNotes(5th-month)
//
//  Created by user on 21/2/24.
//

protocol HomeModelProtocol {
    
    func getNotes()
    
    func searchNotes(text: String)
}

class HomeModel: HomeModelProtocol {
    
    private let controller: HomeControllerProtocol?
    
    private let coreDataService = CoreDataService.shared
    
    init(controller: HomeControllerProtocol) {
        self.controller = controller
    }
    
    private var notes: [Note] = []
    
    private var filteredNotes: [Note] = []
    
    func getNotes() {
        notes = coreDataService.fetchNotes()
        controller?.onSuccesNotes(notes: notes)
    }
    
    func searchNotes(text: String) {
        filteredNotes = []
        if text.isEmpty {
            filteredNotes = notes
            controller?.onSuccesNotes(notes: notes)
        } else {
            filteredNotes = notes.filter({ note in
                note.title!.uppercased().contains(text.uppercased())
            })
            controller?.onSuccesNotes(notes: filteredNotes)
        }
    }
    
}

