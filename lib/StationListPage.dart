import 'package:flutter/material.dart';
import 'main.dart';


List<Station> stations = [
  for (String name in [
    '수서',
    '동탄',
    '평택지제',
    '천안아산',
    '오송',
    '대전',
    '김천구미',
    '동대구',
    '경주',
    '울산',
    '부산',
  ]) Station(name),
];

class StationListPage extends StatelessWidget {
  final List<Station> stations = [
    // 위에서 정의한 stations 리스트
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('출발역'),
      ),
      body: ListView.builder(
        itemCount: stations.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(stations[index].name),
          );
        },
      ),
    );
  }
}