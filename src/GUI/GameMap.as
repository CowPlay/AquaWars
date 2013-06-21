/**
 * Created with IntelliJ IDEA.
 * User: developer
 * Date: 6/19/13
 * Time: 1:47 PM
 * To change this template use File | Settings | File Templates.
 */
package GUI {
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import models.Game.Singleplayer.GameSingleplayer;
import models.GameInfo.GameInfo;

import models.ResourceManager.ResourceManagerGUI;

import scenes.AquaWars;

public class GameMap extends Sprite
{
    private var _pointerList: Array;

    public function GameMap():void
    {
        _pointerList = [new ResourceManagerGUI.mapPointerClass()];
        _pointerList[0].x = 65.05;
        _pointerList[0].y = 519.70;
        addChild(_pointerList[0]);
        _pointerList[0].stop();
        _pointerList[0].addEventListener(MouseEvent.CLICK, enterToTheGame);
    }


    private function enterToTheGame(e: Event):void
    {
        _pointerList[0].removeEventListener(MouseEvent.CLICK, enterToTheGame);
        AquaWars._interface.container.removeChild(this);
        var singlePlayer: GameSingleplayer = new GameSingleplayer();
        GameInfo.Instance.setCurrentGame(singlePlayer);
        AquaWars._interface.container.addChild(singlePlayer.scene);
    }
}
}
