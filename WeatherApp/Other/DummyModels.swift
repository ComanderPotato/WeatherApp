//
//  DummyModels.swift
//  WeatherApp
//
//  Created by Tom Golding on 11/5/2024.
//

import Foundation


func createDummyAstro() -> Astro {
    return Astro(sunrise: "6:00 AM",
                 sunset: "6:00 PM",
                 moonrise: "8:00 PM",
                 moonset: "8:00 AM",
                 moonPhase: "New Moon",
                 moonIllumination: 0.5,
                 isMoonUp: 1,
                 isSunUp: 1)
}

func createDummyAstronomy() -> Astronomy {
    let dummyAstro = createDummyAstro()
    return Astronomy(astro: dummyAstro)
}

func createDummyAstronomyData() -> AstronomyData {
    let dummyLocation = createDummyLocation()
    let dummyAstronomy = createDummyAstronomy()
    return AstronomyData(location: dummyLocation, astronomy: dummyAstronomy)
}

func createDummyCondition() -> Condition {
    return Condition(text: "Clear sky",
                     icon: "https://example.com/clear_sky.png",
                     code: 800)
}

func createDummyCurrent() -> Current {
    let dummyCondition = createDummyCondition()
    return Current(lastUpdatedEpoch: 1621062600,
                   lastUpdated: "2021-05-15 12:30",
                   tempC: 25.0,
                   tempF: 77.0,
                   isDay: 1,
                   condition: dummyCondition,
                   windMph: 10.0,
                   windKph: 16.0,
                   windDegree: 180,
                   windDir: "S",
                   pressureMB: 1013.25,
                   pressureIn: 29.92,
                   precipMm: 0.0,
                   precipIn: 0.0,
                   humidity: 50,
                   cloud: 10,
                   feelslikeC: 27.0,
                   feelslikeF: 80.6,
                   visKM: 10.0,
                   visMiles: 6.2,
                   uv: 6.0,
                   gustMph: 15.0,
                   gustKph: 24.0)
}

func createDummyDay() -> Day {
    let dummyCondition = createDummyCondition()
    return Day(maxtempC: 30.0,
               maxtempF: 86.0,
               mintempC: 20.0,
               mintempF: 68.0,
               avgtempC: 25.0,
               avgtempF: 77.0,
               maxwindMph: 15.0,
               maxwindKph: 24.0,
               totalprecipMm: 5.0,
               totalprecipIn: 0.2,
               totalsnowCM: 0.0,
               avgvisKM: 10.0,
               avgvisMiles: 6.2,
               avghumidity: 60,
               condition: dummyCondition,
               uv: 7.0,
               dailyWillItRain: 0,
               dailyChanceOfRain: 0,
               dailyWillItSnow: 0,
               dailyChanceOfSnow: 0)
}

func createDummyForecast() -> Forecast {
    let dummyForecastDay = [createDummyForecastday()]
    return Forecast(forecastday: dummyForecastDay)
}

func createDummyForecastData() -> ForecastData {
    let dummyLocation = createDummyLocation()
    let dummyCurrent = createDummyCurrent()
    let dummyForecast = createDummyForecast()
    return ForecastData(location: dummyLocation, current: dummyCurrent, forecast: dummyForecast)
}

func createDummyForecastday() -> Forecastday {
    let dummyDay = createDummyDay()
    let dummyAstro = createDummyAstro()
    let dummyHour = [createDummyHour()]
    return Forecastday(date: "2024-05-15",
                       dateEpoch: 1800000000,
                       day: dummyDay,
                       astro: dummyAstro,
                       hour: dummyHour)
}

func createDummyHour() -> Hour {
    let dummyCondition = createDummyCondition()
    return Hour(timeEpoch: 1621062600,
                time: "12:30 PM",
                tempC: 25.0,
                tempF: 77.0,
                condition: dummyCondition,
                windMph: 10.0,
                windKph: 16.0,
                windDegree: 180,
                windDir: "S",
                pressureMB: 1013.25,
                pressureIn: 29.92,
                precipMm: 0.0,
                precipIn: 0.0,
                snowCM: 0.0,
                humidity: 50,
                cloud: 10,
                feelslikeC: 27.0,
                feelslikeF: 80.6,
                windchillC: 25.0,
                windchillF: 77.0,
                heatindexC: 27.0,
                heatindexF: 80.6,
                dewpointC: 20.0,
                dewpointF: 68.0,
                willItRain: 0,
                willItSnow: 0,
                isDay: 1,
                visKM: 10.0,
                visMiles: 6.2,
                chanceOfRain: 0,
                chanceOfSnow: 0,
                gustMph: 15.0,
                gustKph: 24.0,
                uv: 6.0)
}

let location = Location(name: "London",
                        region: "England",
                        country: "United Kingdom",
                        lat: 51.5074,
                        lon: -0.1278,
                        tzID: "Europe/London",
                        localtimeEpoch: 1621062600,
                        localtime: "2021-05-15 12:30 PM")
func createWeatherData(location: Location, current: Current) -> WeatherData {
    return WeatherData(location: location, current: current)
}

func createDummyLocation() -> Location {
    return Location(name: "Dummy City",
                    region: "Dummy Region",
                    country: "Dummy Country",
                    lat: 0.0,
                    lon: 0.0,
                    tzID: "UTC",
                    localtimeEpoch: 0,
                    localtime: "1970-01-01 00:00 AM")
}
