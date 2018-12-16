require 'pry'

class Pokemon
  attr_accessor :id, :name, :type, :hp, :db

  @@all = []

  def initialize(id:, name:, type:, hp:60, db:)
    @id = id
    @name = name
    @type = type
    @hp = hp
    @db = db
    @@all << self
  end

  def alter_hp(hp, db)
    qry = db.prepare('UPDATE pokemon SET hp = ?1 WHERE id = ?2')
    qry.bind_param 1, hp
    qry.bind_param 2, self.id
    qry.execute
  end

  def self.save(name, type, db)
    #binding.pry
    qry = db.prepare('INSERT INTO pokemon (name, type) VALUES(?, ?)')
    qry.execute([name, type])
  end

  def self.find(id, db)
    qry = db.prepare('SELECT * FROM pokemon WHERE id = ?')
    qry.bind_param 1, id
    res = qry.execute

    row = res.next
    #New Pokemon Objective
    Pokemon.new(id:row[0], name:row[1], type:row[2], hp:row[3], db:db)
  end

  def self.all
    @@all
  end

end
