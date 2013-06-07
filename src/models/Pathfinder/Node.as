package models.Pathfinder
{

import gameObjects.BaseView;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;

import models.GameConstants.GameConstants;

import scenes.AquaWars;

public class Node extends BaseView implements INode
{
    /*
     * Static fields
     */


    /*
     * Static properties
     */

    public static function get NodeWidth():int
    {
        return 21;
    }

    public static function get NodeHeight():int
    {
        return 11;
    }

    public static function get NodeWidthHalf():int
    {
        return   NodeWidth / 2;
    }

    public static function get NodeHeightHalf():int
    {
        return NodeHeight / 2;
    }

    /*
     * Fields
     */

    //Our interface variables since we inherit from MovieClip x and y are already set
    private var _parentNode:INode;
    private var _f:Number;
    private var _g:Number;
    private var _h:Number;
    private var _traversable:Boolean = true;

    private var _row:int;
    private var _column:int;

    [Embed(source="../../../assets/Cell.swf", symbol="Cell")]
    private var _viewClass:Class;

    private var _view:Sprite;

    //! Default constructor
    public function Node(column:int, row:int)
    {
        _row = row;
        _column = column;

        _view = new _viewClass();

        addChild(_view);

        _view.visible = GameConstants.SHOW_GRID;
    }


    /*
     * IDisposable
     */

    public override function cleanup():void
    {
        //TODO: implement
//        removeChild(_view);
//        parent.removeChild(this);
    }

    /*
     * INode
     */

    public function get view():BaseView
    {
        return this;
    }

    public function get parentNode():INode
    {
        return _parentNode;
    }

    public function set parentNode(value:INode):void
    {
        _parentNode = value;
    }

    public function get f():Number
    {
        return _f;
    }

    public function set f(value:Number):void
    {
        _f = value;
    }

    public function get g():Number
    {
        return _g;
    }

    public function set g(value:Number):void
    {
        _g = value;
    }

    public function get h():Number
    {
        return _h;
    }

    public function set h(value:Number):void
    {
        _h = value;
    }

    public function get traversable():Boolean
    {
        return _traversable;
    }

    public function set traversable(value:Boolean):void
    {
        _traversable = value;
    }

    public function get row():int
    {
        return _row;
    }

    public function get column():int
    {
        return _column;
    }

    public function drawDebugData(color:uint):void
    {
        graphics.clear();
        graphics.lineStyle(2);
        graphics.beginFill(color);
        graphics.drawCircle(_view.width / 2, _view.height / 2, _view.height / 4);
        graphics.endFill();
    }

    public override function toString():String
    {
        return String(_row) + ":" + String(_column);
    }
}
}