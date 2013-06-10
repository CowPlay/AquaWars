/**
 * Created with IntelliJ IDEA.
 * User: developer
 * Date: 5/29/13
 * Time: 4:17 PM
 * To change this template use File | Settings | File Templates.
 */
package gameObjects.House
{
import flash.events.Event;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.Timer;

import gameObjects.*;
import gameObjects.Soldier.Soldier;

import models.GameInfo.GameInfo;
import models.Pathfinder.INode;
import models.StaticGameConfiguration.StaticGameConfiguration;

//! Represents model of House
public class House implements IDisposable
{
    /*
     * Static fields
     */

    /*
     * Static functions
     */

    private static var _selectedHouses:Array = [];

    public static function get selectedHouses():Array
    {
        return _selectedHouses;
    }

    public static function clearHouseSelection():void
    {
        for each(var house:House in _selectedHouses)
        {
            house._view.didHouseSelectionChanged(false);

            trace("clear selection");
        }

        _selectedHouses = [];
    }

    public static function selectHouse(value:House):void
    {
        GameUtils.assert(value != null);

        if (_selectedHouses.indexOf(value) == -1)
        {
            _selectedHouses.push(value);

            trace("select house");
        }
    }

    /*
     * Fields
     */
    //! Represents house type
    private var _type:EHouseType;
    private var _level:uint;
    private var _levelMax:uint;

    private var _view:HouseView;

    //! Use Get\SetSoldierCount
    private var _soldierCount:int;
    private var _soldierCountMax:uint;

    private var _currentPosition:INode;
    private var _houseExitPosition:INode;
    private var _square:Array;

    private var _timerSoldierGenerator:Timer;


    /*
     * Properties
     */
    //! Returns house view
    public function get view():HouseView
    {
        return _view;
    }

    //! Returns soldiers count
    public function get soldierCount():uint
    {
        return _soldierCount;
    }

    private function setSoldierCount(value:uint):void
    {
        if (_soldierCount != value)
        {
            _soldierCount = value;
            _view.update();
        }
    }

    public function get soldierCountMax():int
    {
        return _soldierCountMax;
    }

    public function get type():EHouseType
    {
        return  _type;
    }

    //! Set house type
    private function setType(type:EHouseType):void
    {
        if (_type == type)
        {
            return;
        }

        _type = type;

        _levelMax = StaticGameConfiguration.getLevelMax(_type);

        //TODO: update square
        //TODO: update exit position

        _view.update();
    }

    public function get level():uint
    {
        return _level;
    }

    public function set level(value:uint):void
    {
        if (_level == value)
        {
            return;
        }

        _soldierCountMax = value * 25;

        _soldierCount = _soldierCount - Math.round(_level * 25 / 2);

        _level = value;

        //TODO: update square
        //TODO: update exit position

        _view.update();
    }

    public function get readyToUpdate():Boolean
    {
        return ((_level < _levelMax) && (_soldierCount >= _soldierCountMax));
    }

    public function get currentPosition():INode
    {
        return _currentPosition;
    }

    public function get houseExitPosition():INode
    {
        return _houseExitPosition;
    }

    private function set square(value:Array):void
    {
        if (_square == value)
        {
            return;
        }

        var node:INode = null;

        if (_square)
        {
            for each(node in _square)
            {
                node.traversable = true;
            }
        }

        _square = value;

        if (_square)
        {
            for each(node in _square)
            {
                node.traversable = false;
            }
        }
    }

    public function getSquare():Array
    {
        return _square;
    }


    /*
     * Methods
     */

    //! Return new instance of House with soldiers.
    public static function HouseWithType(type:EHouseType, soldiersCount:int):House
    {
        var result:House = new House();

        result.setSoldierCount(soldiersCount);

        result.setType(type);

        return result;
    }

    //! Default constructor for neutral house
    public function House()
    {
        _view = new HouseView(this);

        this.setType(EHouseType.EHT_NEUTRAL);

        _level = 1;

        _soldierCountMax = 25;

        _timerSoldierGenerator = new Timer(1000);
        _timerSoldierGenerator.addEventListener(TimerEvent.TIMER, incrementSoldierCount);
        _timerSoldierGenerator.start();
    }

    private function incrementSoldierCount(e:Event):void
    {
        if (_soldierCount < _soldierCountMax)
        {
            this.setSoldierCount(this.soldierCount + 1);
        }
        else if (_soldierCount > _soldierCountMax)
        {
            this.setSoldierCount(this.soldierCount - 1);
        }
    }

    public function didLevelUp():void
    {
        GameUtils.assert(this.readyToUpdate);

        this.level++;
    }

    public function cleanup():void
    {
        super.cleanup();
    }

    //! Must call when MOUSE_UP event was fire.
    public function didMouseUp():void
    {
        if (_selectedHouses.length == 0)
            return;

        if (BaseView.viewHovered != null
                && BaseView.viewSelected != null
                && BaseView.viewHovered is HouseView
                && BaseView.viewSelected is HouseView)
        {
            var houseHovered:House = (BaseView.viewHovered as HouseView).Owner;

            //generate from all selected houses
            for each(var houseSelected:House in _selectedHouses)
            {
                if (houseHovered == houseSelected)
                    continue;

                GameInfo.Instance.soldierGenerator.generateSoldiers(houseSelected, houseHovered);
            }
        }

        clearHouseSelection();
    }

    public function setPosition(column:int, row:int):void
    {
        GameUtils.assert(row >= 0 && column >= 0);

        _currentPosition = GameInfo.Instance.pathfinder.getNode(column, row);

        updateHouseExitPosition();

        updateSquare();

        _view.update();
    }

    private function updateHouseExitPosition():void
    {
        var houseExitPositionOffset:Point = StaticGameConfiguration.getHouseExitPosition(_type, _level);
        var squareFrame:Rectangle = StaticGameConfiguration.getHouseSquare(_type, _level);

        _houseExitPosition = GameInfo.Instance.pathfinder.getNode(_currentPosition.column + squareFrame.x + houseExitPositionOffset.x,
                _currentPosition.row + squareFrame.y + houseExitPositionOffset.y);
    }

    //! Returns square of specify house
    private function updateSquare():void
    {
        var squareFrame:Rectangle = StaticGameConfiguration.getHouseSquare(_type, _level);

        var squareValue:Array = [];

        for (var currentRow:int = _currentPosition.row + squareFrame.y; currentRow < _currentPosition.row + squareFrame.height + squareFrame.y; currentRow++)
        {
            for (var currentColumn:int = _currentPosition.column + squareFrame.x; currentColumn < _currentPosition.column + squareFrame.width + squareFrame.x; currentColumn++)
            {
                var fundamentalNode:INode = GameInfo.Instance.pathfinder.getNode(currentColumn, currentRow);
                squareValue.push(fundamentalNode);
            }
        }

        this.square = squareValue;
    }

    public function didReceiveSoldier(soldier:Soldier):void
    {
        var damage:int = soldier.type == this.type ? soldier.damage : -soldier.damage;

        setSoldierCount(_soldierCount + damage);

        if (_soldierCount <= 0)
        {
            //change type
            setType(soldier.type);
        }

        _view.didAttackOrHeal(damage);
    }

    //TODO: add count parameter
    public function didSoldierGenerate():void
    {
        setSoldierCount(_soldierCount - 1);
    }



}
}
