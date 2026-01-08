<p align="center">
    <img src="https://raw.githubusercontent.com/webreinvent/vaahcms/master/Resources/assets/backend/vaahone/images/vaahcms-logo.svg" width="50%" />
</p>

<br/>

> **[VaahStore](https://vaah.dev/store)** is an open-source e-commerce platform built on top of Laravel with headless architecture, ready for multi-store and multi-vendor applications.

**VaahStore** is built with `Laravel 10`, `Vue 3`, `Pinia`, and `PrimeVue`, following the **Hierarchical Model View Controller (HMVC)** architectural pattern. Each module and theme can be configured with either simple Blade files or full frontend frameworks like `Vue` or `React`.

---

- [Introduction](https://vaah.dev/store)
- [Features](https://vaah.dev/store/features)
- [Documentation](https://docs.vaah.dev/vaahstore/)

---

## 🚀 Quick Start with Docker

### Prerequisites

- **Docker** and **Docker Compose** installed on your system
- **Git** for cloning the repository

### Installation Steps

1. **Clone the repository:**

   ```bash
   git clone https://github.com/webreinvent/vaahstore.git
   cd vaahstore
   ```

2. **Start the Docker containers:**

   ```bash
   docker compose up -d
   ```

   This will start all required services:

   - **PHP-FPM** (application server)
   - **Nginx** (web server) - `http://localhost:8080`
   - **MySQL 8.0** (database)
   - **Redis 7** (cache)
   - **Node 20** (frontend dev server) - `http://localhost:5173`

3. **Access the application:**
   - **Backend/API:** http://localhost:8080
   - **Frontend (Vue):** http://localhost:5173
   - **Admin Panel:** http://localhost:8080/backend

### Database Configuration

The application uses the following MySQL database credentials:

```
Host: localhost (from host machine) or db (from containers)
Port: 3307 (mapped from container's 3306)
Database: vaahstore
Username: vaahstore
Password: secret
```

### Useful Docker Commands

```bash
# Start all containers
docker compose up -d

# Stop all containers
docker compose down

# View container logs
docker compose logs -f [service_name]  # e.g., app, nginx, node

# Restart a specific service
docker compose restart [service_name]

# Execute commands inside containers
docker compose exec app php artisan [command]
docker compose exec app composer [command]

# Clear Laravel caches
docker compose exec app php artisan cache:clear
docker compose exec app php artisan config:clear
```

---

## 🎯 Alternative Installation (CLI)

Install VaahStore using the VaahCLI:

```bash
npx vaah store:install
```

This command sets up the project with all required configurations, database migrations, and sample data.

---

## 🛠 Technology Stack

| Layer         | Technology             |
| ------------- | ---------------------- |
| Backend       | Laravel 10             |
| Frontend      | Vue 3                  |
| UI Components | PrimeVue               |
| Architecture  | Headless CMS with HMVC |

---

## ⚙ Requirements

**For Docker Installation (Recommended):**

- Docker Desktop or Docker Engine
- Docker Compose V2
- 4GB+ RAM available
- 10GB+ free disk space

**For Manual Installation:**

- PHP: >= 8.1
- MySQL: >= 8.0
- Redis
- Node.js: >= 16
- Composer
- npm or yarn

**Learning Curve:**

- **Minimum:** Knowledge of VaahCMS is enough to quickly build an e-commerce site
- **Advanced:** To customize VaahStore, knowledge of Laravel, Vue.js, PrimeVue, and VaahCMS is required

---

## 💻 Demo

**Live Demo:**

- Backend URL: https://81.vi.getdemo.dev/store-dev/staging/public/backend
- Frontend URL: https://nuxtstore-frontend-staging.vercel.getdemo.dev/

**Local Development:**

- Backend/API: http://localhost:8080
- Admin Panel: http://localhost:8080/backend
- Frontend (Vue): http://localhost:5173
- Database: localhost:3307 (MySQL)

---

## ❓ Why VaahStore?

VaahStore is an **E-commerce module for VaahCMS**, built on top of the latest open-source technologies such as **Laravel, Vue.js, and PrimeVue**.

It is suitable for small or large e-commerce business demands using a simple setup procedure. Built on top of VaahCMS, it comes equipped with **easy product information management**.

---

### 🌟 Key Advantages

- ✅ **Open-Source:** Free to use and extend
- 🧩 **Modern Tech Stack:** Laravel, Vue.js, PrimeVue, VaahCMS
- ⚡ **Flexible & Scalable:** Suitable for small to large businesses
- 🔧 **Customizable:** Can be tailored to specific business needs

---

## 🔑 Features

| Feature                     | Description                                                             |
| --------------------------- | ----------------------------------------------------------------------- |
| 🏬 Multi-Store              | Manage multiple stores including multi-currency & multi-lingual support |
| 🏬 Multi-Vendor             | Manage multiple vendors within a single store                           |
| 💱 Multi-Currency           | Support store's transactions in various currencies                      |
| 🌐 Multi-Lingual            | Operate store in multiple languages                                     |
| 💖 Wishlists                | Save and manage favorite products                                       |
| 🔗 Headless Product Content | Manage product data via APIs                                            |
| 📦 Product Stock Management | Track and manage stock in real-time                                     |
| 🔄 Wishlist Sharing         | Share wishlists with others                                             |
| 🛒 Cart Management          | Recover abandoned carts to boost sales                                  |
| 🚚 Shipment                 | Manage and track orders including statuses                              |
| 💳 Payment                  | Handle transactions, support multiple payment methods                   |
| ✅ Selected Vendor          | Assign products to vendors and handle orders separately                 |

VaahStore combines **robust features with ease of use**, making it ideal for diverse e-commerce needs.

---

## 📝 Development Notes

### Initial Setup & Configuration

After running `docker compose up -d`, the application requires initial configuration:

1. **Database Setup:**

   - VaahCMS installation wizard accessible at `http://localhost:8080`
   - Complete the setup wizard to create database tables
   - Admin credentials: `123@gmail.com` / `password` (or create your own)

2. **Module Activation:**

   - Navigate to **Modules** in the admin panel
   - Activate the **Store** module
   - This creates 32 additional database tables for e-commerce functionality

3. **Development Mode:**
   - Frontend runs on Vite dev server at `http://localhost:5173`
   - Hot module replacement (HMR) enabled for Vue components
   - API requests proxy from frontend to backend at `http://localhost:8080`

### Known Issues & Fixes

During development, several configuration issues were resolved:

- **CORS Configuration:** Enabled `supports_credentials` in `config/cors.php` for cross-origin session handling
- **VaahExtend Service Provider:** Manually registered in `config/app.php` for VaahCountry facade support
- **Authentication:** Development mode allows unauthenticated API access for easier testing
- **Route Configuration:** All Store module routes prefixed with `/api/store/*`

### File Structure

```
vaahstore-ECommerce/
├── docker-compose.yml          # Docker services configuration
├── Dockerfile                  # Application container
├── VaahCms/                   # VaahCMS core
│   └── Modules/
│       └── Store/             # Store module (HMVC)
│           ├── Http/
│           │   └── Controllers/  # API controllers
│           ├── Models/          # Eloquent models
│           ├── Routes/          # API routes
│           └── Database/        # Migrations & seeds
├── Vue/                       # Frontend application
│   ├── pages/                 # Vue page components
│   ├── stores/                # Pinia state stores
│   └── routes/                # Vue Router config
└── docker/                    # Docker configuration files
```

### Troubleshooting

**Blank Pages:**

- Ensure Store module is activated in admin panel
- Check browser console for API errors
- Verify CORS settings allow credentials
- Clear Laravel cache: `docker compose exec app php artisan cache:clear`

**Database Connection:**

- Containers use host `db` (internal Docker network)
- Host machine uses `localhost:3307`
- Verify credentials in `.env` file

**Frontend Not Loading:**

- Check Node container logs: `docker compose logs node`
- Restart frontend: `docker compose restart node`
- Access at `http://localhost:5173`

---

## 🤝 Join Us

- **Contribute & report issues:** [GitHub](https://github.com/webreinvent/vaahstore)
- **Join the community:** [Slack](https://join.slack.com/t/vaah/shared_invite/zt-wgvx75rr-tuAhGtjRweCR~DEVSTFcSQ)
- **Learn more:** [Official Website](https://vaah.dev/store)

Pull requests for **documentation, features, and improvements** are welcome!

---

## 💖 Support VaahStore

If VaahStore helped you, **please star the project on GitHub** ⭐

WebReinvent is a web agency based in Delhi, India. Explore all open-source projects on [GitHub](https://github.com/webreinvent).
