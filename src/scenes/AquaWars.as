/**
 * Created with IntelliJ IDEA.
 * User: gregorytkach
 * Date: 5/27/13
 * Time: 7:10 PM
 * To change this template use File | Settings | File Templates.
 */

package scenes
{

import GUI.Interface;
import GUI.Buttons.Pause;

import flash.display.Sprite;
import flash.events.Event;


import gameObjects.Houses.Base.HouseBase;

import models.Game.Singleplayer.GameSingleplayerScene;

import models.Game.Singleplayer.GameSingleplayer;
import models.GameInfo.GameInfo;
import models.Pathfinder.INode;
import models.Pathfinder.Node;
import models.ResourceManager.ResourceManager;

import scenes.views.BaseView;

[SWF(width="1000", height="800")]
public class AquaWars extends BaseView
{
    /*
     * Static fields
     */
    private static var _scene:AquaWars;

    public static var _interface: Interface;


    /*
     * Static methods
     */

    public static function get scene():AquaWars
    {
        return _scene;
    }


    /*
     * Fields
     */

    private var _background:Sprite;

    private var _game: GameSingleplayer;



    /*
     * Methods
     */
    public function AquaWars()
    {
        _scene = this;


        //_game = new GameSingleplayer();
        //addChild(_game.scene);


        _interface = new Interface();
        addChild(_interface);
    }



}
}