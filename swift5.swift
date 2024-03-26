// Создание класса родитель и 2х наследников класса
class Character {
    var name: String
    var health: Int

    init(name: String, health: Int) {
        self.name = name
        self.health = health
    }
}

class LongRange: Character {
    var support: Bool

    init(name: String, health: Int, isSupport: Bool) {
        self.support = isSupport
        super.init(name: name, health: health)
    }

    func performance() {
        print("Я персонаж дальнего боя - \(name). У меня \(health) единиц здоровья.")
    }
}

class SwordsMan: Character {
    var carry: Bool

    init(name: String, health: Int, isCarry: Bool) {
        self.carry = isCarry
        super.init(name: name, health: health)
    }

    func performance() {
        print("Я персонаж ближнего боя - \(name). У меня \(health) едениц здоровья")
    }
}

// Пример использования:
let Dazzle = LongRange(name: "Дазл", health: 350, isSupport: true)
Dazzle.performance()

let Slark = SwordsMan(name: "Сларк", health: 500, isCarry: true)
Slark.performance()

///////////////////////////////////////////////////////////////////////////////////////////////////////////

// Создание класса *House* в котором несколько свойств - *width*, *height* и несколько методов: *create*(выводит площадь),*destroy*(отображает что дом уничтожен)
class House {
    var width: Double
    var height: Double

    init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }

    func create() {
        let area = width * height
        print("Площадь дома: \(area) кв. м.")
    }

    func destroy() {
        print("Дом уничтожен.")
    }
}

let myHouse = House(width: 21.0, height: 14.0)
myHouse.create() 
myHouse.destroy()

// 3. Создайте класс с методами, которые сортируют массив учеников по разным параметрам

class Student {
    var name: String
    var age: Int
    var averageScore: Double

    init(name: String, age: Int, averageScore: Double) {
        self.name = name
        self.age = age
        self.averageScore = averageScore
    }

    // Метод для сортировки по имени
    static func sortByName(_ students: inout [Student]) {
        students.sort { $0.name < $1.name }
    }

    // Метод для сортировки по возрасту
    static func sortByAge(_ students: inout [Student]) {
        students.sort { $0.age < $1.age }
    }

    // Метод для сортировки по среднему баллу
    static func sortByAverageScore(_ students: inout [Student]) {
        students.sort { $0.averageScore > $1.averageScore }
    }
}

var studentArray: [Student] = [
    Student(name: "Монах", age: 19, averageScore: 4.0),
    Student(name: "Клоп", age: 17, averageScore: 3.1),
    Student(name: "Пузырь", age: 22, averageScore: 2.3),
    Student(name: "Лысый", age: 29, averageScore: 2.75)
]

// Сортировка по имени
Student.sortByName(&studentArray)
print("Сортировка по имени:")
for student in studentArray {
    print("\(student.name), возраст \(student.age), средний балл \(student.averageScore)")
}

// Сортировка по возрасту
Student.sortByAge(&studentArray)
print("\nСортировка по возрасту:")
for student in studentArray {
    print("\(student.name), возраст \(student.age), средний балл \(student.averageScore)")
}

// Сортировка по среднему баллу
Student.sortByAverageScore(&studentArray)
print("\nСортировка по среднему баллу:")
for student in studentArray {
    print("\(student.name), возраст \(student.age), средний балл \(student.averageScore)")
}

// 4. Написать свою структуру и класс, и пояснить в комментариях - чем отличаются структуры от классов
//Структура:
struct PersonData {
    let firstName: String
    let lastName: String
    let age: Int
}
//Класс:
class Person {
    let firstName: String
    let lastName: String
    var age: Int

    init(firstName: String, lastName: String, age: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }


// Структуры являются значимыми типами. Предназначены для хранения данных, не поддерживают наследование. Свойства в структурах неизменяемые.
// Классы представляют собой ссылочные типы данных. Используются для создания объектов, которыем имеют изменяемое состояние и поведение.

//5.Напишите простую программу, которая отбирает комбинации в покере из рандомно выбранных 5 карт
//Сохраняйте комбинации в массив
//Если выпала определённая комбинация - выводим соответствующую запись в консоль
//Результат в консоли примерно такой: 'У вас бубновый стрит флеш'

enum Suit: String, CaseIterable {
    case hearts = "черви"
    case diamonds = "бубны"
    case clubs = "крести"
    case spades = "пики"
}

enum Rank: Int {
    case двойка = 2, тройка, четверка, пятерка, шестерка, семерка, восьмерка, девятка, десятка
    case валет, дама, король, туз
}

struct Card {
    let rank: Rank
    let suit: Suit
}

func randomCard() -> Card {
    let randomRank = Rank(rawValue: Int.random(in: 2...14))!
    let randomSuit = Suit.allCases.randomElement()!
    return Card(rank: randomRank, suit: randomSuit)
}

func isStraight(_ hand: [Card]) -> Bool {
    let sortedRanks = hand.map { $0.rank.rawValue }.sorted()
    return Set(sortedRanks) == Set(sortedRanks.min()!...sortedRanks.max()!)
}

func isFourOfAKind(_ hand: [Card]) -> Bool {
    let rankCounts = Dictionary(grouping: hand, by: { $0.rank }).mapValues { $0.count }
    return rankCounts.values.contains(4)
}

func isStraightFlush(_ hand: [Card]) -> Bool {
    let sortedHand = hand.sorted { $0.rank.rawValue < $1.rank.rawValue }
    let isConsecutive = sortedHand.enumerated().allSatisfy { index, card in
        index == 0 || card.rank.rawValue == sortedHand[index - 1].rank.rawValue + 1
    }
    return isConsecutive && hand.allSatisfy { $0.suit == hand[0].suit }
}

var hand: [Card] = []
for _ in 1...5 {
    hand.append(randomCard())
}

if isStraightFlush(hand) {
    print("У вас стрит-флеш \(hand[0].suit.rawValue)")
} else if hand.allSatisfy({ $0.suit == hand[0].suit }) {
    print("У вас флеш \(hand[0].suit.rawValue)")
} else if isStraight(hand) {
    print("У вас стрит")
} else if isFourOfAKind(hand) {
    print("У вас каре")
} else {
    print("У вас обычная комбинация")
}

// Вывод получившейся комбинации карт
print("Получившаяся комбинация карт:")
for card in hand {
    print("\(card.rank) \(card.suit.rawValue)")
}
