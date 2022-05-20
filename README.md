
# Suncheck
Suncheck allows you to record and archive your sunlight intake. Build healthy habits by learning how much solar energy you are getting.
* 500+ downloads on [Appstore](https://apps.apple.com/nz/app/suncheck/id1576824683)
* 200+ upvotes on [Product Hunt](https://www.producthunt.com/posts/suncheck?utm_campaign=producthunt-atom-posts-feed&utm_medium=rss-feed&utm_source=producthunt-atom-posts-feed)

## Table of Contents

- [Why Suncheck](#why-suncheck)
- [Main Features](#main-features)
- [Implementation](#implementation)

## Why Suncheck
Due to the elongated pandemic, the time we spend indoors has increased dramatically. With less time spent under natural sunlight the overall anxiety and depression levels have risen in individuals.

If we can keep track and visualize the time we spend in the sun, we could easily check and adjust our lifestyles to feel better.

## Main Features
  <b>1. Record Your Time In The Sun</b>
  
<img alt="suncheck" title="suncheck" src="https://github.com/sohekim/suncheck/blob/master/first.png" width="600">

Users can record the time they spend under the sun by simply tapping the center circle. 
Once it starts recording, the circle radiates like a sun.
  
  
> A notification is sent after 15 mins
  
  <b>2. Visualizing Data</b>
  
  <img alt="suncheck" title="suncheck" src="https://github.com/sohekim/suncheck/blob/master/second.png" width="430">
  
The main button changes color after every 15 minutes has passed, so that it gives users a good idea about how much sun they have received.


<b>3. Real Time Walking Sensor</b>

<img alt="suncheck" title="suncheck" src="https://live.staticflickr.com/65535/52084489147_e4970902c7_b.jpg" width= "750">

Once the user allows location access, Flutter's GeoLocation updates their current location. With this data, the app detects the user's movement and sends notifications accordingly.
 
## Implementation

<img src = "https://live.staticflickr.com/65535/52085767084_40a5d5a5dc_b.jpg">

  <b> Serverless Cross-Platform Mobile App </b>
  

| Framework            | Client       |  Database                |   External API              |   
| -------------------- |--------------|--------------------------| ---| 
| Flutter              | ios          |  SQLite                  | Open Weather API | 
|                      | android      |  SharedPreference        |  |    

  <b> Flutter / Dart Version </b>
  
```
  
  Flutter 2.0.5 • channel stable • https://github.com/flutter/flutter.git
  Framework • revision adc687823a (3 months ago) • 2021-04-16 09:40:20 -0700
  Engine • revision b09f014e96
  Tools • Dart 2.12.3
  
```
  
  <b> List of Flutter Dependency Used </b>
  
```
  
  provider: ^4.3.2+3
  weather: ^2.0.1
  geolocator: ^7.2.0+1
  sqflite: ^2.0.0+3
  path: ^1.8.0
  path_provider: ^2.0.2
  intl: ^0.17.0
  shared_preferences: ^2.0.6
  geocoder: ^0.2.1
  avatar_glow: ^2.0.1
  dotted_line: ^3.0.0
  jiffy: ^4.1.0
  flutter_local_notifications: ^5.0.0+1
  timezone: ^0.7.0
  
```
  
  ### Sunlight Record Model
  
  ```
  
  class Record {

  Record({int id, DateTime date, int energy, String location}) {
    this.id = id;
    this.date = DateTime.parse(DateFormat('yyyy-MM-dd 00:00:00.000').format(date));
    this.energy = energy;
    this.location = location;
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'date': date.toString(), 'energy': energy, 'location': location};
  }

```
  
  <img alt="suncheck" title="suncheck" src="https://github.com/sohekim/suncheck/blob/master/wire.png" width="1000">
  

