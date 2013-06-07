/**
 * Created with IntelliJ IDEA.
 * User: gregorytkach
 * Date: 5/31/13
 * Time: 10:58 AM
 * To change this template use File | Settings | File Templates.
 */
package gameObjects.House
{
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.text.TextFormat;

import gameObjects.BaseView;

import gameObjects.BaseView;
import gameObjects.IDisposable;

import flash.filters.GlowFilter;
import flash.utils.setTimeout;

import models.GameConstants.GameConstants;

import models.ResourceManager.ResourceManager;

import flash.display.Sprite;
import flash.events.Event;

import flash.text.TextField;

import models.Pathfinder.INode;

import models.Pathfinder.Node;

import scenes.AquaWars;

import scenes.views.arrow.ArrowView;

//! Represents view\controller of House
public class HouseView extends BaseView implements IDisposable
{
    /*
     * Fields
     */
    private var _textFieldSoldiersCount:TextField;
    private var _textFormat:TextFormat;

    private var _owner:House;
    private var _ownerType:EHouseType;
    private var _ownerLevel:uint;
    private var _ownerPosition:INode;
    private var _ownerSoldiersCount:uint;

    //! Represents house view
    private var _houseView:Sprite;

    private var _arrowView:ArrowView;

    private var _auraView:Sprite;

    private var _indicatorLevel:Sprite;
    private var _indicatorLevelUp:MovieClip;


    /*
     * Properties
     */
    public function get Owner():House
    {
        return _owner;
    }


    /*
     * Methods
     */

    //! Default constructor
    public function HouseView(owner:House)
    {
        GameUtils.assert(owner != null);

        _owner = owner;
    }

    //TODO: move to update
    public function didHouseSelectionChanged(isSelect:Boolean):void
    {
        _auraView.visible = isSelect;
    }

    public override function update():void
    {
        if (_ownerType != _owner.type)
        {
            didOwnerTypeChanged();
        }

        if (_ownerLevel != _owner.level)
        {
            didOwnerLevelChanged();
        }

        if (_ownerPosition != _owner.currentPosition)
        {
            didPositionChanged();
        }

        if (_ownerSoldiersCount != _owner.soldierCount)
        {
            didSoldiersCountChanged();
        }
    }

    //! Must call when owner type was changed
    private function didOwnerTypeChanged():void
    {
        _ownerType = _owner.type;

        tryCreateAuraView();

        tryCreateHouseView();

        tryCreateArrowView();

        tryCreateLevelUpIndicator();

        tryCreateTextFieldSoldierCount();
    }

    private function didSoldiersCountChanged():void
    {
        _ownerSoldiersCount = _owner.soldierCount;

        _textFieldSoldiersCount.text = String(_ownerSoldiersCount);
        _textFieldSoldiersCount.setTextFormat(_textFormat);

        if (_indicatorLevelUp)
        {
            //show/hide level up indicator
            _indicatorLevelUp.visible = _owner.readyToUpdate;
        }
    }


    private function didOwnerLevelChanged():void
    {
        _ownerLevel = _owner.level;

        tryCreateHouseView();

        //tryCreateIndicatorLevel();

        if (_indicatorLevelUp)
        {
            //show/hide level up indicator
            _indicatorLevelUp.visible = _owner.readyToUpdate;
        }
    }

    private function tryCreateHouseView():void
    {
        //! Remove old house view if need
        if (_houseView != null)
        {
            removeChild(_houseView);
        }

        //Change house view
        {
            var houseClass:Class = ResourceManager.getHouseClassByTypeAndLevel(_ownerType, _ownerLevel);
            _houseView = new houseClass();

            this.eventHandler = this;

            addChild(_houseView);
        }
    }

    private function tryCreateIndicatorLevel():void
    {
        if (_indicatorLevel != null)
        {
            removeChild(_indicatorLevel);
        }

        var indicatorLevelClass:Class = ResourceManager.getIndicatorLevel(_ownerLevel);

        if (indicatorLevelClass)
        {
            _indicatorLevel = new indicatorLevelClass();
            _indicatorLevel.x = 10;
            _indicatorLevel.y = 10;

            addChild(_indicatorLevel);
        }
    }

    private function tryCreateArrowView():void
    {
        if (_arrowView != null)
        {
            removeChild(_arrowView.rootView);

            _arrowView = null;
        }

        if (_ownerType == EHouseType.EHT_PLAYER)
        {
            _arrowView = new ArrowView();

            addChild(_arrowView.rootView);
        }
    }

    private function tryCreateAuraView():void
    {
        //! Remove old aura view if need
        if (_auraView != null)
        {
            removeChild(_auraView);
        }

        //change aura view
        if (_ownerType != EHouseType.EHT_NEUTRAL)
        {
            var auraClass:Class = ResourceManager.getHouseAura(_ownerType);

            _auraView = new auraClass();
            _auraView.visible = false;

            addChild(_auraView);
        }
    }

    private function tryCreateLevelUpIndicator():void
    {
        if (_indicatorLevelUp != null)
        {
            removeChild(_indicatorLevelUp);
        }

        if (_ownerType == EHouseType.EHT_PLAYER)
        {
            var auraClass:Class = ResourceManager.getIndicatorLevelUpClass();

            _indicatorLevelUp = new auraClass();
            _indicatorLevelUp.x = 11;
            _indicatorLevelUp.y = -37;

            addChild(_indicatorLevelUp);

            _indicatorLevelUp.visible = _owner.readyToUpdate;
        }
    }

    private function tryCreateTextFieldSoldierCount():void
    {
        if (_textFieldSoldiersCount != null)
        {
            removeChild(_textFieldSoldiersCount);
        }

        _textFieldSoldiersCount = new TextField();

        _textFormat = new TextFormat();
        _textFormat.font = "Arial";
        _textFormat.size = 10;
        _textFormat.bold = true;


        _textFieldSoldiersCount.text = String(_owner.soldierCount);
        _textFieldSoldiersCount.setTextFormat(_textFormat);
        _textFieldSoldiersCount.selectable = false;
        _textFieldSoldiersCount.width = 30;
        _textFieldSoldiersCount.textColor = 0xFFFFFF;


        _textFieldSoldiersCount.x = 0;
        _textFieldSoldiersCount.y = -50;

        addChild(_textFieldSoldiersCount);
    }

    private function didPositionChanged():void
    {
        _ownerPosition = _owner.currentPosition;

        x = _ownerPosition.view.x + Math.round(width / 2) - Node.NodeWidthHalf;
        y = _ownerPosition.view.y;
    }

    //TODO: implement constaint for last time attack
    public function didAttackOrHeal(damage:int):void
    {
        var glowFilter:GlowFilter = new GlowFilter(damage < 0 ? 0xff0000 : 0x00ff00, 0.5, 12, 12);

        this.filters = [glowFilter];

        setTimeout(didAttackFinished, 200);
    }

    private function didAttackFinished():void
    {
        this.filters = [];
    }

    /*
     * BaseView
     */


    protected override function showDebugData(e:Event):void
    {
        if (GameConstants.SHOW_HOUSE_POSITION)
        {
            _owner.currentPosition.drawDebugData(0xB82631);
        }

        if (GameConstants.SHOW_HOUSE_EXIT)
        {
            _owner.houseExitPosition.drawDebugData(0xFFFF00);
        }

        if (GameConstants.SHOW_HOUSE_SQUARE)
        {
            for each(var node:INode in _owner.getSquare())
            {
                node.drawDebugData(0x222222);
            }
        }

        super.showDebugData(e);
    }

    /*
     * Event handlers
     */


    protected override function didMouseOver(e:Event):void
    {
        _auraView.visible = true;

        super.didMouseOver(e);
    }

    protected override function didMouseOut(e:Event):void
    {
        if (_owner.type == EHouseType.EHT_PLAYER && House.selectedHouses.length > 0)
        {
            House.selectHouse(_owner);

            _arrowView.show(true);
        }
        else
        {
            _auraView.visible = false;
        }

        super.didMouseOut(e);
    }


    protected override function didMouseDown(e:Event):void
    {
        if (_ownerType == EHouseType.EHT_PLAYER)
        {
            House.selectHouse(_owner);

            _arrowView.show(true);
        }

        super.didMouseDown(e);
    }


    //! Override from ButtonBase
    protected override function didMouseUp(e:Event):void
    {
        //if selected house does not exist
        if (BaseView.viewSelected != null && BaseView.viewSelected != this)
        {
            for each(var house:House in House.selectedHouses)
            {
                //hide arrows
                house.view._arrowView.show(false);
            }

            //generate soldiers, update view
            _owner.didMouseUp();
        }
        else
        {
            House.clearHouseSelection();

            _auraView.visible = true;

            if(_arrowView)
            {
                _arrowView.show(false);
            }
        }

        super.didMouseUp(e);
    }

    protected override function didMouseUpOut():void
    {
        //hide arrows
        for each(var house:House in House.selectedHouses)
        {
            house.view._arrowView.show(false);
        }

        House.clearHouseSelection();

        super.didMouseUpOut();
    }

    protected override function didMouseMove(e:Event):void
    {
        var mouseEvent:MouseEvent = e as MouseEvent;

        updateArrowSize(mouseEvent);

        super.didMouseMove(e);
    }

    protected override function didMouseMoveOut(e:Event):void
    {
        var mouseEvent:MouseEvent = e as MouseEvent;

        updateArrowSize(mouseEvent);

        super.didMouseMoveOut(e);
    }

    private static function updateArrowSize(e:MouseEvent):void
    {
        for each(var house:House in House.selectedHouses)
        {
            //update arrow size
            house.view._arrowView.didMouseMove(e);
        }
    }

    protected override function didDoubleClick(e:Event):void
    {
        if (_owner.readyToUpdate && _owner.type == EHouseType.EHT_PLAYER)
        {
            _owner.didLevelUp();
        }

        super.didDoubleClick(e);
    }
}
}
