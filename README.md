# ELEVE Makeup

Welcome to the ELEVE Makeup application! This Ruby on Rails application is designed for a fictitious makeup brand, ELEVE Makeup. It integrates various tools and gems to provide a robust e-commerce experience.

## Features

- **Spree Gem**: Powers the e-commerce functionalities including product management, shopping cart, and checkout.
- **Bootstrap**: Ensures a responsive design and modern UI components.
- **Kaminari**: Manages pagination for products and other collections.
- **Mailgun**: Handles email communications, such as order confirmations and newsletters.
- **Stripe**: Facilitates secure payment processing.

## Screenshots

### Web View

![Web View](images/web-view.png)

### Mobile View

![Mobile View](images/mobile-view.png)

## Getting Started

### Prerequisites

- Ruby (2.7 or later)
- Rails (6.x or later)
- Docker (for containerization)

### Setting Up Locally

1. **Clone the Repository**

   ```bash
   git clone https://github.com/NicoleOkamoto/makeup_ruby_rails_store
   cd makeup_ruby_rails_store

2. **Set Up Docker**

   Build and start the Docker containers:

   ```bash
   docker-compose up --build

3. **Run Database Migrations**

  Execute database migrations:

  ```bash
  Copy code
  docker-compose run web rails db:migrate

4. **Seed the Database**

  Load initial data:

  ```bash
  Copy code
  docker-compose run web rails db:seed

5. **Import the Backup**

  Import a database backup (ensure the backup file is correctly located):

  ```bash
  Copy code
  docker-compose run web rails db:restore

6. **Start the Rails Server**

  Start the server and access the application:

  ```bash
  Copy code
  docker-compose up

  Visit http://localhost:3000 in your browser.

### Configuration

- Mailgun: Update config/environments/production.rb with your Mailgun API key and domain.
- Stripe: Configure your Stripe API keys in config/credentials.yml.enc or environment variables.
- Spree Configuration: Customize settings via the Spree admin interface or configuration files.