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

import gameObjects.BaseView;
import gameObjects.IDisposable;

import flash.filters.GlowFilter;
import flash.utils.setTimeout;

import models.ResourceManager.ResourceManager;

import flash.display.Sprite;
import flash.events.Event;

import flash.text.TextField;

import models.SharedPathfinder.INode;

import models.SharedPathfinder.Node;

import scenes.AquaWars;

import scenes.views.arrow.arrow;

//! Represents view\controller of House
public class HouseView extends BaseView implements IDisposable
{
    /*
     * Fields
     */
    private var _textFieldSoldiersCount:TextField;

    private var _owner:House;
    private var _ownerType:EHouseType;
    private var _ownerLevel:uint;
    private var _ownerPosition:INode;
    private var _ownerSoldiersCount:uint;

    //! Represents house view
    private var _houseView:Sprite;

    private var _arrowView:Sprite;

    private var _auraView:Sprite;

    private var _indicatorLevel:MovieClip;
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

    private function didSoldiersCountChanged():void
    {
        _ownerSoldiersCount = _owner.soldierCount;

        _textFieldSoldiersCount.text = String(_ownerSoldiersCount);

        if (_indicatorLevelUp)
        {
            //show/hide level up indicator
            _indicatorLevelUp.visible = _owner.readyToUpdate;
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

    private function didOwnerLevelChanged():void
    {
        _ownerLevel = _owner.level;

        tryCreateHouseView();

        tryCreateIndicatorLevel();

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

            this.eventHandler = _houseView;

            addChild(_houseView);
        }
    }

    private function tryCreateIndicatorLevel():void
    {
        if(_indicatorLevel != null)
        {
            removeChild(_indicatorLevel);
        }

        var indicatorLevelClass:Class = ResourceManager.getIndicatorLevel(_ownerLevel);

        if(indicatorLevelClass)
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
            removeChild(_arrowView);
        }

        if (_ownerType == EHouseType.EHT_PLAYER)
        {
            var arrowClass:Class = ResourceManager.getSelectedArrow();
            _arrowView = new arrowClass();
            _arrowView.scaleX = 0;

            addChild(_arrowView);
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
        _textFieldSoldiersCount.text = String(_owner.soldierCount);
        _textFieldSoldiersCount.selectable = false;
        _textFieldSoldiersCount.width = 30;

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
    public function didAttack():void
    {
        var glowFilter:GlowFilter = new GlowFilter(0xff0000, 0.5, 12, 12);

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
    protected override function didMouseOver(e:Event):void
    {
        _auraView.visible = true;

        super.didMouseOver(e);
    }

    protected override function didMouseOut(e:Event):void
    {
        //! For selected house aura view should be visible
        if (viewSelected != this)
        {
            _auraView.visible = false;
        }

        super.didMouseOut(e);
    }

    //! Override from ButtonBase
    protected override function didMouseUp(e:Event):void
    {
        //if selected house does not exist
        if (BaseView.viewSelected == null || BaseView.viewSelected == this)
        {
            //Do nothing
            return;
        }

        _owner.didMouseUp();

        super.didMouseUp(e);
    }

    protected override function didMouseDown(e:Event):void
    {
        if (_ownerType == EHouseType.EHT_PLAYER)
        {
            showArrow();
        }

        super.didMouseDown(e);
    }

    protected override function didDoubleClick(e:Event):void
    {
        if (_owner.readyToUpdate)
        {
            _owner.didLevelUp();
        }
    }

    private function showArrow():void
    {
        _arrowView.visible = true;
        _arrowView.scaleX = 0;
        AquaWars.scene.stage.addEventListener(MouseEvent.MOUSE_MOVE, changeSize);
        AquaWars.scene.setChildIndex(this, AquaWars.scene.numChildren - 1);
        setChildIndex(_arrowView, 0);
        AquaWars.scene.stage.addEventListener(MouseEvent.MOUSE_UP, removeArrow);
    }

    private function changeSize(e:Event):void
    {

        var point:Point = new Point(AquaWars.scene.stage.mouseX, AquaWars.scene.stage.mouseY);
        _arrowView.scaleX = -Math.sqrt(Math.pow((point.x - x), 2) + Math.pow((point.y - y), 2)) / 174.8;
        var angle:Number = Math.atan2(y - point.y, x - point.x) / Math.PI * 180;
        _arrowView.rotation = angle;
    }

    private function removeArrow(e:Event):void
    {
        AquaWars.scene.stage.removeEventListener(MouseEvent.MOUSE_MOVE, changeSize);
        AquaWars.scene.stage.removeEventListener(MouseEvent.MOUSE_UP, removeArrow);
        _arrowView.visible = false;
    }


    protected override function didMouseUpOut():void
    {
        _auraView.visible = false;
    }
}
}
