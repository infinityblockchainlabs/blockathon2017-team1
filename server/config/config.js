module.exports = {
  "development": {
    "username": null,
    "password": null,
    "database": "c2cdev",
    "host": "127.0.0.1",
    "dialect": "postgres"
  },
  "test": {
    "username": null,
    "password": null,
    "database": "c2ctest",
    "host": "127.0.0.1",
    "dialect": "postgres"
  },
  "production": {
    username: process.env.PROD_DB_USERNAME,
    password: process.env.PROD_DB_PASSWORD,
    database: process.env.PROD_DB_NAME,
    host: process.env.PROD_DB_HOSTNAME,
    "dialect": "postgres"
  }
};
