# README

## Project Name: TaskProAPI

TaskPro is a web-based application designed to streamline task and project management. It allows users to create, assign, track tasks, and offers analytical insights and recommendations for optimal task and project performance. The application currently supports Ukrainian and English languages.

### Technologies Used:
- Framework: Ruby on Rails
- Database: PostgreSQL
- Authentication: Devise

### Key Features:

1. **User Registration and Login.**
  - Allows for user registration with mandatory email confirmation.
  - Facilitates user authentication via email and password.

2. **Task Management.**
  - Displays a list of all user tasks, including incomplete and completed tasks.
  - Enables the creation of a new task with the specification of name, description, deadline, and priority level.
  - Users can assign tasks to other users or teams.
  - Tracking task status, marking them as completed or cancelled.

3. **Analysis and Recommendations.**
  - The system analyses task completion data and provides recommendations for optimizing task and project management.

4. **Alerts and Reminders.**
  - The application sends notifications about approaching task deadlines or when new tasks are assigned.

5. **Task Filtering and Sorting.**
  - Users can filter and sort tasks based on various parameters such as status, priority, deadline, etc.

6. **Task comments.**
  - Users have the ability to provide comments on tasks.

### Architecture:
  - Creating models, controllers, and migrations for database interactions.
  - Implementation of GraphQL API for frontend interaction.
  - Provides user authentication and authorization services.
  - Integrated with PostgreSQL database for persistent data storage.

### Future Development Tasks
1. Data Export and Import Functionality
  - Implementation of task and project data export and import features in various formats.

## Version

- Ruby **3.3.0-preview2**
- Rails **7.0.8**
- Postgres **14**

## Quick Start

1. **Clone the project.**
    ```bash
    git clone git@github.com:kolan4ick/TaskProAPI.git
    cd TaskProAPI
    ```

2. **Install Ruby and RVM (if needed).**
3. **Install gems.**
   ```bash
   bundle
   ```
4. **Customize the *.env* file.**
   ```bash
   cp .env-template .env
   ```
5. **Create Database and Run Migrations.**
    ```bash
    rails db:setup
    ```

6. **Start the Project.**
    ```bash
    rails s
    ```