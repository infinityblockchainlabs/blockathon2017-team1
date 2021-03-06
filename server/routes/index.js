'use strict';
var express = require('express');
var constant = require('../const/siteconst');
var router = express.Router();
var models  = require('../models');

const Op = models.Sequelize.Op;

module.exports = function () {

  router.get('/homes', function(req, res) {
    models.Home.findAll({
      where: {
        [Op.or]: [
          { name: { [Op.like]: '%' + req.query.keyword + '%' } },
          { description: { [Op.like]: '%' + req.query.keyword + '%' } },
          { streetAddress: { [Op.like]: '%' + req.query.keyword + '%' } }
        ]
      }
    }).then(function(homes) {
      res.send(homes)
    });
  });

  router.get('/homes/:address/booking', function(req, res) {
    models.HomeBooking.findAll({
      where: {
        contractAddress: req.params.address
      }
    }).then(function(bookings) {
      res.send(bookings)
    });
  });

  router.get('/homes/:address', function(req, res) {
    models.Home.findOne({
      where: {
        contractAddress: req.params.address
      }
    }).then(function(home) {
      res.send(home)
    });
  });

  router.get('/owners/:address/homes', function(req, res) {
    models.Home.findAll({
      where: {
        owner: req.params.address
      }
    }).then(function(homes) {
      res.send(homes)
    });
  });

  module.exports = router;
  return router;
};
