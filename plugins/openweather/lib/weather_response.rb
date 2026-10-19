module AresMUSH
   module Openweather
     # Wrapper class to hold the json response from api endpoint
     #  includes methods that interact on the response
     class WeatherResponse
       attr_accessor :weather

       def initialize(weather)
         @weather = JSON.parse(weather, symbolize_names: true)
       end

       def coords
         {
           latitude: weather[:lat],
           longitude: weather[:lon]
         }
       end

       def temperature
         weather[:data][0][:temp][:day]
       end

       def pressure
         weather[:data][0][:pressure]
       end

       def humidity
         weather[:data][0][:humidity]
       end

       def temperature_range
         [weather[:data][0][:temp][:min], weather[:main][:temp][:max]]
       end

       # ???
       def wind
         weather[:data][0][:wind]
       end

       def cloudy?
         !weather[:data][0][:clouds].nil? && weather[:data][0][:clouds] > 0
       end

       def clouds
         return 0 if weather[:data][0][:clouds].nil?
         weather[:data][0][:clouds]
       end

       def rainy?
         !weather[:data][0][:rain].nil? && weather[:data][0][:rain] > 0
       end

       def rain
         return 0 unless rainy?
         weather[:data][0][:rain]
       end

       def snowy?
         !weather[:data][0][:snow].nil? && weather[:data][0][:snow] > 0
       end

       def snow
         return 0 unless snowy?
         weather[:data][0][:snow]
       end

       def sunrise
         weather[:data][0][:sunrise]
       end

       def sunset
         weather[:data][0][:sunset]
       end
     end
   end
end
