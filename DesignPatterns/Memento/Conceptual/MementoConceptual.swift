//
//  MementoConceptual.swift
//  Memento
//
//  Created by Dmitriy Polurezov on 10.06.2020.
//

/// Паттерн Снимок
///
/// Назначение: Фиксирует и восстанавливает внутреннее состояние объекта таким
/// образом, чтобы в дальнейшем объект можно было восстановить в этом состоянии
/// без нарушения инкапсуляции.

import XCTest

/// Создатель содержит некоторое важное состояние, которое может со временем
/// меняться. Он также объявляет метод сохранения состояния внутри снимка и
/// метод восстановления состояния из него.
class Originator {

    /// Для удобства состояние создателя хранится внутри одной переменной.
    private var state: String

    init(state: String) {
        self.state = state
        debugPrint("Originator: My initial state is: \(state)")
    }

    /// Бизнес-логика Создателя может повлиять на его внутреннее состояние.
    /// Поэтому клиент должен выполнить резервное копирование состояния с
    /// помощью метода save перед запуском методов бизнес-логики.
    func doSomething() {
        debugPrint("Originator: I'm doing something important.")
        state = generateRandomString()
        debugPrint("Originator: and my state has changed to: \(state)")
    }

    private func generateRandomString() -> String {
        return String(UUID().uuidString.suffix(4))
    }

    /// Сохраняет текущее состояние внутри снимка.
    func save() -> MementoType {
        return ConcreteMemento(state: state)
    }

    /// Восстанавливает состояние Создателя из объекта снимка.
    func restore(memento: MementoType) {
        guard let memento = memento as? ConcreteMemento else { return }
        self.state = memento.state
        debugPrint("Originator: My state has changed to: \(state)")
    }
}

/// Интерфейс Снимка предоставляет способ извлечения метаданных снимка, таких
/// как дата создания или название. Однако он не раскрывает состояние Создателя.
protocol MementoType {
    var name: String { get }
    var date: Date { get }
}

/// Конкретный снимок содержит инфраструктуру для хранения состояния Создателя.
class ConcreteMemento: MementoType {

    /// Создатель использует этот метод, когда восстанавливает своё состояние.
    private(set) var state: String
    private(set) var date: Date

    init(state: String) {
        self.state = state
        self.date = Date()
    }

    /// Остальные методы используются Опекуном для отображения метаданных.
    var name: String {
        return state + " " + date.description.suffix(14).prefix(8)
    }
}

/// Опекун не зависит от класса Конкретного Снимка. Таким образом, он не имеет
/// доступа к состоянию создателя, хранящемуся внутри снимка. Он работает со
/// всеми снимками через базовый интерфейс Снимка.
class Caretaker {

    private lazy var mementos: [MementoType] = []
    private var originator: Originator

    init(originator: Originator) {
        self.originator = originator
    }

    func backup() {
        debugPrint("\nCaretaker: Saving Originator's state...\n")
        mementos.append(originator.save())
    }

    func undo() {

        guard !mementos.isEmpty else {
            return
        }

        let removedMemento = mementos.removeLast()

        debugPrint("Caretaker: Restoring state to: " + removedMemento.name)
        originator.restore(memento: removedMemento)
    }

    func showHistory() {
        debugPrint("Caretaker: Here's the list of mementos:\n")
        mementos.forEach { debugPrint($0.name) }
    }
}

/// Давайте посмотрим как всё это будет работать.
class MementoConceptual: XCTestCase {

    func testMementoConceptual() {

        let originator = Originator(state: "Super-duper-super-puper-super.")
        let caretaker = Caretaker(originator: originator)

        caretaker.backup()
        originator.doSomething()

        caretaker.backup()
        originator.doSomething()

        caretaker.backup()
        originator.doSomething()

        debugPrint("\n")
        caretaker.showHistory()

        debugPrint("\nClient: Now, let's rollback!\n\n")
        caretaker.undo()

        debugPrint("\nClient: Once more!\n\n")
        caretaker.undo()
    }
}
