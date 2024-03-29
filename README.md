
# directus_flutter

A Flutter plugin to receive and render contents of [directus](https://directus.io/) headless cms API.
The main goal of this plugin is a support for rendering all basic interfaces from flutter.

## :construction: Under Development
This project is currently under development and is not ready for use by anyone except those wishing to develop it.

## :metal: Contribute
Feel free to create a merge request if youre missing something!

## :books: Example data
The example data used in tests and the example app are loaded from the [offical directus demo](https://demo.directus.io/admin/#/login). You can modify the data there as you whish, the demo gets resettet every hour.
Or, you can use your own container for testing (See [docs](https://docs.directus.io/self-hosted/installation/docker.html)):
```bash
docker run \
  -p 8055:8055 \
  -e KEY=255d861b-5ea1-5996-9aa3-922530ec40b1 \
  -e SECRET=6116487b-cda1-52c2-b5b5-c8022c45e263 \
  -e ADMIN_EMAIL="admin@example.com" \
  -e ADMIN_PASSWORD="password" \
  --rm \
  directus/directus
```

## :rocket: Getting Started

This project is a starting point for a Dart
[package](https://flutter.dev/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.


## :page_with_curl: List of basic interfaces
Heres a full list of basic interfaces. Striked ones are implemented
- Text Input
- ~~Text-Area~~
- ~~WYSIWYG~~
- Switch
- Datetime
- Calendar
- File
- Many to One
- 2FA Secret
- Button Group
- Calendar
- Checkboxes Relational
- Checkboxes
- Code
- Collections
- Color Picker
- Color
- Date
- Datetime Created
- Datetime Updated
- Datetime
- Divider
- Dropdown
- File Preview
- File Size
- File
- Files
- Hashed
- Icon
- Interface Options
- Interface types
- Interfaces
- JSON
- Key / Value
- Language
- Many to Many
- Many to One
- Map
- Markdown
- Multi-Select
- Numeric
- One to Many
- Owner
- Password
- Preview
- Primary Key
- Radio Buttons
- Rating
- Repeater
- Slider
- Slug
- Sort
- Status
- Tags
- Time
- Toggle Icon
- Translation
- User Role
- User Updated
- User
