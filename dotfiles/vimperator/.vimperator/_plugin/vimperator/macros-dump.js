// Vimperator plugin: 'Macros Dump'
// Last Change: 20. Jan 2008
// License: GPL
// Version: 0.4
// Maintainer: marco candrian <mac@calmar.ws>
//
// This plugin stores/deletes recorded macros into ~/.vimperator/macro/
// May only those matching the optional argument.
// It will overwrite alraedy existing macros.
//
// USAGE: :macrosdump [regex]    //no filter -> dump all
//        :delmacrodump regex
//
// Tested with vimperator 0.6pre from 2008-03-24
// (won't work with older versions)
//
// INSTALL: put this file into ~/.vimperator/plugin/  (create folders if necessary)
// and restart firefox or :source this file

// plugin-setup
liberator.plugins.macros_dump = {};

//<<<<<<<<<<<<<<<< EDIT USER SETTINGS HERE
//
// no User Settings
//
//========================================

liberator.plugins.macros_dump.dump = function (filter)
{
    var macroRef = liberator.events.getMacros(filter);
    try
    {
        // TODO: may don't overwrite existing macros
        // TODO: some might are stored with .vimp extension...

        var macroDir = liberator.io.getSpecialDirectory("macros").path;

        for (var item in macroRef)
        {
            liberator.io.writeFile(macroDir + "/" + item, macroRef[item], ">");
        }
    }
    catch (e)
    {
        alert("Error on macrosdump: " + e);
        liberator.log("macro directory not found or error reading/writing macro file(s)");
    }
}

liberator.plugins.macros_dump.del = function (filter)
{
    if (!filter)
    {
        liberator.echoerr("delmacrosdump needs a regular expression as an argument");
        return;
    }

    var macroRef = liberator.events.getMacros(filter);
    try
    {
        var macroDir = liberator.io.getSpecialDirectory("macros").path;
        var file = Components.classes["@mozilla.org/file/local;1"].
            createInstance(Components.interfaces.nsILocalFile);

        for (var item in macroRef)
        {
            try
            {
                file.initWithPath(macroDir + "/" + item)
                if (file.isFile())
                    file.remove(false);
            }
            catch (e)
            {
                alert("Error on delmacrosdump: " + e);
                liberator.log("Error on delmacrosdump: " + e);
            }
        }
        liberator.events.deleteMacros(filter)
    }
    catch (e)
    {
        alert("Error on macrosdumpdel init: " + e);
        liberator.log("Error on delmacrosdump init: " + e);
    }
}

//<<<<<<<<<<<<<<< registering/setting up this plugin

liberator.commands.add(["macrosdump"],
    "Dump (store) macros",
    function (arg) { liberator.plugins.macros_dump.dump(arg); });

liberator.commands.add(["delmacrosdump"],
    "Delete macros matching a regex",
    function (arg) { liberator.plugins.macros_dump.del(arg); });

// vim: set fdm=marker sw=4 ts=4 et:
