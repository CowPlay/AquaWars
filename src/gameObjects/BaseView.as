/**
 * Created with IntelliJ IDEA.
 * User: developer
 * Date: 5/30/13
 * Time: 6:00 PM
 * To change this template use File | Settings | File Templates.
 */
package gameObjects
{
import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.utils.Timer;

import gameObjects.House.HouseView;

import models.GameConstants.GameConstants;

import scenes.AquaWars;

import scenes.views.arrow.ArrowView;

//! Base class of all clickable objects
public class BaseView extends MovieClip
{
    /*
     * Static fields
     */
    private static var _viewHovered:BaseView;

    private static var _viewSelected:BaseView;

    /*
     * Static properties
     */

    //! Returns view which currently mouse hovered
    public static function get viewHovered():BaseView
    {
        return _viewHovered;
    }

    //! Returns view which currently mouse selected
    public static function get viewSelected():BaseView
    {
        return _viewSelected;
    }

    /*
     * Static methods
     */

    public static function didMouseLeave():void
    {
        _viewHovered = null;

        if (_viewSelected != null)
        {
            _viewSelected.didMouseUpOut();
        }
    }

    /*
     * Fields
     */

    private var _eventHandler:DisplayObjectContainer;

    private var _timerDebugDataRenderer:Timer;

    /*
     * Properties
     */


    protected function set eventHandler(value:DisplayObjectContainer):void
    {
        if (_eventHandler == value)
        {
            return;
        }

        if (_eventHandler)
        {
            _eventHandler.removeEventListener(MouseEvent.MOUSE_OVER, didMouseOver);
            _eventHandler.removeEventListener(MouseEvent.MOUSE_OUT, didMouseOut);

            _eventHandler.removeEventListener(MouseEvent.MOUSE_DOWN, didMouseDown);
            _eventHandler.removeEventListener(MouseEvent.MOUSE_UP, didMouseUp);
            _eventHandler.addEventListener(MouseEvent.MOUSE_MOVE, didMouseMove);
            _eventHandler.removeEventListener(MouseEvent.DOUBLE_CLICK, didDoubleClick);
        }

        _eventHandler = value;

        if (_eventHandler)
        {
            _eventHandler.doubleClickEnabled = true;
            _eventHandler.mouseChildren = false;

            _eventHandler.addEventListener(MouseEvent.MOUSE_OVER, didMouseOver);
            _eventHandler.addEventListener(MouseEvent.MOUSE_OUT, didMouseOut);

            _eventHandler.addEventListener(MouseEvent.MOUSE_DOWN, didMouseDown);
            _eventHandler.addEventListener(MouseEvent.MOUSE_UP, didMouseUp);
            _eventHandler.addEventListener(MouseEvent.MOUSE_MOVE, didMouseMove);
            _eventHandler.addEventListener(MouseEvent.DOUBLE_CLICK, didDoubleClick);
        }
    }

    /*
     * Methods
     */

    //! Default constructor
    public function BaseView()
    {
        if (GameConstants.SHOW_DEBUG_DATA)
        {
            _timerDebugDataRenderer = new Timer(1000);
            _timerDebugDataRenderer.addEventListener(TimerEvent.TIMER, showDebugData);
            _timerDebugDataRenderer.start();
        }
    }

    public function cleanup():void
    {
        this.eventHandler = null;

        _timerDebugDataRenderer.stop();
        _timerDebugDataRenderer = null;
    }

    public function update():void
    {
    }

    protected function showDebugData(e:Event):void
    {

    }


    /*
     * Event handlers
     */

    protected function didMouseOver(e:Event):void
    {
        _viewHovered = this;
    }

    protected function didMouseOut(e:Event):void
    {
        if (_viewHovered == this)
        {
            _viewHovered = null;
        }
    }

    protected function didMouseDown(e:Event):void
    {
        _viewSelected = this;
    }

    protected function didMouseUp(e:Event):void
    {
        if (_viewSelected != null && _viewSelected != this)
        {
            _viewSelected.didMouseUpOut();
        }

        _viewSelected = null;
    }

    protected function didMouseUpOut():void
    {

    }

    protected function didMouseMove(e:Event):void
    {
        if (_viewSelected != null && _viewSelected != this)
        {
            _viewSelected.didMouseMoveOut(e);
        }
    }


    protected function didMouseMoveOut(e:Event):void
    {

    }

    protected function didDoubleClick(e:Event):void
    {
    }


}
}
