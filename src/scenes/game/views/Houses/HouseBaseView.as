/**
 * Created with IntelliJ IDEA.
 * User: gregorytkach
 * Date: 5/31/13
 * Time: 10:58 AM
 * To change this template use File | Settings | File Templates.
 */
package scenes.game.views.Houses
{
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.GlowFilter;
import flash.geom.Point;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.utils.setTimeout;

import gameObjects.Houses.Base.*;
import gameObjects.IDisposable;

import models.Game.Singleplayer.GameSingleplayer;

import models.GameConstants.GameConstants;
import models.GameInfo.GameInfo;
import models.Pathfinder.INode;
import models.Pathfinder.Node;
import models.ResourceManager.ResourceManager;

import scenes.AquaWars;

import scenes.game.views.ArrowView;
import scenes.views.BaseView;

//! Represents view\controller of house base
public class HouseBaseView extends BaseView implements IDisposable
{
    /*
     * Fields
     */
    private var _textFieldSoldiersCount:TextField;
    private var _textFormat:TextFormat;

    private var _owner:HouseBase;
    //Cache of owner config
    private var _ownerType:EHouseOwner;
    private var _ownerLevel:uint;
    private var _ownerPosition:INode;
    private var _ownerSoldiersCount:int;

    //! Container which contains all house views except arrow
    private var _houseEventHandler:Sprite;

    //! Represents house view
    private var _houseView:Sprite;

    private var _auraView:Sprite;

    private var _indicatorLevelUp:MovieClip;

    private var _arrowView:ArrowView;


    /*
     * Properties
     */
    public function get owner():HouseBase
    {
        return _owner;
    }

    /*
     * Events
     */

    //TODO: move to update
    public function didHousePlayerSelectionChanged(isSelect:Boolean):void
    {
        Debug.assert(_owner.ownerType == EHouseOwner.EHO_PLAYER);

        _auraView.visible = isSelect;
        _arrowView.show(isSelect);
    }

    //! Must call when owner type was changed
    private function didOwnerTypeChanged():void
    {
        _ownerType = _owner.ownerType;

        tryCreateAuraView();

        tryCreateArrowView();

        tryCreateHouseView();

        tryCreateTextFieldSoldierCount();

        tryCreateLevelUpIndicator();
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

        tryCreateTextFieldSoldierCount();

        if (_indicatorLevelUp)
        {
            //show/hide level up indicator
            _indicatorLevelUp.visible = _owner.readyToUpdate;
        }
    }

    private function didPositionChanged():void
    {
        _ownerPosition = _owner.currentPosition;

        x = _ownerPosition.view.x + Math.round(width / 2) - Node.NodeWidthHalf;
        y = _ownerPosition.view.y;

        if (_arrowView != null)
        {
            _arrowView.rootView.x = x;
            _arrowView.rootView.y = y;
        }
    }

    //TODO: implement constaint for last time attack
    public function didAttackOrHeal(damage:Number):void
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
     * Methods
     */


    //! Default constructor
    public function HouseBaseView(owner:HouseBase)
    {
        Debug.assert(owner != null);

        _owner = owner;

        tryCreateArrowView();

        _houseEventHandler = new Sprite();

        addChild(_houseEventHandler);

        this.eventHandler = _houseEventHandler;
    }



    public override function update():void
    {
        if (_ownerType != _owner.ownerType)
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

    /*
     * Creators
     */

    private function tryCreateHouseView():void
    {
        //! Remove old house view if need
        if (_houseView != null)
        {
            _houseEventHandler.removeChild(_houseView);
            _houseView = null;
        }

        //Change house view
        {
            var houseClass:Class = ResourceManager.getHouseViewClass(_owner);
            _houseView = new houseClass();

            _houseEventHandler.addChild(_houseView);
        }
    }

    private function tryCreateArrowView():void
    {
        if (_arrowView != null)
        {
            GameSingleplayer(GameInfo.Instance.currentGame).scene.arrowContainer.removeChild(_arrowView.rootView);
            _arrowView = null;
        }

        if (_ownerType == EHouseOwner.EHO_PLAYER)
        {
            _arrowView = new ArrowView();

            _arrowView.rootView.x = x;
            _arrowView.rootView.y = y;

            GameSingleplayer(GameInfo.Instance.currentGame).scene.arrowContainer.addChild(_arrowView.rootView);


        }
    }

    private function tryCreateAuraView():void
    {
        //! Remove old aura view if need
        if (_auraView != null)
        {
            _houseEventHandler.removeChild(_auraView);
            _auraView = null;
        }

        //change aura view
        var auraClass:Class = ResourceManager.getHouseAura(_ownerType);

        _auraView = new auraClass();
        _auraView.visible = false;

        _houseEventHandler.addChild(_auraView);
    }

    private function tryCreateLevelUpIndicator():void
    {
        if (_indicatorLevelUp != null)
        {
            _houseEventHandler.removeChild(_indicatorLevelUp);
            _indicatorLevelUp = null;
        }

        if (_ownerType == EHouseOwner.EHO_PLAYER)
        {
            var indicatorClass:Class = ResourceManager.getIndicatorLevelUpClass();

            _indicatorLevelUp = new indicatorClass();
            _indicatorLevelUp.x = 11;
            _indicatorLevelUp.y = -37;

            _houseEventHandler.addChild(_indicatorLevelUp);

            _indicatorLevelUp.visible = _owner.readyToUpdate;
        }
    }

    private function tryCreateTextFieldSoldierCount():void
    {
        if (_textFieldSoldiersCount != null)
        {
            _houseEventHandler.removeChild(_textFieldSoldiersCount);
            _textFieldSoldiersCount = null;
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
        _textFieldSoldiersCount.y = -70;

        _houseEventHandler.addChild(_textFieldSoldiersCount);
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
            for each(var node:INode in _owner.foundation)
            {
                node.drawDebugData(0x222222);
            }
        }

        super.showDebugData(e);
    }


    public function magnetizeFromTargetHouse(targetHouse: HouseBase):void
    {
        _arrowView.magnetizeFromTargetHouse(targetHouse);
    }



    //!Pause
    public function stopAnimationHouseView():void
    {
        for( var i: int = 0; i < _houseView.numChildren; i++)
        {
            if (_houseView.getChildAt(i) is MovieClip)
            {
                MovieClip(_houseView.getChildAt(i)).stop();
            }
            if (_houseView.getChildAt(i) is DisplayObjectContainer)
            {
                for(var j: int = 0; j < DisplayObjectContainer(_houseView.getChildAt(i)).numChildren; j++)
                {
                    if (DisplayObjectContainer(_houseView.getChildAt(i)).getChildAt(j) is MovieClip)
                    {
                        MovieClip(DisplayObjectContainer(_houseView.getChildAt(i)).getChildAt(j)).stop();
                    }
                }
            }
        }
    }

    //!Play
    public function playAnimationHouseView():void
    {
        for( var i: int = 0; i < _houseView.numChildren; i++)
        {
            if (_houseView.getChildAt(i) is MovieClip)
            {
                MovieClip(_houseView.getChildAt(i)).play();
            }
            if (_houseView.getChildAt(i) is DisplayObjectContainer)
            {
                for(var j: int = 0; j < DisplayObjectContainer(_houseView.getChildAt(i)).numChildren; j++)
                {
                    if (DisplayObjectContainer(_houseView.getChildAt(i)).getChildAt(j) is MovieClip)
                    {
                        MovieClip(DisplayObjectContainer(_houseView.getChildAt(i)).getChildAt(j)).play();
                    }
                }
            }
        }
    }


    /*
     * Event handlers
     */


    protected override function didMouseOver(e:Event):void
    {
        _auraView.visible = true;

        //hide arrow
        if (_owner.ownerType == EHouseOwner.EHO_PLAYER)
        {
            _arrowView.show(false);
        }



        super.didMouseOver(e);
    }

    protected override function didMouseOut(e:Event):void
    {
        if (_owner.ownerType == EHouseOwner.EHO_PLAYER && HouseBase.selectedHouses.length > 0)
        {
            HouseBase.selectHousePlayer(_owner);
        }
        else
        {
            _auraView.visible = false;
        }

        super.didMouseOut(e);
    }


    protected override function didMouseDown(e:Event):void
    {
        if (_ownerType == EHouseOwner.EHO_PLAYER)
        {
            HouseBase.selectHousePlayer(_owner);
        }

        super.didMouseDown(e);
    }


    //! Override from ButtonBase
    protected override function didMouseUp(e:Event):void
    {
        //generate soldiers, update view
        _owner.didMouseUp();

        _auraView.visible = true;

        super.didMouseUp(e);
    }

    protected override function didMouseUpOut():void
    {
        HouseBase.clearHouseSelection();

        super.didMouseUpOut();
    }

    protected override function didMouseMove(e:Event):void
    {
        var mouseEvent:MouseEvent = e as MouseEvent;

        updateArrowSize(mouseEvent);

        super.didMouseMove(e);

        if (HouseBase.selectedHouses.length > 0)
        {
            for each(var houseBase: HouseBase in HouseBase.selectedHouses)
            {
                if (houseBase != _owner)
                {
                    houseBase.magnetizeFromTargetHouse(_owner);
                }

            }
        }
    }

    protected override function didMouseMoveOut(e:Event):void
    {
        var mouseEvent:MouseEvent = e as MouseEvent;

        updateArrowSize(mouseEvent);

        super.didMouseMoveOut(e);
    }

    private static function updateArrowSize(e:MouseEvent):void
    {
        for each(var house:HouseBase in HouseBase.selectedHouses)
        {
            if (house.view._arrowView != null)
            {
                house.view._arrowView.DidMouseMove(e);
            }
        }
    }

    protected override function didDoubleClick(e:Event):void
    {
        if (_owner.readyToUpdate && _owner.ownerType == EHouseOwner.EHO_PLAYER)
        {
            _owner.didLevelUp();
        }

        super.didDoubleClick(e);
    }
}
}
