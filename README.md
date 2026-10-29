# Bash Backup Utility

## 1. Project Name

**Bash Backup Tool** — an automated directory backup script written in Bash.

## 2. Problem Statement

Manually backing up files can be time-consuming and may lead to losing important data. This project provides a simple way to create compressed backups and automatically remove older copies to manage storage.

## 3. Project Goals

- Automate directory backups.
- Create timestamped `.tar.gz` archives.
- Allow users to customize backup destinations and retention limits.
- Prevent existing backup archives from being overwritten.
- Practice Bash scripting, input validation, and error handling.

## 4. Tech Stack

- **Bash** — scripting and automation.
- **tar** — creating compressed archives.
- **Linux Terminal** — running and testing the script.
- **Git and GitHub** — version control and project hosting.

## 5. Features

- Creates timestamped, compressed backups.
- Supports custom backup destinations using `-d`.
- Sets the number of backups to retain using `-k`.
- Enables detailed logs using `-v`.
- Displays usage instructions using `-h`.
- Prevents overwriting existing archives.
- Automatically removes older backups.
- Validates input and reports errors.

## 6. Screenshots

### Source Code

![alt text](<assets/img/Screenshot From 2026-10-29 09-23-31.png>)

### Program Output

Add a screenshot of the script running successfully in the terminal.

![alt text](<assets/img/Screenshot From 2026-10-29 09-28-35.png>)

## 7. Installation and Setup

**Step 1: Clone the repository*

```bash
git clone <your-repository-url>
cd <your-project-folder>
```

**Step 2: Make the script executable*

```bash
chmod +x backup.sh
```

**Step 3: Run a backup*

```bash
./backup.sh ~/Documents
```

**Step 4: Customize your backup*

```bash
./backup.sh -d ~/my-backups -k 3 -v ~/Documents
```

By default, backups are stored in `~/backups`, and the script retains the latest five backups.

## 8. What I Learned

- Writing and organizing Bash functions.
- Processing command-line options with `getopts`.
- Using variables, conditionals, loops, and arithmetic.
- Creating compressed archives with `tar`.
- Validating input and handling errors.
- Managing backup retention and preventing filename collisions.
- Testing scripts and using Git for version control.

## 9. Author

**Tata Stanley Mbajing**  
Junior Frontend Developer

**Email:** [stanleymbajingtata@gmail.com]
