import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import './regularScreen.dart';
import './utils/utils.dart';
import './themes/color.dart';

class calendarScreen extends StatefulWidget {
  calendarScreen({Key key}) : super(key: key);

  @override
  _calendarScreenState createState() => _calendarScreenState();
}

class _calendarScreenState extends State<calendarScreen> {
  ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now(); //el focus esta sobre la fecha actual
  DateTime _selectedDay;
  DateTime _rangeStart;
  DateTime _rangeEnd;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime start, DateTime end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  //Calendario
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: Column(
        children: [
          Card(
            elevation: 10.0,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: TableCalendar<Event>(
                locale: 'en_US',
                firstDay: kFirstDay,
                lastDay: kLastDay,
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                rangeStartDay: _rangeStart,
                rangeEndDay: _rangeEnd,
                calendarFormat: _calendarFormat,
                rangeSelectionMode: _rangeSelectionMode,
                eventLoader: _getEventsForDay,
                startingDayOfWeek: StartingDayOfWeek.monday,
                calendarStyle: CalendarStyle(
                  // Use `CalendarStyle` to customize the UI
                    canMarkersOverflow: false,
                    outsideDaysVisible: false,
                    todayDecoration: BoxDecoration(
                      color: secondary,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: secondaryDark,
                    )
                ),
                onDaySelected: _onDaySelected,
                onRangeSelected: _onRangeSelected,
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>
                                  regularScreen()),); //Eventos dentro de los dias
                        },
                        title: Text('${value[index]}'),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: FloatingActionButton(
                backgroundColor: secondaryDark,
                //boton añadir
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddDate(p: "dasd")),
                  );
                },
                child: Icon(Icons.add),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AddDate extends StatefulWidget {
  final String p;
  AddDate({Key key, this.p}) : super(key: key);

  @override
  _AddDateState createState() => _AddDateState();
}

//Pantalla agregar cita
class _AddDateState extends State<AddDate> {
  DateTime selectedDate = DateTime.now();
  TextEditingController controlador =
  TextEditingController(); //Para el campo fecha
  String nombre;
  String tipo;
  String fecha;
  //Implementacion de selector de fecha
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        controlador.text = ("${selectedDate.toLocal()}"
            .split(' ')[0]); //Guarda la fecha seleccionada
        fecha = controlador.text;
      });
  }

  String cad;
  @override
  void initState() {
    cad = this.widget.p;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child:ListView(
          children: [
            Container(
              height: 70.0,
            ),
            Card(
              color: Colors.white,
              elevation: 10.0,
              child: SizedBox(
                width: 400.0,
                height: 450.0,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 50.0,),
                    Column(
                      children: <Widget>[
                        Text(
                          'Agregar cita',
                          style: TextStyle(
                            fontSize: 30.0,
                          ),
                        )
                      ]
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 50.0, top: 0.0, right: 50.0, bottom: 0.0),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 50.0, top: 0.0, right: 50.0, bottom: 0.0),
                      child: TextField(
                        onChanged: (cnombre) {
                          nombre = cnombre;
                        },
                        enableSuggestions: true,
                        cursorColor: secondaryDark,
                        decoration: const InputDecoration(
                          hintText: "Nombre",
                          labelStyle: TextStyle(),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: secondaryDark,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 50.0, top: 0.0, right: 50.0, bottom: 0.0),
                      child: TextField(
                        onChanged: (ctipo) {
                          tipo = ctipo;
                        },
                        enableSuggestions: true,
                        cursorColor: secondaryDark,
                        decoration: const InputDecoration(
                          hintText: "Tipo",
                          labelStyle: TextStyle(),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: secondaryDark,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 50.0, top: 0.0, right: 50.0, bottom: 0.0),
                      child: TextField(
                        controller: controlador,
                        enableSuggestions: true,
                        cursorColor: secondaryDark,
                        onTap: () => _selectDate(context),
                        decoration: const InputDecoration(
                          suffixIcon: Icon(
                            Icons.date_range,
                            color: Colors.grey,
                          ),
                          hintText: "Fecha",
                          labelStyle: TextStyle(),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: secondaryDark,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    SizedBox(
                      width: 300.0,
                      height: 50.0,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: secondaryDark,
                        ),
                        onPressed: () {
                          var user = FirebaseAuth.instance.currentUser;

                          FirebaseFirestore.instance.collection('users').doc(user.uid).collection('consultas').add({
                            "nombre" : nombre,
                            "tipo" : tipo,
                            "fecha" : controlador.text,
                          }).then((_) {
                            print("Success!");
                          });
                          Navigator.pop(context);
                        },
                        child: Text('Añadir'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
