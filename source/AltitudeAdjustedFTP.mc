using Toybox.WatchUi as Ui;
using Toybox.Application as App;
using Toybox.Math;

class DataField extends Ui.SimpleDataField
{
    var userFtp;
    var curAlt;
    var curAltAdjFtp;

    //! Constructor
    function initialize()
    {
        Ui.SimpleDataField.initialize();

        label = "AltAdjFTP";
        userFtp = Application.getApp().getProperty("userFtp");
        curAlt = null;
        curAltAdjFtp = userFtp;
    }

    //! Handle the update event
    function compute(info)
    {
        var newAlt = info.altitude;
        if (curAlt != newAlt)
        {
            curAlt = newAlt;
            if (curAlt != null)
            {
                var alt_km = curAlt / 1000.0;
                // formula from http://alex-cycle.blogspot.de/2014/12/wm2-altitude-and-hour-record-part-ii.html
                curAltAdjFtp = (1 - 0.0092*alt_km*alt_km - 0.0323*alt_km) * userFtp;
                curAltAdjFtp = curAltAdjFtp.format("%.0f");
            }
            else
            {
                curAltAdjFtp = "__";
            }
        }
        return curAltAdjFtp + " W";
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
