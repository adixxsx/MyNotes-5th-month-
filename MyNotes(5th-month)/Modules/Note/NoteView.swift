//
//  NoteView.swift
//  MyNotes(5th-month)
//
//  Created by user on 9/3/24.
//

import UIKit
import SnapKit

protocol NoteViewProtocol {
    
    func successAddNote()
    
    func failureAddNote()
    
    func succesDelete()
    
    func failureDelete()
    
}

class NoteView: UIViewController, UITextViewDelegate {
    
    var controller: NoteControllerProtocol?
    
    private let coreCoreService = CoreDataService.shared
    var note: Note?
    
    private lazy var noteSearchBar: UISearchBar = {
        let view = UISearchBar()
        view.placeholder = "Title"
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        view.searchTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return view
    }()
    
    private lazy var uITextView: UITextView = {
        let view = UITextView()
        view.textColor = .label
        view.backgroundColor = UIColor().rgb(r: 238, g: 238, b: 239, alpha: 1)
        view.layer.cornerRadius = 16
        view.tintColor = .label
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var copyButton: UIButton = {
        let view = UIButton(type: .system)
        view.setImage(UIImage(systemName: "square.on.square"), for: .normal)
        view.tintColor = .systemGray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(copyButtonTapped), for: .touchUpInside)
        return view
    }()
    
    private lazy var saveButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("SAVE", for: .normal)
        view.layer.cornerRadius = 20
        view.tintColor = .white
        view.backgroundColor = .systemGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controller = NoteController(view: self)
        setupUI()
        uITextView.delegate = self
        noteSearchBar.searchTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        guard let note = note else {
            return
        }
        noteSearchBar.text = note.title
        //uITextView.text = note.desc
        
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        setupNavigationItem()
        updateInterfaceTheme()
        setupConstrains()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserDefaults.standard.bool(forKey: "Theme") == false {
            view.overrideUserInterfaceStyle = .light
        } else {
            view.overrideUserInterfaceStyle = .dark
        }
    }
    
    private func setupNavigationItem() {
        navigationItem.title = "Notes"
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(TrashButtonTapped))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    
    private func updateInterfaceTheme(isDark: Bool? = nil) {
        if let isDark = isDark {
            UserDefaults.standard.set(isDark, forKey: "Theme")
        }
        let isDarkMode = UserDefaults.standard.bool(forKey: "Theme")
        navigationController?.navigationBar.tintColor = isDarkMode ? .white : .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: isDarkMode ? UIColor.white : UIColor.black]
        navigationItem.rightBarButtonItem?.tintColor = isDarkMode ? .white : .black
    }
    
    private func setupConstrains() {
        
        view.addSubview(noteSearchBar)
        noteSearchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(5)
            make.horizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(40)
        }
        
        view.addSubview(uITextView)
        uITextView.snp.makeConstraints { make in
            make.top.equalTo(noteSearchBar.snp.bottom).offset(26)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalTo(view.snp.bottom).offset(-175)
        }
        
        view.addSubview(copyButton)
        copyButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.bottom).offset(-219)
            make.trailing.equalTo(view.snp.trailing).offset(-35)
            make.height.equalTo(32)
            make.width.equalTo(32)
        }
        
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(uITextView.snp.bottom).offset(80)
            make.horizontalEdges.equalToSuperview().inset(27)
            make.height.equalTo(40)
        }
        
        saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        
    }
    
    @objc func TrashButtonTapped() {
        guard let note = note else {
            return
        }
        
        let alert = UIAlertController(title: "Удаление", message: "Вы действительно хотите удалить заметку", preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: "Да", style: .destructive) { action in
            self.controller?.onDeleteNote(id: note.id ?? "")
        }
        
        let actionDecline = UIAlertAction(title: "Нет", style: .cancel)
        
        alert.addAction(actionDecline)
        alert.addAction(acceptAction)
        
        present(alert, animated: true)
    }
    
    
    @objc private func copyButtonTapped() {
        guard let textToCopy = uITextView.text else {
            return
        }
        UIPasteboard.general.string = textToCopy
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        updateSaveButtonState()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        updateSaveButtonState()
    }
    
    
    private func updateSaveButtonState() {
        let isNotEmpty = !(noteSearchBar.searchTextField.text?.isEmpty ?? true) || !(uITextView.text.isEmpty)
        saveButton.isEnabled = isNotEmpty
        saveButton.backgroundColor = isNotEmpty ? .systemRed : .systemGray
    }
    
    @objc private func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
    }
    
    @objc  func saveButtonPressed() {
        if !(noteSearchBar.searchTextField.text?.isEmpty ?? true) || !(uITextView.text.isEmpty) {
            controller?.onAddNote(note: note, title: noteSearchBar.text ?? "", description: uITextView.text)
        }
    }
}

extension NoteView: NoteViewProtocol {
    
    func successAddNote() {
        navigationController?.popViewController(animated: true)
    }
    
    func failureAddNote() {
        let alert = UIAlertController(title: "Ошибка", message: "Не удалось сохранить заметку!", preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: "ОК", style: .cancel)
        alert.addAction(acceptAction)
        present(alert, animated: true)
    }
    
    func succesDelete() {
        navigationController?.popViewController(animated: true)
    }
    
    func failureDelete() {
        let alert = UIAlertController(title: "Ошибка", message: "Не удалось удалить заметку!", preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: "ОК", style: .cancel)
        alert.addAction(acceptAction)
        present(alert, animated: true)
    }
    
}
