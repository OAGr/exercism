class FoodChainSong
  LAST_LINE = "I don't know why she swallowed the fly. Perhaps she'll die."
  def initialize
    @animals = build_animals
  end

  def verses(start, stop)
    (start..stop).to_a.map{|i| verse(i)}.join("\n") << "\n"
  end

  def sing
    verses(1,8)
  end
  def verse(i)
    verse = []
    animal = @animals[i-1]
    verse << "I know an old lady who swallowed a #{animal}."
    verse << animal.phrase if animal.phrase
    if !animal.died
      verse += @animals[1...i].reverse.map{|a| a.catch_line}
      verse << LAST_LINE
    end
    verse.join("\n") << "\n"
  end

  def build_animals
    animals =  [["fly"],
                ["spider", "It wriggled and jiggled and tickled inside her.",  " that wriggled and jiggled and tickled inside her"],
                ["bird", "How absurd to swallow a bird!"],
                ["cat", "Imagine that, to swallow a cat!"],
                ["dog", "What a hog, to swallow a dog!"],
                ["goat", "Just opened her throat and swallowed a goat!"],
                ["cow", "I don't know how she swallowed a cow!"],
                ["horse",  "She's dead, of course!", nil, true]]
    animals.map!{|a| Animal.new(*a)}
    (1...animals.length).each { |i| animals[i].catches = animals[i - 1] }
    animals
  end

end

class Animal
  attr_reader :name, :phrase, :died, :append, :catches
  attr_writer :catches

  def initialize(name, phrase = nil, append = nil, died = false)
    @name = name
    @phrase = phrase
    @append = append
    @died = died
    @catches = nil
  end

  def catch_line
    "She swallowed the #{self} to catch the #{catches}#{catches.append}."
  end

  def to_s
    @name
  end
end
