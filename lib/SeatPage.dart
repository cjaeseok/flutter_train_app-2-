import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SeatPage extends StatefulWidget {
  final String departureStation; // 출발역
  final String arrivalStation;   // 도착역

  SeatPage({required this.departureStation, required this.arrivalStation});

  @override
  _SeatPageState createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  String? selectedSeat; // 선택된 좌석

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '좌석 선택', // 앱바 타이틀
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          // 출발역 → 도착역 표시
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.departureStation,
                  style: TextStyle(
                    fontSize: 30, // 글자 크기
                    fontWeight: FontWeight.bold, // 두껍게
                    color: Colors.purple,
                  ),
                ),
                SizedBox(width: 10),
                Icon(
                  Icons.arrow_circle_right_outlined, // 화살표 아이콘
                  size: 30,
                  color: Colors.grey,
                ),
                SizedBox(width: 10),
                Text(
                  widget.arrivalStation,
                  style: TextStyle(
                    fontSize: 30, // 글자 크기
                    fontWeight: FontWeight.bold, // 두껍게
                    color: Colors.purple,
                  ),
                ),
              ],
            ),
          ),
          // 좌석 상태 표시
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                SizedBox(width: 4),
                Text('선택됨'),
                SizedBox(width: 20),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                SizedBox(width: 4),
                Text('선택안됨'),
              ],
            ),
          ),
          // 좌석 리스트 영역
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              children: [
                // 좌석 헤더 (A, B, C, D)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildLabel('A'),
                    _buildLabel('B'),
                    SizedBox(width: 50), // 가운데 숫자 간격
                    _buildLabel('C'),
                    _buildLabel('D'),
                  ],
                ),
                SizedBox(height: 8),
                // 좌석 선택 그리드
                Column(
                  children: List.generate(
                    20, // 총 20행
                    (rowIndex) {
                      final row = rowIndex + 1; // 1부터 시작하는 행 번호
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // 왼쪽 A, B 열
                            _buildSeat(row, 'A'),
                            _buildSeat(row, 'B'),
                            // 가운데 행 번호
                            Container(
                              width: 50,
                              height: 50,
                              alignment: Alignment.center,
                              child: Text(
                                row.toString(),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                            // 오른쪽 C, D 열
                            _buildSeat(row, 'C'),
                            _buildSeat(row, 'D'),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // 예매하기 버튼
          Container(
            width: double.infinity,
            height: 60,
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 40),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: selectedSeat != null
                  ? () {
                      // iOS 스타일 예매 확인창 표시
                      _showCupertinoDialog();
                    }
                  : null,
              child: Text(
                '예매 하기',
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
    );
  }

  // 좌석 레이블 (ABCD)
  Widget _buildLabel(String label) {
    return Container(
      width: 50,
      height: 50,
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // 좌석 버튼 생성
  Widget _buildSeat(int row, String column) {
    final seat = '$row-$column'; // 좌석 번호 (예: 1-A, 2-B)
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSeat = seat; // 선택된 좌석 업데이트
        });
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: selectedSeat == seat ? Colors.purple : Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  // iOS 스타일 예매 확인창
  void _showCupertinoDialog() {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('예매 하시겠습니까?'),
          content: Text('좌석: $selectedSeat'),
          actions: [
            CupertinoDialogAction(
              child: Text('취소'),
              isDestructiveAction: true, // 빨간색 텍스트
              onPressed: () => Navigator.of(context).pop(), // 다이얼로그 닫기
            ),
            CupertinoDialogAction(
              child: Text('확인',style: TextStyle(color:Colors.blue),),
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('좌석 $selectedSeat 예매 완료!'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
