/**
 * Created with IntelliJ IDEA.
 * User: developer
 * Date: 5/29/13
 * Time: 4:17 PM
 * To change this template use File | Settings | File Templates.
 */
package gameObjects.House
{
import flash.events.TimerEvent;
import flash.utils.Timer;

import gameObjects.*;
import gameObjects.House.EHouseType;
import gameObjects.Soldier.Soldier;

import models.SharedPathfinder.INode;
import models.SharedPathfinder.Node;
import models.SharedPathfinder.SharedPathfinder;

import models.SharedSoldierGenerator.SharedSoldierGenerator;

import flash.events.Event;

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
    private var _soldierCountMax:int;

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
    public function get soldierCount():int
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

        _view.update();
    }

    public function get readyToUpdate():Boolean
    {
        return ((_level < _levelMax) && (_soldierCount == _soldierCountMax));
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
        if (BaseView.viewHovered != null
                && BaseView.viewSelected != null
                && BaseView.viewSelected != BaseView.viewHovered
                && BaseView.viewHovered is HouseView
                && BaseView.viewSelected is HouseView)
        {
            var houseViewSelected:HouseView = BaseView.viewSelected as HouseView;
            var houseViewHovered:HouseView = BaseView.viewHovered as HouseView;

            SharedSoldierGenerator.Instance.generateSoldiers(houseViewSelected.Owner, houseViewHovered.Owner);
        }
    }

    public function setPosition(row:int, column:int):void
    {
        GameUtils.assert(row >= 0 && column >= 0);

        _currentPosition = SharedPathfinder.Instance.getNode(row, column);
        _houseExitPosition = initHouseExitPosition();

        this.square = InitSquare();

        _view.update();
    }

    //TODO: implement for all house types and levels
    //TODO: move to GameConfiguration
    private function initHouseExitPosition():INode
    {
        var result:INode = null;

        if (_type == EHouseType.EHT_PLAYER)
        {
            result = SharedPathfinder.Instance.getNode(_currentPosition.row + 3, _currentPosition.column + 2);
        }
        else if (_type == EHouseType.EHT_ENEMY)
        {
            result = SharedPathfinder.Instance.getNode(_currentPosition.row + 2, _currentPosition.column - 1);
        }

        return result;
    }

    //! Returns square of specify house
    //TODO: implement all house types  and levels
    //TODO: move to GameConfiguration
    private function InitSquare():Array
    {
        var result:Array = [];

        for (var currentRow:int = _currentPosition.row; currentRow < _currentPosition.row + 4; currentRow++)
        {
            for (var currentColumn:int = _currentPosition.column; currentColumn < _currentPosition.column + 4; currentColumn++)
            {
                var fundamentalNode:INode = SharedPathfinder.Instance.getNode(currentRow, currentColumn);
                result.push(fundamentalNode);
            }
        }

        return result;
    }

    public function didAttack(damageCauser:Soldier):void
    {
        setSoldierCount(this.soldierCount - damageCauser.damage);

        _view.didAttack();
    }


}
}
