import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:navigator/Views/booking.dart';
import 'package:navigator/services/remote_services.dart';

class slots extends StatefulWidget {
  const slots({super.key});

  @override
  State<slots> createState() => _slotsState();
}

class _slotsState extends State<slots> {
  DateTime startTime = DateTime(2023, 4, 2, 4, 10);
  DateTime endTime = DateTime(2023, 4, 2, 8, 0);
  List<String> bookedSlots = ['04:20 AM', '05:30 AM', '06:40 AM'];
  int selectedDayIndex = 0;
  bool selected = true;
  String? selecteddate;

  @override
  void initState() {
    super.initState();
    RemoteService().getslots();
  }

  @override
  Widget build(BuildContext context) {
    List<String> timeSlots = List.generate(
      (endTime.difference(startTime).inMinutes / 10).toInt() + 1,
      (index) {
        DateTime dateTime = startTime.add(Duration(minutes: index * 10));
        return DateFormat('jm').format(dateTime);
      },
    );
    final startDate = DateTime(2022, 7, 10);
    final numberOfDays = 5;

    // Create a list of dates
    final dates = List<DateTime>.generate(
      numberOfDays,
      (index) => startDate.add(Duration(days: index)),
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                width: double.maxFinite,
                color: Colors.white,
                child: Text(
                  'Drop-In Center',
                  style: TextStyle(
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Navigator Details',
                  style: TextStyle(
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(8),
                color: Colors.grey,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.deepOrange),
                    color: Colors.deepOrange.shade100,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    tileColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    leading: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 30,
                        child: Icon(
                          Icons.person,
                          color: Colors.black,
                          size: 40,
                        ),
                      ),
                    ),
                    title: Text(
                      'John Andersen',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '932 Tennessee Avenue Southfield AZ - ARIZONA 48075',
                      style: TextStyle(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  padding: EdgeInsets.all(8),
                  height: 90,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: dates.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final date = dates[index];
                      final dayName = DateFormat('EEEE').format(date);
                      final formattedDate = DateFormat('dd MMM').format(date);
                      final availableSlots =
                          4; // Replace with the actual number of available slots

                      return GestureDetector(
                        onTap: () {
                          if (selected == true && selectedDayIndex == index) {
                            setState(() {
                              selected = false;
                            });
                          } else {
                            setState(() {
                              selectedDayIndex = index;
                              selected = true;
                            });
                          }
                          selecteddate =
                              '${DateFormat('EEEE').format(dates[selectedDayIndex])}, ${DateFormat('dd MMM').format(dates[selectedDayIndex])}';
                        },
                        child: DaySlot(
                          dayName: dayName,
                          date: formattedDate,
                          availableSlots: availableSlots,
                          selectedindex: selectedDayIndex,
                          onSelected: (bool) {},
                          selected: selected,
                          index: index,
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(selecteddate ?? ''),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.sunny_snowing),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Morning'),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '41 slots',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: timeSlots.length,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1.5,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    bool isBooked = index == 0;
                    List<String> timeParts = timeSlots[index].split(' ');
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => book(),
                            ));
                      },
                      child: Card(
                        child: Stack(
                          children: [
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(timeParts[0]),
                                  SizedBox(height: 5),
                                  Text(timeParts[1]),
                                ],
                              ),
                            ),
                            if (isBooked)
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.4),
                                      blurRadius: 5,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    'Booked',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
    ;
  }
}

class DaySlot extends StatefulWidget {
  final String dayName;
  final String date;
  final int availableSlots;
  final bool selected;
  final Function(bool) onSelected;
  final int? selectedindex;
  final int index;

  const DaySlot({
    required this.dayName,
    required this.date,
    required this.availableSlots,
    required this.selected,
    required this.onSelected,
    required this.selectedindex,
    required this.index,
  });

  @override
  _DaySlotState createState() => _DaySlotState();
}

class _DaySlotState extends State<DaySlot> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: (widget.selectedindex == widget.index && widget.selected == true)
            ? Colors.deepOrange[100]
            : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
            color: (widget.selectedindex == widget.index &&
                    widget.selected == true)
                ? Colors.deepOrange
                : Colors.white),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${widget.dayName}, ${widget.date}',
            style: TextStyle(),
          ),
          SizedBox(height: 4),
          Text(
            '${widget.availableSlots} Slots Available',
            style: TextStyle(color: Colors.deepOrange),
          ),
        ],
      ),
    );
  }
}
