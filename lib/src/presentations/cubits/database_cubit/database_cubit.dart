import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';
import 'package:thiqa_tutoring_app/src/domain/models/instructor_model.dart';
import 'package:thiqa_tutoring_app/src/domain/models/session_model.dart';
import 'package:thiqa_tutoring_app/src/domain/models/student_model.dart';
import 'package:thiqa_tutoring_app/src/domain/models/work_day_model.dart';

import '../../../utils/functions/functions.dart';

part 'database_states.dart';

class DatabaseCubit extends Cubit<DatabaseStates> {
  DatabaseCubit() : super(DatabaseInitialState());

  static DatabaseCubit get(context) => BlocProvider.of(context);

  late Database database;
  Student me = Student();

  void createDataBase() {
    openDatabase(
      'thiqa.db',
      version: 1,
      onCreate: (database, version) async {
        myPrint(text: 'Thiqa database Created Successfully ❤❤');

        await database.execute('''
      CREATE TABLE instructor (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT,
        phone TEXT
      )
    ''');

        // Create Student table
        await database.execute('''
      CREATE TABLE student (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT,
        password TEXT,
        phone TEXT
      )
    ''');

        // Create InstructorStudent junction table
        await database.execute('''
      CREATE TABLE instructor_student (
        instructor_id INTEGER,
        student_id INTEGER,
        start_from_time TEXT,
        day_name TEXT,
        PRIMARY KEY (instructor_id, student_id),
        FOREIGN KEY (instructor_id) REFERENCES instructor (id) ON DELETE CASCADE,
        FOREIGN KEY (student_id) REFERENCES student (id) ON DELETE CASCADE
      )
    ''');

        // Create DayProp table
        await database.execute('''
      CREATE TABLE day_prop (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        day_name TEXT,
        from_time TEXT,
        to_time TEXT,
        instructor_id INTEGER,
        FOREIGN KEY (instructor_id) REFERENCES instructor (id) ON DELETE CASCADE
      )
    ''').then((value) {
          emit(CreateTablesDoneState());
          myPrint(text: 'Table Created Successfully');
        }).catchError((error) {
          emit(CreateTablesErrorState());
          myPrint(text: 'Error When Table Created ${error.toString()}');
        });
      },
      onOpen: (database) async {
        await getAllStudents(database);
        await getAllInstructors(database);

        myPrint(text: 'database opened Successfully');
      },
    ).then((value) {
      database = value;
      emit(CreateDatabaseDoneState());
    });
  }

  //Student Register:
  studentRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    emit(StudentRegisterLoadingState());
    await database.transaction((txn) {
      return txn
          .rawInsert('INSERT INTO student(name, email,password ,phone) VALUES'
              '("$name", "$email", "$password", "$phone")');
    }).then((value) async {
      myPrint(text: 'The VALUE IS: $value');
      me = Student(
        id: value,
        name: name,
        email: email,
        password: password,
        phone: phone,
      );
      emit(StudentRegisterDoneState());
      getAllStudents(database);
    }).catchError((error) {
      emit(StudentRegisterErrorState());
    });
  }

  // Get All Students.
  List<Student> students = [];

  getAllStudents(Database database) {
    students = [];
    emit(GetAllStudentsLoadingState());
    database
        .rawQuery(
      'SELECT * FROM student',
    )
        .then((value) {
      for (var element in value) {
        students.add(Student.fromJson(element));
      }

      emit(GetAllStudentsDoneState());
    }).catchError((error) {
      myPrint(text: error.toString());
      emit(GetAllStudentsErrorState());
    });
  }

  // Student Login:

  bool isFind = false;

  studentLogin({
    required String email,
    required String password,
  }) async {
    emit(StudentLoginLoadingState());
    for (Student e in students) {
      if (email == e.email && password == e.password) {
        myPrint(text: 'Hello ${e.name} you\'re logged in Successfully.');
        me = e;
        isFind = true;
        emit(StudentLoginDoneState());
      }
    }
    if (isFind == false) {
      emit(StudentLoginErrorState());
    }
  }

  addInstructor({
    required String name,
    required String email,
    required String phone,
  }) async {
    emit(AddInstructorLoadingState());
    await database.transaction((txn) {
      return txn.rawInsert('INSERT INTO instructor(name, email,phone) VALUES'
          '("$name", "$email", "$phone")');
    }).then((value) async {
      emit(AddInstructorDoneState());
      getAllInstructors(database);
    }).catchError((error) {
      emit(AddInstructorErrorState());
    });
  }

