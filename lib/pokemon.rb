class Pokemon
  attr_accessor :name, :type, :db
    attr_reader :id
    def initialize(id: nil, name:, type:, db:)
        @id = id
        @name = name 
        @type = type
        @db = db
    end

    def self.save(name, type, db)
        sql = <<-SQL
            INSERT INTO pokemon (name, type)
            VALUES (?, ?)
        SQL

        db.execute(sql, name, type)
    end

    def self.find(id, db)
        sql = <<-SQL
            SELECT * 
            FROM pokemon
            WHERE id = ?
        SQL

        db.execute(sql, id).map do |poke|
            pokemon = Pokemon.new(id: poke[0], name: poke[1], type: poke[2], db: nil)
        end.first
    end
end
