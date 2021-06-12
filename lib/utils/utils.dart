// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:table_calendar/table_calendar.dart';

String FocusedDay;

/// Example event class.
class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);
// el mapa es asi  {"2000,01,01": contenido, "2000,01,02": 4, "0000,00,03": 9}
final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),//lista generada con 50 elementos {0,1,2,...,49,50}, aqui poner el tamaño de la tabla de la bd
    key: (item) => DateTime.utc(2021, 06, item+1),//Es la fecha que va contener un evento, PK
    value: (item) => List.generate(10, (index) => Event("Evento")));//List.generate(item % 4 + 1, (index) => Event('Event $item | ${index + 1}')));
/*..addAll({
    DateTime.now(): [
      Event('Today\'s Event 1'),
      Event('Today\'s Event 2'),
    ],
  });*/

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
        (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kNow = DateTime.now();
final kFirstDay = DateTime(kNow.year, kNow.month - 3, kNow.day);
final kLastDay = DateTime(kNow.year, kNow.month + 3, kNow.day);