### Introduction
An opensource tool project which helps GDG organizers/Flutter trainers to parse result of online codelabs result.

### How to run project
This project is mainly supported on Web platform. 

1. See [GUIDELINE.md](assets/GUIDELINE.md) (or access this via `Guideline` navigation menu from the application) to know how to prepare the input data.

2. Run project

	```shell
	flutter run -d chrome
	```

	**Note**: To run with dump data (pre-defined data in `lib/data/local_data.dart`) (this data is not really accurate, I recommend to use real data):
	```shell
	flutter run -d chrome --dart-define data=fake
	```

3. _(Run with real data)_ Once you have **Google Apps Script** endpoint url, let's use it in `Final result` page

#### Commands in use

- Code generation for entities (be used for some class like: `lib/entity/participant.dart`)
```shell
flutter pub run build_runner build
```

- Auto-fill App Script url on Final Result page by adding `--dart-define appscripturl=<APP_SCRIPT_URL>` to run args

### Demo

https://user-images.githubusercontent.com/29337364/204867785-1c1a362b-ada9-4f14-8b68-812c2fd6fc08.mp4

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
