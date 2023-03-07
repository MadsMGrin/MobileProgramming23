class DailyForecast {
  final DateTime time;
  final WeatherCode weathercode;
  final double temperature_2m_max;
  final double temperature_2m_min;

  DailyForecast(
      {required this.time,
        required this.weathercode,
        required this.temperature_2m_max,
        required this.temperature_2m_min});

  String getWeekday() {
    switch (time.weekday) {
      case DateTime.monday:
        return 'Monday';
      case DateTime.tuesday:
        return 'Tuesday';
      case DateTime.wednesday:
        return 'Wednesday';
      case DateTime.thursday:
        return 'Thursday';
      case DateTime.friday:
        return 'Friday';
      case DateTime.saturday:
        return 'Saturday';
      case DateTime.sunday:
        return 'Sunday';
      default:
        return '';
    }
  }
  static List<DailyForecast> fromJson(Map<String, dynamic> daily){
    final times = daily['time'] as List<dynamic>;
    final weathercodes = daily['weathercode'] as List<dynamic>;
    final temperature_2m_max = daily['temperature_2m_max'] as List<dynamic>;
    final temperature_2m_min = daily['temperature_2m_min'] as List<dynamic>;
    return List.generate(times.length, (index) =>
        DailyForecast(time: DateTime.parse(times[index]),
            weathercode: WeatherCode.fromNumeric(weathercodes[index]),
            temperature_2m_max: temperature_2m_max[index],
            temperature_2m_min: temperature_2m_min[index]
        ));
  }
}

class HourlyForecast {
  final DateTime time;
  final double temperature_2m;
  final double apparent_temperature;
  final int precipitation_probability;
  final double precipitation;

  HourlyForecast(
      {required this.time,
        required this.temperature_2m,
        required this.apparent_temperature,
        required this.precipitation_probability,
        required this.precipitation
      });

  static List<HourlyForecast> fromJson(Map<String, dynamic> hourly){
    final times = hourly['time'] as List<dynamic>;
    final temperature_2m = hourly['temperature_2m'] as List<dynamic>;
    final apparent_temperature = hourly['apparent_temperature'] as List<dynamic>;
    final precipitation_probability = hourly['precipitation_probability'] as List<
        dynamic>;
    final precipitation = hourly['precipitation'] as List<dynamic>;
    return List.generate(times.length, (index) =>
        HourlyForecast(time: DateTime.parse(times[index]),
            temperature_2m: temperature_2m[index],
            apparent_temperature: apparent_temperature[index],
            precipitation_probability: precipitation_probability[index],
            precipitation: precipitation[index]
        ));
  }
}


// 0 	Clear sky
// 1, 2, 3 	Mainly clear, partly cloudy, and overcast
// 45, 48 	Fog and depositing rime fog
// 51, 53, 55 	Drizzle: Light, moderate, and dense intensity
// 56, 57 	Freezing Drizzle: Light and dense intensity
// 61, 63, 65 	Rain: Slight, moderate and heavy intensity
// 66, 67 	Freezing Rain: Light and heavy intensity
// 71, 73, 75 	Snow fall: Slight, moderate, and heavy intensity
// 77 	Snow grains
// 80, 81, 82 	Rain showers: Slight, moderate, and violent
// 85, 86 	Snow showers slight and heavy
// 95 * 	Thunderstorm: Slight or moderate
// 96, 99 * 	Thunderstorm with slight and heavy hail
enum WeatherCode {
  ClearSky(0, 'Clear sky', 'https://cdn.pixabay.com/photo/2018/08/06/22/55/sun-3588618__480.jpg'),

  MainlyClear(1, 'Mainly clear', 'https://images.all-free-download.com/images/graphiclarge/clouds_on_a_mostly_clear_sky_589580.jpg'),
  PartlyCloudy(2, 'Partly cloudy', 'https://www.wkbn.com/wp-content/uploads/sites/48/2021/03/clouds-cloudy-sky-spring-summer-fall-winter-weather-generic-8-1.jpg?w=1280'),
  Overcast(3, 'Overcast', 'https://images.unsplash.com/photo-1499956827185-0d63ee78a910?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8b3ZlcmNhc3QlMjBza3l8ZW58MHx8MHx8&w=1000&q=80'),

  Fog(45, 'Fog', 'https://www.treehugger.com/thmb/FpFgHsJA6jVMbK1kqCOzx2WE-bo=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/__opt__aboutcom__coeus__resources__content_migration__mnn__images__2016__02__fog-bitterroot-mountains-4807feab43334256aded341517fae38f.jpg'),
  DepositingRimeFog(48, 'Depositing rime fog', 'https://cloudfront-us-east-1.images.arcpublishing.com/gray/LW2N62X6Z5F7BM3EKFQXWAC46E.jpg'),

