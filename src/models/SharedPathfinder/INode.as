package models.SharedPathfinder
{
import gameObjects.BaseView;
import gameObjects.IDisposable;

//! Interface which provide node for AStar algorithm
public interface INode extends IDisposable
{
    function get view():BaseView;

    function get f():Number;

    function get g():Number;

    function get h():Number;

    function get row():int;

    function get column():int;

    function get parentNode():INode;

    function get traversable():Boolean;

    function set f(value:Number):void;

    function set g(value:Number):void;

    function set h(value:Number):void;

    function set parentNode(value:INode):void;

    function set traversable(value:Boolean):void;

    function toString():String;
}

}