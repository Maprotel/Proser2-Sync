"use strict";

import * as displayInboundIndicators from "../queries/InvDisplay/displayInbound/displayInboundIndicators";
import * as displayInboundDailyByInterval from "../queries/InvDisplay/displayInbound/displayInboundDailyByInterval";
import * as displayAgentsIndicators from "../queries/InvDisplay/displayAgents/displayAgentsIndicators";
import * as displayAutomaticIndicators from "../queries/InvDisplay/displayAutomatic/displayAutomaticIndicators";
import * as displayOutboundIndicators from "../queries/InvDisplay/displayOutbound/displayOutboundIndicators";
import * as displayShow from "../queries/InvDisplay/displayInbound/displayShow";

//MONITOR
import * as displayMonitorByCalls from "../queries/InvDisplay/displayInbound/displayMonitorByCalls";
import * as displayMonitorByAgents from "../queries/InvDisplay/displayInbound/displayMonitorByAgents";
import * as displayMonitorByIndicators from "../queries/InvDisplay/displayInbound/displayMonitorByIndicators";

import * as displayMonitorByIndicatorsHistoric from "../queries/InvDisplay/displayInbound/displayMonitorByIndicatorsHistoric";


module.exports = function ( InvDisplay ) {

  //**********************INBOUND INDICATORS**********************/

  InvDisplay.displayInboundIndicators = async function ( userSelection ) {
    return displayInboundIndicators.displayInboundIndicators( userSelection );
  };

  InvDisplay.remoteMethod( "displayInboundIndicators", {
    accepts: {
      arg: "userSelection",
      type: "UserSelection",
      http: { source: "body" }
    },
    returns: { type: "array", root: "true" },
    description: [ "List of abandoned calls" ]
  } );


  //**********************AGENTS INDICATORS**********************/

  InvDisplay.displayAgentsIndicators = async function ( userSelection ) {
    return displayAgentsIndicators.displayAgentsIndicators( userSelection );
  };

  InvDisplay.remoteMethod( "displayAgentsIndicators", {
    accepts: {
      arg: "userSelection",
      type: "UserSelection",
      http: { source: "body" }
    },
    returns: { type: "array", root: "true" },
    description: [ "List of abandoned calls" ]
  } );

  //**********************AUTOMATIC INDICATORS**********************/

  InvDisplay.displayAutomaticIndicators = async function ( userSelection ) {
    return displayAutomaticIndicators.displayAutomaticIndicators( userSelection );
  };

  InvDisplay.remoteMethod( "displayAutomaticIndicators", {
    accepts: {
      arg: "userSelection",
      type: "UserSelection",
      http: { source: "body" }
    },
    returns: { type: "array", root: "true" },
    description: [ "List of abandoned calls" ]
  } );

  //**********************OUTBOUND INDICATORS**********************/

  InvDisplay.displayOutboundIndicators = async function ( userSelection ) {
    return displayOutboundIndicators.displayOutboundIndicators( userSelection );
  };

  InvDisplay.remoteMethod( "displayOutboundIndicators", {
    accepts: {
      arg: "userSelection",
      type: "UserSelection",
      http: { source: "body" }
    },
    returns: { type: "array", root: "true" },
    description: [ "List of abandoned calls" ]
  } );

  //**********************INBOUND INTERVALS **********************/

  InvDisplay.displayInboundDailyByIntervalReport = async function (
    userSelection
  ) {
    return displayInboundDailyByInterval.displayInboundDailyByIntervalReport(
      userSelection
    );
  };

  InvDisplay.remoteMethod( "displayInboundDailyByIntervalReport", {
    accepts: {
      arg: "userSelection",
      type: "UserSelection",
      http: { source: "body" }
    },
    returns: { type: "array", root: "true" },
    description: [ "List of abandoned calls" ]
  } );

  //**********************INBOUND INTERVALS **********************/

  InvDisplay.displayShow = async function ( userSelection ) {
    return displayShow.displayShow( userSelection );
  };

  InvDisplay.remoteMethod( "displayShow", {
    accepts: {
      arg: "userSelection",
      type: "userSelection",
      http: { source: "body" }
    },
    returns: { type: "array", root: "true" },
    description: [ "List of abandoned calls" ]
  } );

  //**********************QUEUE BY CALLS**********************/

  InvDisplay.displayMonitorByCalls = async function (
    userSelection
  ) {
    return displayMonitorByCalls.displayMonitorByCalls(
      userSelection
    );
  };

  InvDisplay.remoteMethod( "displayMonitorByCalls", {
    accepts: {
      arg: "userSelection",
      type: "UserSelection",
      http: { source: "body" }
    },
    returns: { type: "array", root: "true" },
    description: [ "List of abandoned calls" ]
  } );

  //**********************QUEUE MONITOR BY AGENTS**********************/

  InvDisplay.displayMonitorByAgents = async function (
    userSelection
  ) {
    return displayMonitorByAgents.displayMonitorByAgents(
      userSelection
    );
  };

  InvDisplay.remoteMethod( "displayMonitorByAgents", {
    accepts: {
      arg: "userSelection",
      type: "UserSelection",
      http: { source: "body" }
    },
    returns: { type: "array", root: "true" },
    description: [ "List of abandoned calls" ]
  } );

  //**********************QUEUE MONITOR BY INDICATORS**********************/

  InvDisplay.displayMonitorByIndicators = async function (
    userSelection
  ) {
    return displayMonitorByIndicators.displayMonitorByIndicators(
      userSelection
    );
  };

  InvDisplay.remoteMethod( "displayMonitorByIndicators", {
    accepts: {
      arg: "userSelection",
      type: "UserSelection",
      http: { source: "body" }
    },
    returns: { type: "array", root: "true" },
    description: [ "List of abandoned calls" ]
  } );


  //**********************QUEUE MONITOR BY INDICATORS HISTORIC**********************/

  InvDisplay.displayMonitorByIndicatorsHistoric = async function (
    userSelection
  ) {
    return displayMonitorByIndicatorsHistoric.displayMonitorByIndicatorsHistoric(
      userSelection
    );
  };

  InvDisplay.remoteMethod( "displayMonitorByIndicatorsHistoric", {
    accepts: {
      arg: "userSelection",
      type: "UserSelection",
      http: { source: "body" }
    },
    returns: { type: "array", root: "true" },
    description: [ "List of abandoned calls" ]
  } );

};
