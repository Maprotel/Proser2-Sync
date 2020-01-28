module.exports = function ( app ) {
  var router = app.loopback.Router();
  router.post( "/ping", function ( req, res ) {
    res.send( [ { 'text': 'pong' } ] );
  } );
  app.use( router );
};
