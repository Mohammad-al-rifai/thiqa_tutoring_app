part of 'database_cubit.dart';

@immutable
abstract class DatabaseStates {}

class DatabaseInitialState extends DatabaseStates {}

class CreateDatabaseDoneState extends DatabaseStates {}

class CreateTablesDoneState extends DatabaseStates {}

class CreateTablesErrorState extends DatabaseStates {}

// Student Register States:

class StudentRegisterLoadingState extends DatabaseStates {}

class StudentRegisterDoneState extends DatabaseStates {}

class StudentRegisterErrorState extends DatabaseStates {}

// StudentLogin States:
class StudentLoginLoadingState extends DatabaseStates {}

class StudentLoginDoneState extends DatabaseStates {}

class StudentLoginErrorState extends DatabaseStates {}

// Get All Students:
class GetAllStudentsLoadingState extends DatabaseStates {}

class GetAllStudentsDoneState extends DatabaseStates {}

class GetAllStudentsErrorState extends DatabaseStates {}

// Get All Instructors:
class GetAllInstructorsLoadingState extends DatabaseStates {}

class GetAllInstructorsDoneState extends DatabaseStates {}

class GetAllInstructorsErrorState extends DatabaseStates {}

// Add New Instructor:
class AddInstructorLoadingState extends DatabaseStates {}

class AddInstructorDoneState extends DatabaseStates {}

class AddInstructorErrorState extends DatabaseStates {}

// Add  Instructor Work Day:
class AddInsWorkDayLoadingState extends DatabaseStates {}

class AddInsWorkDayDoneState extends DatabaseStates {}

class AddInsWorkDayErrorState extends DatabaseStates {}

// Delete  Instructor Work Day:
class DeleteInsWorkDayLoadingState extends DatabaseStates {}

class DeleteInsWorkDayDoneState extends DatabaseStates {}

class DeleteInsWorkDayErrorState extends DatabaseStates {}

// Get  Instructor Work Days:
class GetInsWorkDaysLoadingState extends DatabaseStates {}

class GetInsWorkDaysDoneState extends DatabaseStates {}

class GetInsWorkDaysErrorState extends DatabaseStates {}

//  Book A Session:
class BookASessionLoadingState extends DatabaseStates {}

class BookASessionDoneState extends DatabaseStates {}

class BookASessionErrorState extends DatabaseStates {}

//  Get All Session 4 me:
class GetMySessionsLoadingState extends DatabaseStates {}

class GetMySessionsDoneState extends DatabaseStates {}

class GetMySessionsErrorState extends DatabaseStates {}
