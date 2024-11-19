import 'package:flutter/material.dart';
import 'StationListPage.dart';
import 'SeatPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> stations = [
    "수서", "동탄", "평택지제", "천안아산", "오송", "대전", "김천구미", "동대구", "경주", "울산", "부산"
  ];

  String? departureStation; // 출발역
  String? arrivalStation;   // 도착역

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('기차 예매'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 출발역 및 도착역 선택 박스
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20), // 모서리 둥글기
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // 출발역 선택
                  _buildStationSelector(
                    label: '출발역',
                    value: departureStation ?? '선택',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StationListPage(
                            title: "출발역", // 추가된 title 매개변수
                            stations: stations,
                            selectedStation: arrivalStation, // 도착역 제외
                            onStationSelected: (station) {
                              setState(() {
                                departureStation = station; // 출발역 설정
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  // 세로선
                  Container(
                    width: 2, // 선 너비
                    height: 40, // 선 높이 (고정)
                    color: Colors.grey[400],
                  ),
                  // 도착역 선택
                  _buildStationSelector(
                    label: '도착역',
                    value: arrivalStation ?? '선택',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StationListPage(
                            title: "도착역", // 추가된 title 매개변수
                            stations: stations,
                            selectedStation: departureStation, // 출발역 제외
                            onStationSelected: (station) {
                              setState(() {
                                arrivalStation = station; // 도착역 설정
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // 좌석 선택 버튼
            Container(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: (departureStation != null && arrivalStation != null)
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SeatPage(
                              departureStation: departureStation!,
                              arrivalStation: arrivalStation!,
                            ),
                          ),
                        );
                      }
                    : null,
                child: Text(
                  '좌석 선택',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[200], // 배경 색상
    );
  }

  // 출발역 및 도착역 선택 UI 생성 함수
  Widget _buildStationSelector({
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16, // 레이블 글자 크기
              color: Colors.grey, // 레이블 색상
              fontWeight: FontWeight.bold, // 레이블 두께
            ),
          ),
          SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
              fontSize: 40, // 선택 텍스트 크기
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
