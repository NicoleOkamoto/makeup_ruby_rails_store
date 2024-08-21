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

![Web View](app/assets/images/web-view.png)

### Mobile View

![Mobile View](app/assets/images/mobile-view.png)

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

2. **Run Setup Command**

   Build and start the Docker containers:

   ```bash
   bin/setup

4. **Seed the Database**

   Load initial data:

    ```bash
    rails db:seed

5. **Import the Backup**

   Import a database backup:

   ```bash
    pg_restore -U postgres -h localhost -p 5432 -d spree_starter_development -F c -v db/backups/eleve_backup.dump

6. **Start the Rails Server**

   Start the server and access the application:

    ```bash
    bin/rails server

Visit http://localhost:3000 in your browser.

### Configuration

- Mailgun: Update config/environments/production.rb with your Mailgun API key and domain.
- Stripe: Configure your Stripe API keys in config/credentials.yml.enc or environment variables.
- Spree Configuration: Customize settings via the Spree admin interface or configuration files.