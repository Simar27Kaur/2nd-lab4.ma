I encountered challenges with my initial approach and took minimal help from GPT to explore an alternative solution. The implementation and code were entirely written by me after understanding the suggested approach.

#Student Marks Management App
Description
This Flutter app allows you to manage student marks using SQLite for database storage. You can add students with their names and marks, view the list of students, and interact with the database.

Features:
Add new students with their names and marks.
View a list of students along with their marks.
Data is stored locally using SQLite.
Project Structure
bash
Copy
Edit
lib/
├── main.dart            # Entry point of the application
├── student_list_page.dart  # The page where students are added and displayed
└── database_helper.dart  # Contains the logic for database operations (SQLite)
Prerequisites
Make sure you have Flutter installed on your machine. If you don't have Flutter installed, follow the instructions on the official Flutter website: https://flutter.dev/docs/get-started/install

Installation
Clone or download this repository.

Navigate to the project directory.

Run the following command to get all the required dependencies:

bash
Copy
Edit
flutter pub get
Running the Application
To run the application, use the following command:

bash
Copy
Edit
flutter run
The app will launch and display a screen where you can add students and their marks. The student list will automatically update once a new student is added.

Files Modified
The following files were modified to implement the required functionality:

main.dart: Entry point of the app, set up routing.
student_list_page.dart: Contains the UI for adding and displaying student data.
database_helper.dart: Contains the logic to handle SQLite database operations (inserting and retrieving student data).
pubspec.yaml: Added required dependencies for SQLite and other packages.
License
This project is open-source. Feel free to modify or use it as needed.
