from flask import Flask, jsonify, request

app = Flask(__name__)

books = [
    {
        'id': 1,
        'título': 'A Segunda Era das Máquinas',
        'autor': 'Erik Brynjolfsson'
    },
    {
        'id': 2,
        'título': 'Um Bate-papo sobre T.I.',
        'autor': 'Ernesto Mario Haberkorn'
    },
    {
        'id': 3,
        'título': 'O Poder dos Quietos',
        'autor': 'Susan Cain'
    },
    {
        'id': 4,
        'título': 'Manual de DevOps',
        'autor': 'Gene Kim'
    },
    {
        'id': 5,
        'título': 'Use a cabeça! Programação',
        'autor': 'Paul Barry e David Griffiths'
    }
]

# Get all Books
@app.route('/books',methods=['GET'])
def obterBooks():
    return jsonify(books)

# Check ID
@app.route('/books/<int:id>', methods=['GET'])
def checkId(id):
    for book in books:
        if book.get('id') == id:
            return jsonify(book)

# Edit Books
@app.route('/books/<int:id>',methods=['PUT'])
def alterBook(id):
    book_change = request.get_json()
    for index,book in enumerate(books):
        if book.get('id') == id:
            books[index].update(book_change)
            return jsonify(books[index])

# Crete Book
@app.route('/books',methods=['POST'])
def createBook():
    new_book = request.get_json()
    books.append(new_book)

    return jsonify(books)

@app.route('/books/<int:id>', methods=['DELETE'])
def deleteBook(id):
    for index,book in enumerate(books):
        if book.get('id') == id:
            del books[index]

    return jsonify(books)

app.run(port=5000,host='localhost',debug=True)

