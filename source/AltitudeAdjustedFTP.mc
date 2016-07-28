using Toybox.WatchUi as Ui;
using Toybox.Application as App;
using Toybox.System as Sys;
using Toybox.Time as Time;
using Toybox.Position as Position;

class DataField extends Ui.SimpleDataField
{
    var userFtp;

    //! Constructor
    function initialize()
    {
        Ui.SimpleDataField.initialize();

        label = "AltAdjFTP";
        //userFtp = Application.getApp().getProperty("userFtp");
        userFtp = 325;
    }

    //! Handle the update event
    function compute(info)
    {
        var alt_km = info.altitude / 1000.0;
        // formula from http://alex-cycle.blogspot.de/2014/12/wm2-altitude-and-hour-record-part-ii.html
        return (1 - 0.0092*alt_km*alt_km - 0.0323*alt_km) * userFtp;
    }
}

//! main is the primary start point for a Monkeybrains application
class AltitudeAdjustedFTP extends App.AppBase
{
    function initialize()
    {
        App.AppBase.initialize();
    }

    function onStart()
    {
        return false;
    }

    function getInitialView()
    {
        return [new DataField()];
    }

    function onStop()
    {
        return false;
    }
}
