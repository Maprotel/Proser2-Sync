"use strict";

import * as userSelectionChange from "../queries/ProShowDisplay/userSelectionChange";

module.exports = function ( ProShowDisplay ) {
  ProShowDisplay.userSelectionChange = async function () {
    return userSelectionChange.userSelectionChange();
  };

  ProShowDisplay.remoteMethod( "userSelectionChange", {
    accepts: {
      arg: "",
      type: "any",
      http: { source: "body" }
    },
    returns: { type: "array", root: "true" },
    description: [ "Returns values of breaks for each selected agent" ]
  } );
};