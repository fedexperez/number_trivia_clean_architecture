import 'dart:io';

String fixture(String name) => File('test/fixtures/$name').readAsStringSync();
File getFixtureFile(String name) => File('test/fixtures/$name');
