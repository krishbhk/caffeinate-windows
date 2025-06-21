# ☕ caffeinate.ps1 (Windows)

A lightweight PowerShell script that mimics macOS's `caffeinate` — preventing your **Windows PC** from going to sleep.

Useful for:
- Preventing system idle or display sleep during long operations
- Simulating `caffeinate -i -d` behavior on Windows
- Devs, gamers, streamers, or anyone who needs to keep their system awake

---

## 🛠 Features

- ✅ Prevents **system sleep** and/or **display sleep**
- ✅ Supports **timeout** with `-t` (in seconds)
- ✅ Prints the active flags in hex (like `0x80000003`)
- ✅ Gracefully exits and restores sleep settings
- ✅ No unwanted output (like `2147483648`)
- ✅ Supports basic cross-terminal execution (`cmd`, `PowerShell`, Windows Terminal)

---

## 🚩 Flags Supported

| Flag       | macOS equivalent | Description                                  |
|------------|------------------|----------------------------------------------|
| `-i`       | `caffeinate -i`  | Prevent system idle sleep                    |
| `-d`       | `caffeinate -d`  | Prevent display sleep                        |
| `-s`       | `caffeinate -s`  | Alias for `-i`, for consistency              |
| `-m`       | `caffeinate -m`  | Not supported on Windows (logs a warning)    |
| `-t <sec>` | `caffeinate -t`  | Timeout in seconds; keeps awake for duration |

---

## ⚙️ Installation

1.  **Download the files**
    Grab these two files from this repository:
    * `caffeinate.ps1`
    * `caffeinate.cmd`

    Place them in a user-level script folder like:
    ```makefile
    C:\Users\<YourUsername>\Scripts
    ```
    Create this folder if it doesn't exist.

2.  **Add that folder to your system PATH**
    This allows you to run `caffeinate` from any terminal.

    **📌 Option A: With PowerShell**
    ```powershell
    $scriptPath = "$HOME\Scripts"
    [Environment]::SetEnvironmentVariable("Path", "$env:Path;$scriptPath", "User")
    ```

    **📌 Option B: Manually**
    * Press `Win + S` → search for “Environment Variables”
    * Open “Edit the system environment variables”
    * Click `Environment Variables`
    * Under `User variables`, find `Path` → click `Edit`
    * Add a new entry:
        ```makefile
        C:\Users\<YourUsername>\Scripts
        ```

3.  **Done ✅**
    Now you can run:
    ```powershell
    caffeinate -d -i
    ```
    From PowerShell, cmd, or Windows Terminal just like on macOS.

---

## 💻 Usage

Run from terminal (PowerShell or cmd):

```powershell
caffeinate -i           # Prevent system idle sleep indefinitely
caffeinate -d -i        # Prevent both display and idle sleep
caffeinate -d -i -t 600 # Prevent sleep for 10 minutes (600 seconds)