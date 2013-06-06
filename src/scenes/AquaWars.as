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

import gameObjects.BaseView;
import gameObjects.House.EHouseType;
import gameObjects.House.House;

import models.GameConstants.GameConstants;

import models.ResourceManager.ResourceManager;


import models.SharedPathfinder.INode;
import models.SharedPathfinder.Node;
import models.SharedPathfinder.SharedPathfinder;
import models.SharedSoldierGenerator.SharedSoldierGenerator;

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
        graphics.beginFill(0x777777, 1);
        graphics.drawRect(0, 0, 800, 600);
        graphics.endFill();

        init();
    }

    private function init():void
    {
        initSingletones();

        if (GameConstants.SHOW_DEBUG_DATA)
        {
            showGrid();
        }

        initHouses();
    }

    private static function initSingletones():void
    {
        var pathFinder:SharedPathfinder = SharedPathfinder.Instance;
        var soldierGenerator:SharedSoldierGenerator = SharedSoldierGenerator.Instance;

    }

    private function showGrid():void
    {
        var startX:int = 0;
        var startY:int = 400;

        var grid:Array = SharedPathfinder.Instance.grid;

        var firstNode:INode = (SharedPathfinder.Instance.grid[0] as Array)[0] as INode;

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

                addChild(node as BaseView);
            }
        }
    }

    private function initHouses():void
    {
        var _house1:House = House.HouseWithType(EHouseType.EHT_PLAYER, 10);

        _house1.setPosition(10, 5);

        addChild(_house1.view);

        var _house2:House = House.HouseWithType(EHouseType.EHT_ENEMY, 9);

        _house2.setPosition(15, 40);

        addChild(_house2.view);

        var _house3:House = House.HouseWithType(EHouseType.EHT_PLAYER, 9);

        _house3.setPosition(3, 10);

        addChild(_house3.view);

        var _house4:House = House.HouseWithType(EHouseType.EHT_ENEMY, 9);

        _house4.setPosition(45, 25);

        addChild(_house4.view);
    }

    private function DrawPath(nodes:Array):void
    {
        GameUtils.assert(nodes != null && nodes.length > 0);

        for (var i:int = 0; i < nodes.length; ++i)
        {
            var n:Node = nodes[i];
            n.highlight(0xFFFF00);
        }
    }


}
}