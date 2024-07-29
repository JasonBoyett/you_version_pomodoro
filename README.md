# tomato_timer

A pomodro timer built for a technical interview for YouVersion.

## Tasks

- [x] Build back end logic for timer.
- [x] Impliment [riverpod](https://riverpod.dev) for state management.
- [x] Create front end for timer that responds to change in state.
- [x] Create settings page.
- [x] Allow user to change settings and have changes reflected in the timer.
- [x] Persist settings between sessions.
- [x] Impliment device vibration when stages change.
- [ ] create tablet ui for settings.
    - [ ] widgets withing settings ui are arranged differently between tablet and mobile
    - [ ] propper sizing is applied to both tablet and mobile.
    - [x] propper alighnment is applied to both tablet and mobile.

## Challenges

- Golden fies would not generate in local dev environtment
  - solution: run golden tests in docker container

- [Divice vibration library](https://pub.dev/packages/vibration) doesn't play nice
  with [fake async](https://pub.dev/documentation/quiver/latest/testing_src_async_fake_async/FakeAsync-class.html)
  - solution: create state that allows the vibration controller to know weather
    it is being run in a testing environment.
