//
//  HomeModel.swift
//  MyNotes(5th-month)
//
//  Created by user on 21/2/24.
//

protocol HomeModelProtocol {
    func getNotes()
}

class HomeModel: HomeModelProtocol {
    
    private let controller: HomeControllerProtocol?
    
    private let coreDataService = CoreDataService.shared
    
    init(controller: HomeControllerProtocol) {
        self.controller = controller
    }
    
    private var notes: [Note] = []
    
    func getNotes() {
        notes = coreDataService.fetchNotes()
        controller?.onSuccesNotes(notes: notes)
    }
    
}