// Get All Instructors:
  List<Instructor> instructors = [];

  getAllInstructors(Database database) {
    instructors = [];
    emit(GetAllInstructorsLoadingState());
    database
        .rawQuery(
      'SELECT * FROM instructor',
    )
        .then((value) {
      for (var element in value) {
        instructors.add(Instructor.fromJson(element));
      }

      emit(GetAllInstructorsDoneState());
    }).catchError((error) {
      myPrint(text: error.toString());
      emit(GetAllInstructorsErrorState());
    });
  }

  // Add Instructor Work Days

  addInstructorWorkDay({
    required int instructorId,
    required String dayName,
    required String fromTime,
    required String toTime,
  }) async {
    emit(AddInsWorkDayLoadingState());
    await database.transaction((txn) {
      return txn.rawInsert(
          'INSERT INTO day_prop(day_name,from_time,to_time,instructor_id) VALUES'
          '("$dayName", "$fromTime", "$toTime", "$instructorId")');
    }).then((value) async {
      emit(AddInsWorkDayDoneState());
      getAllWorkDays4Instructor(database: database, instId: instructorId);
    }).catchError((error) {
      emit(AddInsWorkDayErrorState());
    });
  }

  // Delete Instructor Work Day

  deleteInstructorWorkDay({
    required int instructorId,
    required String dayName,
  }) async {
    emit(DeleteInsWorkDayLoadingState());
    await database.transaction((txn) {
      return txn.rawDelete(
        'DELETE FROM day_prop WHERE (instructor_id = ? and day_name = ?)',
        [instructorId, dayName],
      );
    }).then((value) async {
      emit(DeleteInsWorkDayDoneState());
      getAllWorkDays4Instructor(database: database, instId: instructorId);
    }).catchError((error) {
      emit(DeleteInsWorkDayErrorState());
    });
  }

// GetAllWorkDays4Instructor

  List<WorkDay> instructorWorkDays = [];

  getAllWorkDays4Instructor({
    required Database database,
    required int instId,
  }) {
    instructorWorkDays = [];
    emit(GetInsWorkDaysLoadingState());
    database
        .rawQuery(
      'SELECT * FROM day_prop WHERE instructor_id == "$instId"',
    )
        .then((value) {
      for (var element in value) {
        instructorWorkDays.add(WorkDay.fromJson(element));
      }
      emit(GetInsWorkDaysDoneState());
    }).catchError((error) {
      myPrint(text: error.toString());
      emit(GetInsWorkDaysErrorState());
    });
  }

  /*
    CREATE TABLE instructor_student (
   instructor_id INTEGER,
        student_id INTEGER,
        start_from_time TEXT,
        PRIMARY KEY (instructor_id, student_id),
        FOREIGN KEY (instructor_id) REFERENCES instructor (id) ON DELETE CASCADE,
        FOREIGN KEY (student_id) REFERENCES student (id) ON DELETE CASCADE
   */
  // Book A Session
  bookASession({
    required int instructorId,
    required int studentId,
    required String startFromTime,
    required String dayName,
  }) async {
    emit(BookASessionLoadingState());

    await database.transaction((txn) {
      return txn.rawInsert(
          'INSERT INTO instructor_student(instructor_id,student_id,start_from_time,day_name) VALUES'
          '("$instructorId", "$studentId", "$startFromTime", "$dayName")');
    }).then((value) async {
      emit(BookASessionDoneState());
      getSessions(database: database, studentId: studentId);
    }).catchError((error) {
      myPrint(text: error.toString());
      emit(BookASessionErrorState());
    });
  }

  // Get All Booked Session

  List<Session> mySessions = [];

  getSessions({
    required Database database,
    required int studentId,
  }) {
    mySessions = [];
    emit(GetMySessionsLoadingState());
    database
        .rawQuery(
      'SELECT * FROM instructor_student WHERE student_id == "$studentId"',
    )
        .then((value) {
      for (var element in value) {
        mySessions.add(Session.fromJson(element));
      }
      for (var element in mySessions) {
        myPrint(text: 'Session Time: ${element.startFromTime}');
        myPrint(text: 'Session dayName: ${element.dayName}');
        myPrint(text: 'Session Stud: ${element.studentId}');
        myPrint(text: 'Session Inst: ${element.instructorId}');
      }

      emit(GetMySessionsDoneState());
    }).catchError((error) {
      myPrint(text: error.toString());
      emit(GetMySessionsErrorState());
    });
  }
}
