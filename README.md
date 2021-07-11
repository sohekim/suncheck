
<p align="center"><b>Your Personal Sun Tracker</b><p>
  
<p align="center">Cross-Platofrm App Built With Flutter<p>

## About Suncheck
당신은 하루에 해를 얼마나 보나요?

> 코시국에 더욱 우울하거나 무기력한 건 햇살을 충분히 받지 못해서 일 수도 있어요.
> 매일 단 15분의 햇살만으로 우리 뇌에서는 우울증을 예방할 수 있을 만큼의 세로토닌이 분비됩니다.
> 만약 하루 동안 내가 얼마나 해살을 쬐는지 알 수 있다면 우리 기분을 더욱 주도적으로 관리해 나갈 수 있지 않을까요?
> Suncheck과 함께, 나만의 햇빛 일지를 작성하고 더 상쾌하고 기분 좋은 일상을 만들어나가세요 :)


## Main Functions
  <b>1. 햇살 기록하기</b>

홈 화면에 있는 동그라미 버튼으로 자신이 햇살을 받는 시간을 기록할 수 있습니다.
15분이 경과할 때마다 버튼의 색상이 더 진하게 변경됩니다.
  
> 걷는 움직임이 감지 되거나 앱을 키고 15 분 후 리마인더 notification 이 나갑니다. 
  
  <b>2. 기록 확인하기</b>
  
달력 화면을 통해 나의 월별 햇살 일지를 보고 각 동그라미를 눌렀을 때 그날 받은 햇살, 위치, 비타민 D 와 전기량을 볼 수 있습니다.

  <b>3. 내 위치의 날씨</b>

나의 현재 위치에 따른 실시간 날씨를 볼 수 있습니다. 
 
## Implementation

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
  

