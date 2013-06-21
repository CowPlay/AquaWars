/**
 * Created with IntelliJ IDEA.
 * User: developer
 * Date: 6/19/13
 * Time: 1:48 PM
 * To change this template use File | Settings | File Templates.
 */
package models.Game.Singleplayer {
import GUI.Buttons.Pause;

import flash.display.Sprite;
import flash.events.Event;


import gameObjects.Houses.Base.HouseBase;

import models.Game.Singleplayer.GameSingleplayer;
import models.GameInfo.GameInfo;
import models.Pathfinder.INode;
import models.Pathfinder.Node;
import models.ResourceManager.ResourceManager;

import scenes.AquaWars;

import scenes.views.BaseView;

public class GameSingleplayerScene extends BaseView{


    /*
     * Fields
     */
    private static var _arrowContainer: Sprite;
    private var _houseContainer: Sprite;
    private var _backGround: Sprite;

    /*
     * Properties
     */
    public function get arrowContainer():Sprite
    {
        return _arrowContainer;
    }


    public function GameSingleplayerScene()
    {
        var backgroundClass:Class = ResourceManager.getSceneBackground();

        _backGround = new backgroundClass();

        addChild(_backGround);

        this.eventHandler = _backGround;
        mouseChildren = true;


        initContainers();
        initPauseGUI();
        initGrid();
        AquaWars.scene.stage.addEventListener(Event.MOUSE_LEAVE, mouseLeave);
    }

    public function initHouses():void
    {
        GameInfo.Instance.houseManager.initLevelHouses();

        for each(var house:HouseBase in GameInfo.Instance.houseManager.houses)
        {
            _houseContainer.addChild(house.view);
        }

        GameInfo.Instance.pathfinder.generateLevelPaths();
    }

    private function initPauseGUI():void
    {
        var pause: Pause = new Pause();
        pause.x = 50;
        pause.y = 620;
        addChild(pause);
    }

    private function initGrid():void
    {
        var startX:int = 0;
        var startY:int = 400;

        var grid:Array = GameInfo.Instance.pathfinder.grid;

        var firstNode:INode = (GameInfo.Instance.pathfinder.grid[0] as Array)[0] as INode;

        for (var currentRow:int = 0; currentRow < grid.length; currentRow++)
        {
            startX += Node.NodeWidthHalf;
            startY += Node.NodeHeightHalf;

            var row:Array = grid[currentRow] as Array;

            for (var currentColumn:int = 0; currentColumn < row.length; currentColumn++)
            {
                var node:INode = row[currentColumn];

                node.view.x = startX + currentColumn * Node.NodeWidthHalf;
                node.view.y = startY - currentColumn * Node.NodeHeightHalf;

                addChild(node.view);
            }
        }
    }

    private function initContainers():void
    {
        _arrowContainer = new Sprite();
        _houseContainer = new Sprite();
        addChild(_arrowContainer);
        addChild(_houseContainer);
    }


    private function mouseLeave(e:Event):void
    {
        BaseView.didMouseLeave();
    }


}
}
