# Sample App - Ruby on Rails Social Media Platform

A full-featured social media application built with Ruby on Rails, featuring user authentication, microposts, following relationships, image uploads, and more. This application demonstrates modern Rails development practices and includes comprehensive testing.

## Features

- **User Management**: User registration, login/logout, email activation, password reset
- **Microposts**: Create, view, and delete short messages
- **Image Uploads**: Attach images to microposts with validation and resizing
- **Social Features**: Follow/unfollow other users, personalized feed

## Key Models

- **User**: Handles user accounts, authentication, and relationships
- **Micropost**: Short messages with optional image attachments
- **Relationship**: Manages following/follower connections

## Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd sample_app
   ```

2. **Install dependencies**
   ```bash
   bundle install
   ```

3. **Database setup**
   ```bash
   # Create and configure your database.yml file
   cp config/database.yml.example config/database.yml

   # Edit database.yml with your MySQL credentials
   # Then run:
   rails db:create
   rails db:migrate
   rails db:seed
   ```

4. **Environment configuration**
   ```bash
   # Create master key file
   EDITOR="code --wait" bin/rails credentials:edit

   # Set up environment variables for development
   export DATABASE_USERNAME=your_mysql_username
   export DATABASE_PASSWORD=your_mysql_password
   export DATABASE_HOST=your_mysql_host
   export DATABASE_PORT=your_mysql_port
   export GMAIL_USERNAME=your_gmail_username
   export GMAIL_PASSWORD=your_gmail_password
   export CLOUDINARY_CLOUD_NAME=your_cloudinary_name
   export CLOUDINARY_API_KEY=your_cloudinary_key
   export CLOUDINARY_API_SECRET=your_cloudinary_secret
   ```

5. **Start the server**
   ```bash
   rails s
   ```

   Visit http://localhost:3000 to view the application.

## Testing

Run the full test suite:

```bash
# Run all tests
rails t
```
---
