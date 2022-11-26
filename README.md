### Introduction
An opensource tool project which helps GDG organizers/Flutter trainers to parse result of online codelabs result.

### How to run project
This project is mainly supported on Web platform. 

1. See [GUIDELINE.md](assets/GUIDELINE.md) (or access this via `Guideline` navigation menu from the application) to know how to prepare the input data.

2. Run project

```shell
flutter run -d chrome
```

**Note**: To run with dump data (pre-defined data in `lib/data/local_data.dart`):
```shell
flutter run -d chrome --dart-define data=fake
```

3. _(Run with real data)_ Once you have **Google Apps Script** endpoint url, let's use it in `Final result` page

### Packages & plugins
- `flutter_adaptive_scaffold`: Adaptive layout with navigation menu (drawer, bottom bar). Using as main layout for this project
- `html`: parser HTML webpage content (public profile page)
- `http`: query HTTP requests
- `dartz`: functional programming. Mainly usage is Either class
- `get_it`: service locator for injecting class
- `intl`: format datetime
- `url_launcher`: support open url (profile page)
- `provider`: as a state management. Using for storing and querying in-memory data
- `flutter_markdown`: display nice guideline