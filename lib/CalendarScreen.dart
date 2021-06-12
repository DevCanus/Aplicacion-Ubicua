import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyecto/RegularScreen.dart';
import './services/userService.dart';
import 'package:table_calendar/table_calendar.dart';
import './utils/utils.dart';
import './themes/color.dart';
import 'LoginAccount.dart';

class calendarScreen extends StatefulWidget {
  calendarScreen({Key key}) : super(key: key);

  @override
  _calendarScreenState createState() => _calendarScreenState();
}

class _calendarScreenState extends State<calendarScreen> {
  ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now(); //el focus esta sobre la fecha actual
  DateTime _selectedDay;
  DateTime _rangeStart;
  DateTime _rangeEnd;

  UserService userService;
  User usuario;

  @override
  void initState() {
    super.initState();
    userService = new UserService();
    userService.getDataUsuario().then((value) => {
      usuario = value,
    });
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }

  GlobalKey<FormState> _keyForm = new GlobalKey();

  DateTime selectedDate = DateTime.now();
  TextEditingController controlador = TextEditingController(); //Para el campo fecha
  String nombre;
  String tipo;
  String fecha;
  //Implementacion de selector de fecha
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked =
    await showDatePicker(context: context, initialDate: selectedDate, firstDate: DateTime(2015, 8), lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        controlador.text = ("${selectedDate.toLocal()}".split(' ')[0]); //Guarda la fecha seleccionada
        fecha = controlador.text;
      });
  }

  citaBottomSheet(context) {
    return showDialog(
      context: context,
      //isScrollControlled: true,
      builder: (context) => Dialog(
        child: Form(
          key: _keyForm,
          child: Container(
            height: 350,
            width: 350,
            padding: EdgeInsets.only(left: 40.0, top: 20.0, right: 40.0, bottom: 20.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                Column(children: <Widget>[
                  Text(
                    'Agregar cita',
                    style: TextStyle(
                      fontSize: 30.0,
                    ),
                  )
                ]),
                SizedBox(
                  height: 10.0,
                ),
                TextField(
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
                SizedBox(
                  height: 10.0,
                ),
               TextField(
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
                SizedBox(
                  height: 10.0,
                ),
                TextField(
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
                SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  width: 300.0,
                  height: 50.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: secondaryDark,
                    ),
                    onPressed: () async {
                      UserService userService = new UserService();
                      User usuario;
                      usuario = await userService.getDataUsuario();
                      await userService.agregarCita(nombre, fecha, tipo, usuario).then((value) => {
                        if (value)
                          {
                            Navigator.of(context).pop(),
                          }
                        else
                          {
                            print('Error al insertar paciente'),
                          }
                      });
                    },
                    child: Text('Añadir Cita'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  editarCitaBottomSheet(context, String nom, String tip, String date, String idCita) {
    TextEditingController nombreCtrl = new TextEditingController();
    TextEditingController tipoCtrl = new TextEditingController();

    nombreCtrl.text = nom;
    tipoCtrl.text = tip;

    return showDialog(
      context: context,
      //isScrollControlled: true,
      builder: (context) => Dialog(
        child: Form(
          key: _keyForm,
          child: Container(
            height: 350,
            width: 350,
            padding: EdgeInsets.only(left: 40.0, top: 20.0, right: 40.0, bottom: 20.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                Column(children: <Widget>[
                  Text(
                    'Editar cita',
                    style: TextStyle(
                      fontSize: 30.0,
                    ),
                  )
                ]),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  controller: nombreCtrl,
                  /* onChanged: (cnombre) {
                    nom = cnombre;
                  }, */
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

                SizedBox(
                  height: 10.0,
                ),

                TextFormField(
                  controller: tipoCtrl,
                  onChanged: (ctipo) {
                    tip = ctipo;
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

                SizedBox(
                  height: 20.0,
                ),

                TextField(
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

                SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  width: 300.0,
                  height: 50.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: secondaryDark,
                    ),
                    onPressed: () async {
                      UserService userService = new UserService();
                      User usuario;
                      usuario = await userService.getDataUsuario();
                      await userService.editarCita(nombreCtrl.text, fecha, tipoCtrl.text, usuario, idCita).then((value) async {
                        if (value) {
                          Navigator.of(context).pop();
                        } else {
                          print('Error al editar paciente');
                        }
                      });
                    },
                    child: Text('Editar Cita'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  String fechaCompleta = '';
  bool cargaDatos = false;

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      cargaDatos = false;
    });
    print('SelectedDay $selectedDay');
    var dia = (selectedDay.day < 9) ? '0' + selectedDay.day.toString() : selectedDay.day;
    var mes = (selectedDay.month < 9) ? '0' + selectedDay.month.toString() : selectedDay.month;
    var anio = selectedDay.year;
    setState(() {
      fechaCompleta = '${anio.toString()}-${mes.toString()}-${dia.toString()}';
      print('FechaCompleta: $fechaCompleta');
      cargaDatos = true;
    });
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

  void borrarCita(BuildContext context, String idCita) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Borrar Cita'),
            content: Text('¿Estas seguro de borrar la cita?'),
            actions: <Widget>[
              // ignore: deprecated_member_use
              FlatButton(
                child: Text(
                  'Aceptar',
                  style: TextStyle(color: secondaryDark),
                ),
                onPressed: () async {
                  UserService userService = new UserService();
                  await userService.eliminarCita(idCita).then((value) async {
                    if (value) {
                      Navigator.of(context).pop();
                    }
                  });
                },
              ),
              FlatButton(
                child: Text(
                  'Cancelar',
                  style: TextStyle(color: secondaryDark),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        });
  }

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        content: new Text('¿Seguro que desea salir de la aplicación?'),
        actions: <Widget>[
          new GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: Text("CANCELAR", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 16),
          new GestureDetector(
            onTap: () => SystemChannels.platform.invokeMethod('SystemNavigator.pop'), //exit(0),
            child: Text("SALIR", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    ) ??
        false;
  }

  //Calendario
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () async {
              await userService.logOut().then((value) async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              });
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.red,
            ),
          ),
          title: Text('Menu'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            citaBottomSheet(context);
          },
          child: Icon(Icons.add),
          backgroundColor: secondaryDark,
        ),
        body: Container(
          width: width,
          height: height,
          child: Column(
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
                    //eventLoader: _getEventsForDay,
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
                        )),
                    onDaySelected: _onDaySelected,
                    onRangeSelected: _onRangeSelected,
                    onFormatChanged: (format) {
                      if (_calendarFormat != format) {
                        setState(() {
                          print('Calendar Format: $_calendarFormat');
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
              SizedBox(height: 8.0),
              if (cargaDatos)
                Expanded(
                  child: StreamBuilder(
                    stream: userService.obtenerCitasUsuario(fechaCompleta, usuario),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return CircularProgressIndicator();
                      }
                      if (snapshot.data.docs.length == 0) {
                        return Text('Sin datos para mostrar');
                      }
                      return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, indice) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            child: Card(
                              color: Colors.white,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text('${snapshot.data.docs[indice]['paciente']}'),
                                      Text('${snapshot.data.docs[indice]['fecha']}'),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          editarCitaBottomSheet(
                                              context,
                                              snapshot.data.docs[indice]['paciente'],
                                              snapshot.data.docs[indice]['tipo'],
                                              snapshot.data.docs[indice]['fecha'],
                                              snapshot.data.docs[indice].id);
                                        },
                                        child: Icon(Icons.edit),
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          borrarCita(context, snapshot.data.docs[indice].id);
                                        },
                                        child: Icon(Icons.delete),
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => regularScreen()),);
                                        },
                                        child: Icon(Icons.play_arrow),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
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
  TextEditingController controlador = TextEditingController(); //Para el campo fecha
  String nombre;
  String tipo;
  String fecha;
  //Implementacion de selector de fecha
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked =
    await showDatePicker(context: context, initialDate: selectedDate, firstDate: DateTime(2015, 8), lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        controlador.text = ("${selectedDate.toLocal()}".split(' ')[0]); //Guarda la fecha seleccionada
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
        child: ListView(
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
                    SizedBox(
                      height: 50.0,
                    ),
                    Column(children: <Widget>[
                      Text(
                        'Agregar cita',
                        style: TextStyle(
                          fontSize: 30.0,
                        ),
                      )
                    ]),
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0, top: 0.0, right: 50.0, bottom: 0.0),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0, top: 0.0, right: 50.0, bottom: 0.0),
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
                      padding: const EdgeInsets.only(left: 50.0, top: 0.0, right: 50.0, bottom: 0.0),
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
                      padding: const EdgeInsets.only(left: 50.0, top: 0.0, right: 50.0, bottom: 0.0),
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
                        onPressed: () async {
                          var documento = FirebaseFirestore.instance.collection('users').doc();
                          FirebaseFirestore.instance.collection('users').doc(documento.id).set({
                            'paciente': nombre,
                            'fecha': fecha,
                          }).then((value) => {
                            print('Agregado'),
                          });
                          /* print(nombre);
                          print(tipo);
                          print(fecha); */
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
