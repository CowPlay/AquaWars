/**
 * Created with IntelliJ IDEA.
 * User: gregorytkach
 * Date: 5/27/13
 * Time: 7:10 PM
 * To change this template use File | Settings | File Templates.
 */

package scenes
{

import flash.display.Bitmap;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;

import gameObjects.BaseView;
import gameObjects.House.EHouseType;
import gameObjects.House.House;

import models.GameConstants.GameConstants;
import models.GameInfo.GameInfo;

import models.ResourceManager.ResourceManager;


import models.Pathfinder.INode;
import models.Pathfinder.Node;
import models.Pathfinder.Pathfinder;
import models.SoldierGenerator.SoldierGenerator;

import mx.resources.ResourceBundle;


[SWF(width="1000", height="650")]
public class AquaWars extends BaseView
{
    /*
     * Static fields
     */
    private static var _scene:AquaWars;


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

    /*
     * Methods
     */
    public function AquaWars()
    {

        _scene = this;


        var backgroundClass:Class = ResourceManager.getSceneBackground();

        _background = new backgroundClass();

        addChild(_background);

        this.eventHandler = _background;
        mouseChildren = true;

        init();
    }

    private function init():void
    {
        stage.addEventListener(Event.MOUSE_LEAVE, mouseLeave);

        initGrid();

        GameInfo.Instance.houseManager.initLevelHouses();

        for each(var house:House in GameInfo.Instance.houseManager.houses)
        {
            AquaWars.scene.addChild(house.view);
        }

        GameInfo.Instance.pathfinder.generateLevelPaths();
    }

    private function mouseLeave(e: Event):void
    {
        BaseView.didMouseLeave();
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
}
}