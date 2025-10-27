# SleepScript

A minimalist, interactive **Windows Shutdown Timer**, written entirely in **pure Batch (.bat)**.

It lets you automatically power off your PC after a given number of hours — with a **live countdown** and a **system-wide timer**
that can be checked or canceled from any other Command Prompt window.

I originally wrote it so I could fall asleep to YouTube or podcasts without leaving my PC running all night. Windows hides its sleep
options pretty well, so this script does the job instead.

---

## 🚀 Features

- 🕐 Custom timer (in whole hours)
- 🧮 Live console countdown (hh:mm:ss)
- 🧠 Uses Windows' built-in `shutdown /t` timer (globally visible)
- 🔁 Real-time updates every second
- 🧰 Cancel anytime with **CTRL + C** or from another window:
  ```cmd
  shutdown /a
  ```

## 💻 Usage

1. Download `sleep.bat` or copy the code into a new `.bat` file.
2. Double-click the file to launch it.
3. Enter how many hours you want your PC to stay on (whole numbers only).

Example prompt:

```
How many hours from now should the PC shut down? (e.g. 1, 2, 5): 3
```

The window displays a live countdown like this:

```
Shutdown Countdown
Remaining Time: 02:59:45   (hh:mm:ss)
Cancel: CTRL+C  or from another window: shutdown /a
```

## 🔍 Check or cancel the timer

You can check or cancel the active shutdown timer anytime in another Command Prompt window:

```cmd
shutdown /a
```

- If a timer was active → it’s canceled.
- If no timer was running → you’ll see this message:

```
The system shutdown cannot be aborted because no shutdown is in progress. (1116)
```

Enjoy the rest — your PC will turn itself off when the countdown ends. 😴
