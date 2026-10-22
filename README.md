# Facebook

A social network web application built with Ruby on Rails. Users can create accounts, publish content, connect with other users, and exchange messages.

## Features

- User registration, sign-in, sign-out, password recovery, and account management with Devise.
- A home feed with the user's own posts and posts from friends.
- Creation, editing, and deletion of text posts.
- Image uploads and removal for posts and avatars through Active Storage.
- Friend requests that can be sent, accepted, or rejected.
- Profile and friend list views.
- Comments and likes on posts.
- One-to-one chats with message history.
- Responsive layout based on Bootstrap.

## Technologies

- Ruby on Rails `8.1.3` or higher within the 8.1 series.
- SQLite3, Puma, and Devise.
- Hotwire (Turbo and Stimulus) and Importmap.
- Bootstrap 5 and Dart Sass.
- Active Storage for file attachments.
- Solid Cache, Solid Queue, and Solid Cable.

## Requirements

- Ruby and Bundler.
- SQLite3.
- Node.js, if required by your Sass installation.

Check your installations with:

```bash
ruby --version
bundle --version
sqlite3 --version
```

## Local setup

```bash
git clone https://github.com/mahr940409/facebook.git
cd facebook
bin/setup --skip-server
```

The project uses SQLite and creates its databases inside `storage/`. To reset the development database:

```bash
bin/setup --reset --skip-server
```

## Running the application

To start the server together with the CSS compiler/watch process:

```bash
bin/dev
```

Then open [http://localhost:3000](http://localhost:3000). You can also start only the Rails server with `bin/rails server`.

## Tests

```bash
bin/rails test
```

To run a specific test:

```bash
bin/rails test test/models/user_test.rb
```

## Useful commands

```bash
bin/rails db:prepare       # Prepare the database
bin/rails db:migrate       # Run pending migrations
bin/rails routes           # Review available routes
bin/brakeman              # Run security analysis
bin/bundler-audit         # Check dependencies for vulnerabilities
bin/rubocop               # Check Ruby code style
```

## Main structure

```text
app/
├── controllers/   # Request handling and application actions
├── models/        # Users, posts, friendships, chats, and messages
├── views/         # HTML/ERB templates
└── javascript/    # Importmap and Stimulus controllers
config/            # Routes and application configuration
db/                # Migrations, schema, and seed data
test/              # Automated tests
```

## Database and uploaded files

In development, the main database is `storage/development.sqlite3`. Profile and post images are managed by Active Storage and stored locally in development. In production, the `storage/` directory must remain persistent to avoid losing the database and uploaded files.

## Production

The project includes Docker and Kamal deployment configuration. Before deploying, review production credentials and environment variables, `storage/` persistence, Active Storage, and Devise email configuration.

## Review status

This documentation was prepared from the current routes, models, controllers, dependencies, and configuration. The application logic and existing views were not changed as part of the documentation work.

## License

This project does not currently include a license file. Add one before publishing if you want to define the terms of use and distribution.
