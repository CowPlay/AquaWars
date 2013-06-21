/**
 * Created with IntelliJ IDEA.
 * User: developer
 * Date: 6/20/13
 * Time: 11:31 AM
 * To change this template use File | Settings | File Templates.
 */
package models.ResourceManager {
import flash.net.registerClassAlias;

public class ResourceManagerGUI
{
    /*
     * interface panels
     */

    [Embed(source="../../../assets/GUi.swf", symbol="top_panel")]
    private static var _topPanel:Class;

    [Embed(source="../../../assets/GUi.swf", symbol="bottom_panel")]
    private static var _bottomPanel:Class;


    /*
     * interface elements
     */

    //!   fullScreen
    [Embed(source="../../../assets/GUi.swf", symbol="fullscreen")]
    private static var _fullScreen:Class;

    //!music
    [Embed(source="../../../assets/GUi.swf", symbol="music")]
    private static var _music:Class;

    //!  photo
    [Embed(source="../../../assets/GUi.swf", symbol="Photo")]
    private static var _photo:Class;

    //!  sound
    [Embed(source="../../../assets/GUi.swf", symbol="sound")]
    private static var _sound:Class;

    /*
     * Village
     */

    [Embed(source="../../../assets/GUi.swf", symbol="B_map_")]
    private static var _buttonMapClass:Class;

    [Embed(source="../../../assets/GUi.swf", symbol="action_bar")]
    private static var _actionBar:Class;


    /*
     * Choice World
     */

    [Embed(source="../../../assets/GUi.swf", symbol="swich_arrow")]
    private static var _arrowSwitch:Class;

    [Embed(source="../../../assets/GUi.swf", symbol="logo_map_1")]
    private static var _logoMap1:Class;

    [Embed(source="../../../assets/GUi.swf", symbol="logo_map_2")]
    private static var _logoMap2:Class;

    [Embed(source="../../../assets/GUi.swf", symbol="logo_map_3")]
    private static var _logoMap3:Class;


    /*
     *  GameMap
     */

    [Embed(source="../../../assets/GUi.swf", symbol="map_point")]
    private static var _mapPointer:Class;



    /*
     * Methods
     */


    /*
     * Interface
     */
    public static function get topPanelClass():Class
    {
        return _topPanel;
    }


    public static function get bottomPanelClass():Class
    {
        return _bottomPanel;
    }


    public static function get fullScreenClass():Class
    {
        return _fullScreen;
    }


    public static function get musicClass():Class
    {
        return _music;
    }


    public static function get photoClass():Class
    {
        return _photo;
    }


    public static function get soundClass():Class
    {
        return _sound;
    }


    /*
     * Village
     */
    public static function get actionBarClass():Class
    {
        return _actionBar;
    }

    public static function get buttonMapClass():Class
    {
        return _buttonMapClass;
    }



    /*
     * Choice World
     */


    public static function get arrowSwitchClass():Class
    {
        return _arrowSwitch;
    }


    public static function getWorldMapBayNumber(numb: int):Class
    {
        var result: Class;
        switch (numb)
        {
            case 1:
            {
               result = _logoMap1;
                break;
            }
            case 2:
            {
                result = _logoMap2;
                break;
            }
            case 3:
            {
                result = _logoMap3;
                break;
            }
        }
        return result
    }


    /*
     * Game Map
     */

    public static function get mapPointerClass():Class
    {
        return _mapPointer;
    }



}
}
