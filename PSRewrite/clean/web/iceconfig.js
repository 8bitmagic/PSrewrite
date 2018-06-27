//Main Settings
var iceSwitchID = '11001';
var imrFQDN = "imr.domain.com";
var imrWebApiPort = "8501";
var imrHttpsPort = "8301";
var iceAdminUseCitrix = false;
var iceAdminCitrixUrl = "";


// target duration in minutes
var TargetDuration = 2;
// duration/TargetDuration < WarningLevel => green
// duration/TargetDuration < AlertLevel => orange
// duration/TargetDuration > AlertLevel => red
var WarningLevel = 70;
var AlertLevel = 90;

//This is where customs can add any extra parameters for iceMonitor here!
//Note: Logs, and iceIMRService address should not be added here, iceMonitor gets these values from signalR instead.
var iceMonitorExtraParams = 'IdleTimeCheck=10,TileWidth=300,TileFontColor=#FF000000,TileBarHeight=20,BarTextAlign=Center,BarTextVisible=1,LED=0';

//This configures how logging to the server should act
//Silverlight will be passed these values on load
var logToServer = true;          //true - to send log message to iceLogger on IIS, false to disable it
var logToServerLevelJS = 1;      //Levels: LOG_ERROR = 1, LOG_INFO = 2, LOG_VERBOSE = 3, LOG_DEBUG = 4
var logToServerLevelMonitor = 2; //Levels: FATAL = 1, ERROR = 2, WARNING = 3, INFO = 4, VERBOSE = 5, DEBUG = 6
var logToServerURL = "LogCollector.aspx/LogMessage"; //URL of a restful method to send the logs to
var logToServerUsers = null;     //set null to log all users with the above level or add specific user ids in the list to only log specific users.
//var logToServerUsers = ["9999","10001"]; //example of 2 users that send logs to iceLogger

//This variable is to set iceMonitor to reload if we lost connection to either signalR to IIS or IIS to iceIMRService, or iceIMRService to ice server
//each one can result in missed events rendering the data not valid.
//we will unload monitor and restart it! (Only if this is set to true)
var restartMonitorConnectionFaults = true;

//Timeout value in seconds.
var webAPITimeout = 120;

//Server Locations
var iceIdentityServer = "https://" + imrFQDN + ":" + imrWebApiPort + "/identity";
var iceWebApiServer = "https://" + imrFQDN + ":" + imrWebApiPort + "/webapi";
var iceSignalRServer = "https://" + imrFQDN + ":" + imrWebApiPort + "/signalr/signalr";
var iceIMRServiceServer = "https://" + imrFQDN + ":" + imrHttpsPort + "/iceIMRService";

//We want to force websocket only for signalR transport.
var signalRWebSocketOnly = true;
var enableADFSLogin = false; //Enable this if customer want ADFS login

