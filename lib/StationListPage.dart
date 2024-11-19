import 'package:flutter/material.dart';

class StationListPage extends StatelessWidget {
  final String title; // 앱바에 표시할 타이틀 (출발역/도착역)
  final List<String> stations; // 역 목록
  final String? selectedStation; // 제외할 역
  final Function(String) onStationSelected; // 선택된 역 콜백

  StationListPage({
    required this.title,
    required this.stations,
    this.selectedStation,
    required this.onStationSelected,
  });

  @override
  Widget build(BuildContext context) {
    // 제외할 역 필터링
    final filteredStations = stations.where((station) => station != selectedStation).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(title), // 앱바 타이틀 (출발역 또는 도착역)
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white, // 전체 배경색 하얗게 설정
        child: ListView.builder(
          itemCount: filteredStations.length,
          itemBuilder: (context, index) {
            final station = filteredStations[index];
            return Container(
              height: 50, // 각 역 항목의 높이
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey[300]!, // 아래 테두리 색상
                    width: 1,
                  ),
                ),
              ),
              child: ListTile(
                title: Text(
                  station,
                  style: TextStyle(
                    fontSize: 18, // 글자 크기
                    fontWeight: FontWeight.bold, // 글자 두께
                  ),
                ),
                onTap: () {
                  onStationSelected(station); // 선택된 역 반환
                  Navigator.pop(context); // 페이지 닫기
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
