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

import gameObjects.House.HouseView;

import scenes.AquaWars;

import scenes.views.arrow.arrow;

//! Base class of all clickable objects
public class BaseView extends MovieClip
{
    /*
     * Static fields
     */
    private static var _viewHovered:BaseView;

    private static var _viewSelected:BaseView;

    /*
     * Static methods
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
     * Fields
     */

    private var _eventHandler:DisplayObjectContainer;

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
        }

        _eventHandler = value;

        if (_eventHandler)
        {
            _eventHandler.addEventListener(MouseEvent.MOUSE_OVER, didMouseOver);
            _eventHandler.addEventListener(MouseEvent.MOUSE_OUT, didMouseOut);

            _eventHandler.addEventListener(MouseEvent.MOUSE_DOWN, didMouseDown);
            _eventHandler.addEventListener(MouseEvent.MOUSE_UP, didMouseUp);
        }
    }

    /*
     * Methods
     */

    //! Default constructor
    public function BaseView()
    {
        doubleClickEnabled = true;

        //TODO: review
//        mouseChildren = true;
    }

    public function cleanup():void
    {
        this.eventHandler = null;

    }

    public function update():void
    {

    }

    protected function didDoubleClick(e:Event):void
    {
    }

    protected function didMouseOver(e:Event):void
    {
        if (this is HouseView)
        {
            _viewHovered = this;
        }
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
        if (this is HouseView)
        {
            _viewSelected = this;
        }
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


}
}
