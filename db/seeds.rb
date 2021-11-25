# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

author_adams = Author.create(name: 'Douglas Adams')
author_herbert = Author.create(name: 'Frank Herbert')
author_murakami = Author.create(name: 'Haruki Murakami')
author_orwell = Author.create(name: 'George Orwell')

book_hitchhikers = Book.create(title: 'The Hitchhiker\'s Guide to the Galaxy', author: author_adams, shelf: :read)
book_hitchhikers.cover.attach(io: File.open('db/seeds/cover_hitchhikers.jpg'), filename: 'cover_hitchhikers.jpg')

book_dune = Book.create(title: 'Dune', author: author_herbert, shelf: :currently_reading)
book_dune.cover.attach(io: File.open('db/seeds/cover_dune.jpg'), filename: 'cover_dune.jpg')

book_commendatore = Book.create(title: 'Killing Commendatore', author: author_murakami, shelf: :want_to_read)
book_commendatore.cover.attach(io: File.open('db/seeds/cover_commendatore.jpg'), filename: 'cover_commendatore.jpg')

book_1984 = Book.create(title: '1984', author: author_orwell, shelf: :read)
book_1984.cover.attach(io: File.open('db/seeds/cover_1984.jpg'), filename: 'cover_1984.jpg')
