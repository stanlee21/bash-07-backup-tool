# Bash Backup Tool

A directory backup utility written in Bash that creates timestamped, compressed archives and automatically manages older backups.

## 1. Project Overview

Manually backing up files and directories can be time-consuming and may lead to losing important data. This project provides a simple command-line solution for creating compressed backups and managing backup retention.

## 2. Project Goals

- Automate directory backups.
- Create timestamped `.tar.gz` archives.
- Allow users to customize backup destinations and retention limits.
- Prevent existing backup archives from being overwritten.
- Practice Bash scripting, input validation, and error handling.

## 3. Technologies Used

- **Bash** – scripting and automation.
- **tar** – creating compressed archives.
- **Linux Terminal** – running and testing the script.
- **Git and GitHub** – version control and project hosting.

## 4. Features

- Creates timestamped, compressed backups.
- Supports custom backup destinations using `-d`.
- Allows users to specify the number of backups to retain using `-k`.
- Provides detailed logs using `-v`.
- Displays usage instructions using `-h`.
- Validates source directories and command-line arguments.
- Prevents existing backup archives from being overwritten.
- Automatically removes older backups while retaining the specified number.
- Creates the destination directory if it does not exist.

## 5. Installation and Setup

### Step 1: Clone the repository

```bash
git clone https://github.com/stanlee21/bash-07-backup-tool.git
cd bash-07-backup-tool
```

### Step 2: Make the script executable

```bash
chmod +x backup.sh
```

### Step 3: Run a basic backup

```bash
./backup.sh ~/Documents
```

### Step 4: Customize your backup

```bash
./backup.sh -d ~/my-backups -k 3 -v ~/Documents
```

## 6. Usage

```bash
./backup.sh [-d DEST] [-k KEEP] [-v] SOURCE
```

| Option | Description |
| --- | --- |
| `-d DEST` | Specify where backups should be stored. Default: `~/backups`. |
| `-k KEEP` | Specify how many backups to retain. Default: `5`. |
| `-v` | Enable verbose logging. |
| `-h` | Display help instructions. |

**Example:**

```bash
./backup.sh -d ~/backups -k 3 -v ~/Documents
```

This creates a compressed backup of `~/Documents`, stores it in `~/backups`, and retains the latest three matching backups.

### Backup Naming Format

Archives follow this naming convention:

```text
SOURCE-YYYYMMDD-HHMMSS.tar.gz
```

For example:

```text
Documents-20261123-153045.tar.gz
```

If an archive with the same timestamp already exists, the script reports an error rather than overwriting it.

## 7. Exit Codes

| Exit code | Meaning |
| --- | --- |
| `0` | Successful backup or help display. |
| `1` | Operational error, such as backup creation or file removal failure. |
| `2` | Invalid arguments, missing source, or invalid input. |

## 8. Screenshots

### Source Code

![Backup Tool Source Code](assets/img/Screenshot%20From%202026-10-29%2009-23-31.png)

### Program Output

![Backup Tool Program Output](assets/img/Screenshot%20From%202026-10-29%2009-28-35.png)

## 9. What I Learned

- Writing and organizing Bash functions.
- Processing command-line options using `getopts`.
- Working with variables, conditionals, loops, and arithmetic.
- Creating compressed archives using `tar`.
- Validating user input and handling errors.
- Managing backup retention and preventing filename collisions.
- Testing scripts and managing projects with Git and GitHub.

## 10. Author

**Tata Stanley Mbajing**  
Software Developer

**Email:** <stanleymbajingtata@gmail.com>
