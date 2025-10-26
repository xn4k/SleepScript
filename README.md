# SleepScript
BAT dynamic script to shut down your pc after x hors with live time tracking.
Honestly, I just wanted to fall asleep while watching YouTube or listening to podcasts 
but I didn’t want my PC to keep running all night.
I looked for a built-in Windows sleep timer, but apparently there isn’t one (or it’s well hidden 😅).
So I thought, “Hey, I’ll just write my own.”
Now I can enjoy my shows and still have my PC shut down automatically when I’m asleep.

# 🕒 Simple Shutdown Timer for Windows

A minimalist, interactive **Windows Shutdown Timer**, written entirely in **pure Batch (.bat)**.  
It lets you automatically power off your PC after a given number of hours — with a **live countdown** and a **system-wide timer** that can be checked or canceled from any other CMD window.

---

## 🚀 Features

- 🕐 Custom timer (in hours)
- 🧮 Live console countdown (hh:mm:ss)
- 🧠 Uses Windows' built-in `shutdown /t` timer (globally visible)
- 🔁 Real-time updates every second
- 🧰 Cancel anytime with **CTRL + C** or from another window:
  ```cmd
  shutdown /a

💻 Usage

Download sleep.bat or copy the code into a new .bat file.

Double-click the file to launch it.

Enter how many hours you want your PC to stay on.
Example:

In wie vielen Stunden soll der PC herunterfahren? (z.B. 1, 2, 5): 3


The window displays a live countdown like this:

Countdown zum Herunterfahren
Verbleibende Zeit: 02:59:45   (hh:mm:ss)
Abbrechen: STRG+C or shutdown /a

🔍 Check or cancel the timer

You can check or cancel the active shutdown timer anytime in another CMD window:

shutdown /a


If a timer was active → it’s canceled.

If no timer was running → you’ll see:

The system shutdown cannot be aborted because no shutdown is in progress. (1116)

I will make english version next time! lol

