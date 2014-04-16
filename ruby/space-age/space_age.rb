class SpaceAge
  SECONDS_PER_EARTH_YEAR = 31557600
  EARTH_YEAR_RATIOS = {:earth => 1,
     :mercury => 0.2408467,
     :venus => 0.61519726,
     :mars => 1.8808158,
     :jupiter => 11.862615,
     :saturn => 29.447498,
     :uranus => 84.016846,
     :neptune => 164.79132,
    } 
  PLANETS = EARTH_YEAR_RATIOS.keys

  attr_reader :seconds

  def initialize(seconds)
    @seconds = seconds
  end


  PLANETS.each do |planet|
    define_method("on_#{planet}".to_sym) do
      on(planet)
    end
  end

  def on(planet)
    seconds = @seconds.to_f / SECONDS_PER_EARTH_YEAR / EARTH_YEAR_RATIOS[planet.to_sym]
    seconds.round(2)
  end
end