  DrizzleLight(51, 'Drizzle: Light intensity', 'https://thumbs.dreamstime.com/b/crocus-flowers-meadow-sunshine-rain-light-drizzle-summer-71284037.jpg'),
  DrizzleModerate(53, 'Drizzle: Moderate intensity', 'https://www.bssnews.net/assets/news_photos/2022/09/29/image-85223-1664434858.jpg'),
  DrizzleDense(55, 'Drizzle: Dense intensity', 'http://ichef.bbci.co.uk/news/640/cpsprodpb/C199/production/_101016594_9aff074f-3d3b-4652-952b-d0bea7b3949c.jpg'),

  FreezingDrizzleLight(56, 'Freezing Drizzle: Light intensity', 'https://skypix.photography/wp-content/uploads/2016/07/nwc4lyts.jpg'),
  FreezingDrizzleDense(57, 'Freezing Drizzle: dense intensity', 'https://i.cbc.ca/1.6339608.1643992828!/cumulusImage/httpImage/image.jpg_gen/derivatives/original_620/ice-storm-freezing-rain.jpg'),

  RainSlight(61, 'Rain: Slight intensity', 'https://thumbs.dreamstime.com/b/crocus-flowers-meadow-sunshine-rain-light-drizzle-summer-71284037.jpg'),
  RainModerate(63, 'Rain: Moderate intensity', 'https://www.bssnews.net/assets/news_photos/2022/09/29/image-85223-1664434858.jpg'),
  RainHeavy(65, 'Rain: Heavy intensity', 'http://ichef.bbci.co.uk/news/640/cpsprodpb/C199/production/_101016594_9aff074f-3d3b-4652-952b-d0bea7b3949c.jpg'),

  FreezingRainLight(66, 'Freezing Rain: Light intensity', 'https://skypix.photography/wp-content/uploads/2016/07/nwc4lyts.jpg'),
  FreezingRainHeavy(66, 'Freezing Rain: Heavy intensity', 'https://i.cbc.ca/1.6339608.1643992828!/cumulusImage/httpImage/image.jpg_gen/derivatives/original_620/ice-storm-freezing-rain.jpg'),

  SnowFallSlight(71, 'Snow fall: Slight intensity', 'https://www.thecommononline.org/wp-content/uploads/2015/03/Snow-Falling.jpg'),
  SnowFallModerate(73, 'Snow fall: Moderate intensity', 'https://thegnskashmir.com/wp-content/uploads/2022/02/images-2022-02-23T102150.179.jpeg'),
  SnowFallHeavy(75, 'Snow fall: Heavy intensity', 'https://newsonair.com/wp-content/uploads/2023/01/NPIC-202312383955-696x438.jpg'),

  SnowGrains(77, 'Snow grains', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTSq-R5ncIIf9qdvxI8fYGP2xXgGp1G5szZDQ&usqp=CAU'),

  RainShowersSlight(80, 'Rain showers: Slight', 'https://thumbs.dreamstime.com/b/crocus-flowers-meadow-sunshine-rain-light-drizzle-summer-71284037.jpg'),
  RainShowersModerate(81, 'Rain showers: Moderate', 'https://www.bssnews.net/assets/news_photos/2022/09/29/image-85223-1664434858.jpg'),
  RainShowersVoilent(82, 'Rain showers: Violent', 'http://ichef.bbci.co.uk/news/640/cpsprodpb/C199/production/_101016594_9aff074f-3d3b-4652-952b-d0bea7b3949c.jpg'),

  SnowShowersSlight(85, 'Snow showers: Slight', 'https://www.thecommononline.org/wp-content/uploads/2015/03/Snow-Falling.jpg'),
  SnowShowersHeavy(86, 'Snow showers: Heavy', 'https://newsonair.com/wp-content/uploads/2023/01/NPIC-202312383955-696x438.jpg'),

  Thunerstorm(95, 'Thunderstorm: Slight or moderate', 'https://images.newscientist.com/wp-content/uploads/2019/03/20115708/gettyimages-673747736.jpg'),
  ThunderstormSlightHail(96, 'Thunderstorm with slight hail', 'https://i2-prod.mylondon.news/incoming/article20626004.ece/ALTERNATES/s615/0_Screen-Shot-2021-05-18-at-164943.jpg'),
  ThunderstormHeavyHail(99, 'Thunderstorm with heavy hail', 'https://i2-prod.mylondon.news/incoming/article20626004.ece/ALTERNATES/s615/0_Screen-Shot-2021-05-18-at-164943.jpg'),
  ;

  final int numeric;
  final String description;
  final String imageurl;
  const WeatherCode(this.numeric, this.description, this.imageurl);

  static final _map =
  Map.fromEntries(WeatherCode.values.map((e) => MapEntry(e.numeric, e)));
  factory WeatherCode.fromNumeric(int numeric) {
    return WeatherCode._map[numeric]!;
  }
}
