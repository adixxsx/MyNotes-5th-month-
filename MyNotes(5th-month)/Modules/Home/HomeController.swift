//
//  HomeController.swift
//  MyNotes(5th-month)
//
//  Created by user on 21/2/24.
//

protocol HomeControllerProtocol {
    
    func onGetNotes()
    
    func onSuccesNotes(notes: [Note])
    
    func onNoteSearching(text: String)
    
    func onSearchResult(notes: [Note])
}

class HomeController: HomeControllerProtocol {
    
    private var view: HomeViewProtocol?
    private var model: HomeModelProtocol?
    
    init(view: HomeViewProtocol) {
        self.view = view
        self.model = HomeModel(controller: self)
    }
    
    func onGetNotes() {
        model?.getNotes()
    }
    
    func onSuccesNotes(notes: [Note]) {
        view?.successNotes(notes: notes)
        
    }
    
    func onNoteSearching(text: String) {
        model?.searchNotes(text: text)
    }
    
    func onSearchResult(notes: [Note]) {
        view?.successNotes(notes: notes)
    }
    
}
