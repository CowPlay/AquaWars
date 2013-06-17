/**
 * Created with IntelliJ IDEA.
 * User: gregorytkach
 * Date: 6/17/13
 * Time: 1:02 PM
 * To change this template use File | Settings | File Templates.
 */
package gameObjects.Houses.Base
{
import flash.geom.Point;
import flash.geom.Rectangle;

import gameObjects.IDisposable;
import gameObjects.Soldier.Soldier;

import models.GameConfiguration.House.GameConfigurationHouseExitPosition;
import models.GameConfiguration.House.GameConfigurationHouseFoundation;
import models.GameConfiguration.House.GameConfigurationHouseLevel;
import models.GameConfiguration.Soldier.GameConfigurationSoldierDamage;
import models.GameConstants.GameConstants;
import models.GameInfo.GameInfo;
import models.Pathfinder.INode;

import scenes.game.views.Houses.HouseBaseView;
import scenes.views.BaseView;

//! Base class of all house types
public class HouseBase implements IDisposable
{

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
        for each(var house:HouseBase in _selectedHouses)
        {
            if (house._ownerType != EHouseOwner.EHO_PLAYER)
                continue;

            house._view.didHousePlayerSelectionChanged(false);

            trace("clear selection");
        }

        _selectedHouses = [];
    }

    public static function selectHousePlayer(value:HouseBase):void
    {
        Debug.assert(value != null);

        if (!value.isSelect)
        {
            _selectedHouses.push(value);

            trace("select house");
        }

        //force update view
        value._view.didHousePlayerSelectionChanged(true);
    }

    /*
     * Fields
     */

    protected var _view:HouseBaseView;

    //! Represents house owner type
    protected var _ownerType:EHouseOwner;

    protected var _level:uint;
    protected var _levelMax:uint;

    //! Use Get\SetSoldierCount
    protected var _soldierCount:Number;
    protected var _soldierCountMax:uint;

    protected var _currentPosition:INode;
    protected var _houseExitPosition:INode;
    protected var _foundation:Array;

    /*
     *  Properties
     */

    public function get isSelect():Boolean
    {
        return HouseBase.selectedHouses.indexOf(this) != GameConstants.INDEX_NONE;
    }

    //! Returns house view
    public function get view():HouseBaseView
    {
        return _view;
    }

    public function get type():EHouseType
    {
        Debug.assert(false);
        return null;
    }

    //! Returns soldiers count
    public function get soldierCount():Number
    {
        return _soldierCount;
    }

    protected function setSoldierCount(value:Number):void
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

    public function get ownerType():EHouseOwner
    {
        return  _ownerType;
    }

    //! Set house owner type
    protected function setOwnerType(type:EHouseOwner):void
    {
        if (_ownerType == type)
        {
            return;
        }

        _ownerType = type;

        _levelMax = GameConfigurationHouseLevel.getLevelMax(this);

        //TODO: update foundation
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

        //TODO: move to game config
        _soldierCountMax = value * 25;

        _soldierCount = _soldierCount - Math.round(_level * 25 / 2);

        _level = value;

        //TODO: update square
        //TODO: update exit position

        _view.update();
    }

    public function setPosition(column:int, row:int):void
    {
        Debug.assert(row >= 0 && column >= 0);

        _currentPosition = GameInfo.Instance.pathfinder.getNode(column, row);

        updateHouseExitPosition();

        updateFoundation();

        _view.update();
    }


    public function get currentPosition():INode
    {
        return _currentPosition;
    }

    public function get houseExitPosition():INode
    {
        return _houseExitPosition;
    }


    public function get foundation():Array
    {
        return _foundation;
    }

    private function setFoundation(value:Array):void
    {
        Debug.assert(value != null);

        if (_foundation == value)
        {
            return;
        }

        var node:INode = null;

        if (_foundation)
        {
            for each(node in _foundation)
            {
                node.traversable = true;
            }
        }

        _foundation = value;

        if (_foundation)
        {
            for each(node in _foundation)
            {
                node.traversable = false;
            }
        }
    }

    public function get readyToUpdate():Boolean
    {
        return ((_level < _levelMax) && (_soldierCount >= _soldierCountMax));
    }

    /*
     * Events
     */

    public function didLevelUp():void
    {
        Debug.assert(this.readyToUpdate);

        this.level++;
    }

    public function didSoldierComeHouse(soldier:Soldier):void
    {
        //review formula for calculate damage
        //TODO: review
        var damage:Number = soldier.type == this.ownerType ? 1 : -soldier.damage / GameConfigurationSoldierDamage.getNormalSoldierDamage(_ownerType);

        setSoldierCount(_soldierCount + damage);

        if (_soldierCount <= 0)
        {
            setSoldierCount(0);
            setOwnerType(soldier.type);
        }

        _view.didAttackOrHeal(damage);
    }

    //TODO: add count parameter
    public function didSoldierLeaveHouse():void
    {
        setSoldierCount(_soldierCount - 1);
    }

    //! Must call when MOUSE_UP event was fire.
    public function didMouseUp():void
    {
        if (_selectedHouses.length == 0)
            return;

        if (BaseView.viewHovered != null
                && BaseView.viewSelected != null
                && BaseView.viewHovered is HouseBaseView
                && BaseView.viewSelected is HouseBaseView)
        {
            var houseHovered:HouseBase = (BaseView.viewHovered as HouseBaseView).owner;

            //generate from all selected houses
            for each(var houseSelected:HouseBase in _selectedHouses)
            {
                if (houseHovered == houseSelected)
                    continue;

                GameInfo.Instance.soldierGenerator.generateSoldiers(houseSelected, houseHovered);
            }
        }

        clearHouseSelection();
    }

    /*
     * Methods
     */

    //! Default constructor for house
    //! If owner type == null -> type = neutral
    public function HouseBase(soldiersCount:int, ownerType:EHouseOwner = null)
    {
        ownerType = ownerType == null ? EHouseOwner.EHO_NEUTRAL : ownerType;

        _view = new HouseBaseView(this);

        _level = 1;

        _soldierCountMax = 25;

        _soldierCount = soldiersCount;

        setOwnerType(ownerType);
    }


    private function updateHouseExitPosition():void
    {
        var houseExitPositionOffset:Point = GameConfigurationHouseExitPosition.getHouseExitPosition(this);
        var squareFrame:Rectangle = GameConfigurationHouseFoundation.getHouseFoundation(this);

        _houseExitPosition = GameInfo.Instance.pathfinder.getNode(_currentPosition.column + squareFrame.x + houseExitPositionOffset.x,
                _currentPosition.row + squareFrame.y + houseExitPositionOffset.y);
    }

    //! Returns square of specify house
    private function updateFoundation():void
    {
        var squareFrame:Rectangle = GameConfigurationHouseFoundation.getHouseFoundation(this);

        var squareValue:Array = [];

        for (var currentRow:int = _currentPosition.row + squareFrame.y; currentRow < _currentPosition.row + squareFrame.height + squareFrame.y; currentRow++)
        {
            for (var currentColumn:int = _currentPosition.column + squareFrame.x; currentColumn < _currentPosition.column + squareFrame.width + squareFrame.x; currentColumn++)
            {
                var fundamentalNode:INode = GameInfo.Instance.pathfinder.getNode(currentColumn, currentRow);
                squareValue.push(fundamentalNode);
            }
        }

        setFoundation(squareValue);
    }

    /*
     * IDisposable
     */
    public function cleanup():void
    {
        super.cleanup();
    }
}
}
