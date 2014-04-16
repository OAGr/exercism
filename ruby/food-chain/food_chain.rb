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
    fly =  Animal.new("fly")
    spider = Animal.new("spider", "It wriggled and jiggled and tickled inside her.", append: " that wriggled and jiggled and tickled inside her", catches: fly)
    bird = Animal.new("bird", "How absurd to swallow a bird!", catches: spider)
    cat = Animal.new("cat", "Imagine that, to swallow a cat!", catches: bird)
    dog = Animal.new("dog", "What a hog, to swallow a dog!", catches: cat)
    goat = Animal.new("goat", "Just opened her throat and swallowed a goat!", catches: dog)
    cow = Animal.new("cow", "I don't know how she swallowed a cow!", catches: goat)
    horse = Animal.new("horse", "She's dead, of course!", catches: cow, died: true)
    [fly, spider, bird, cat, dog, goat, cow, horse]
  end

end

class Animal
  attr_reader :name, :phrase, :died, :append, :catches

  def initialize(name, phrase = nil, options = {})
    @name = name
    @phrase = phrase
    @died = options[:died] || nil
    @append = options[:append] || ""
    @catches = options[:catches] || nil
  end

  def catch_line
    "She swallowed the #{self} to catch the #{catches}#{catches.append}."
  end

  def to_s
    @name
  end
end
