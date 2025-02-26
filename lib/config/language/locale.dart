import 'package:get/get.dart';

class MyLocale implements Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "ar": {
          // title
          "todo_list": "Todoey",

          // my_message
          "error": "خطأ",
          "warning": "تنبيه",
          "cancel": "إلغاء",
          "ok": "موافق",
          "emptyTaskTitle": "يجب إضافة عنوان للمهمة.",
          "confirmDeleteTask": "هل أنت متأكد من حذف هذه المهمة؟",
          "confirmDeleteCategory": "هل أنت متأكد من حذف هذه الفئة؟",

          // my_snack_bar
          "languageChanged": "تم تغيير اللغة بنجاح.",
          "newTaskAdded": "تم إضافة مهمة جديدة.",
          "taskDeleted": "تم حذف المهمة بنجاح.",
          "taskUpdated": "تم تعديل المهمة بنجاح.",
          "categoryDeleted": "تم حذف الفئة بنجاح.",
          "categoryAdded": "تم إضافة فئة جديدة بنجاح.",
          "emptyCategoryTitle" : "يجب إضافة اسم للفئة.",

          // language_popup
          "selectLanguage": "إختر اللغة",
          "arabic": "العربية",
          "english": "English",

          // my_date_picker
          "selectDate": "إختر الموعد النهائي",

          // splash_screen
          "todolist": "قائمة المهام",
          "todolistApp": "تطبيق قائمة المهام",

          // tasks_screen
          "allTasks": "جميع المهام",
          "todo": "المهام",
          "completed": "مكتملة",
          "nothingToDo": "لا يوجد مهمام.",
          "noDueDate": "لا يوجد موعد نهائي",
          "settings": "الإعدادات",
          "categories": "الفئات",
          "taskCompleted": "تم إنهاء المهمة.",
          "completedTasks": "المهام المكتملة",

          // completed_tasks_screen
          "noCompletedTasks": "لا يوجد مهام مكتملة.",

          // add_task_screen
          "addTask": "إضافة مهمة",
          "taskTitle": "موضوع المهمة",
          "dueDate": "الموعد النهائي",
          "selectCategory": "إختر فئة (إختياري)",
          "dueDateOptional": "الموعد النهائي (إختياري)",
          "taskReminder": "تذكير بالمهمة",
          "yourTask": "موعد إنجاز مهمتك",
          "isDue": "قد حان!",
          "start": "إبدأ بتخطيط يومك!",

          // edit_task_screen
          "save": "حفظ",
          "editTask": "تعديل المهمة",

          // settings screen
          "language": "اللغة",
          "backup": "النسخ الإحتياطي",
          "saveNotes": "عمل نسخة احتياطية",
          "restoreNotes": "استعادة من نسخة إحتياطية محفوظة",

          // categories_screen
          "allCategories": "جميع الفئات",
          "Personal": "شخصي",
          "Shopping": "تسوق",
          "Wishlist": "قائمة الرغبات",
          "Work": "عمل",
          "Study": "دراسة",
          "addCategory": "إضافة فئة",
          "noCategories": "لا يوجد فئات.",
        },
        "en": {
          // title
          "todo_list": "Todoey",

          // my_message
          "error": "Error",
          "warning": "Warning",
          "cancel": "Cancel",
          "ok": "OK",
          "emptyTaskTitle": "Tasks must have titles.",
          "confirmDeleteTask": "Are you sure you want to delete this task?",
          "confirmDeleteCategory":
              "Are you sure you want to delete this category?",

          // my_snack_bar
          "languageChanged": "Language has been changed.",
          "newTaskAdded": "New task has been added successfully.",
          "taskDeleted": "Task has been deleted successfully.",
          "taskUpdated": "Task has been updated successfully.",
          "categoryDeleted": "Category has been deleted successfully.",
          "categoryAdded": "New Category has been added successfully.",
          "emptyCategoryTitle" : "Category name field must be filled.",

          // language_popup
          "selectLanguage": "Select Language",
          "arabic": "العربية",
          "english": "English",

          // my_date_picker
          "selectDate": "Select Date",

          // splash_screen
          "todolist": "To-Do List",
          "todolistApp": "To-Do List App",

          // tasks_screen
          "allTasks": "All Tasks",
          "todo": "To Do",
          "completed": "COMPLETED",
          "nothingToDo": "Nothing to do.",
          "noDueDate": "No due date",
          "settings": "Settings",
          "categories": "Categories",
          "taskCompleted": "Task completed.",
          "completedTasks": "Completed Tasks",

          // completed_tasks_screen
          "noCompletedTasks": "No completed tasks yet.",

          // add_task_screen
          "addTask": "Add Task",
          "taskTitle": "Task Title",
          "dueDate": "Due Date",
          "selectCategory": "Select Category (Optional)",
          "dueDateOptional": "Due Date (Optional)",
          "taskReminder": "Task Reminder",
          "yourTask": "Your task",
          "isDue": "is due!",
          "start": "Start planing your day!",

          // edit_task_screen
          "save": "Save",
          "editTask": "Edit Task",

          // settings screen
          "language": "Language",
          "backup": "Backup",
          "saveNotes": "Make a Backup",
          "restoreNotes": "Restore Backup",

          // categories_screen
          "allCategories": "All Categories",
          "Personal": "Personal",
          "Shopping": "Shopping",
          "Wishlist": "Wishlist",
          "Work": "Work",
          "Study": "Study",
          "addCategory": "Add Category",
          "noCategories": "No categories.",
        },
      };
}
