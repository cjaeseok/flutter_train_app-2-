import 'package:flutter/material.dart';
import 'StationListPage.dart';

class Station {
  final String name;

  Station(this.name);
}

class HomePage extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home : HomePage(),
    );
  }
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  
  String? selectedDeparture;
  String? selectedDestination;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('기차 예매'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedDeparture,
                    items: stations.map((Station station) {
                      return DropdownMenuItem<String>(
                        value: station.name,
                        child: Text(station.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedDeparture = value;
                      });
                    },
                    decoration: InputDecoration(labelText: '출발역'),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedDestination,
                    items: stations.map((Station station) {
                      return DropdownMenuItem<String>(
                        value: station.name,
                        child: Text(station.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedDestination = value;
                      });
                    },
                    decoration: InputDecoration(labelText: '도착역'),
                    
                    // ... 도착역 선택 부분도 동일하게 구현
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 좌석 선택 로직 구현 (예: 다른 화면으로 이동)
                print('좌석 선택 버튼 클릭: $selectedDeparture -> $selectedDestination');
                // Navigator.push(context, MaterialPageRoute(builder: (context) => SeatSelectionScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text('좌석 선택'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}
