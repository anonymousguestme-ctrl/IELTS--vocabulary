# Notes: IELTS Word Bench

- User needs four core actions: record words with word/part of speech/meaning/phrase/sentence, check off mastered words, isolate unknown words, and print them for offline study.
- The app should stay useful without a backend or account; localStorage is the appropriate persistence boundary.
# 2026-08-30 Windows support

- The app already uses Python's standard-library `server.py`, so the application code is cross-platform.
- Added `启动雅思词汇本.bat` for Windows double-click startup. It detects `py -3` or `python`, reuses an existing port 8765 service, waits for a new service to become ready, and opens the default browser.
- README now has direct macOS / Windows navigation and a Windows setup section.
