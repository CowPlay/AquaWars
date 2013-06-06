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

    private static var _viewSelected:Array = new Array();

    /*
     * Static methods
     */

    //! Returns view which currently mouse hovered
    public static function get viewHovered():BaseView
    {
        return _viewHovered;
    }

    //! Returns view which currently mouse selected
    public static function get viewSelected():Array
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
            _eventHandler.addEventListener(MouseEvent.DOUBLE_CLICK, didDoubleClick);
        }
    }

    /*
     * Methods
     */

    //! Default constructor
    public function BaseView()
    {




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
        if ((this is HouseView)
                && (_viewSelected.length > 0))
        {
            _viewHovered = this;
        }

    }

    protected function didMouseOut(e:Event):void
    {
        if (_viewHovered == this)
        {
            _viewHovered = null;
            _viewSelected.push(this);
        }
    }

    protected function didMouseDown(e:Event):void
    {
        if (this is HouseView)
        {
            _viewSelected.push(this);
        }
    }

    protected function didMouseUp(e:Event):void
    {
        if (_viewSelected.length > 0)
        {
            for each(var baseView: BaseView in _viewSelected)
            {
               if (baseView != this)
               {
                   baseView.didMouseUpOut();
               }
            }
        }
        _viewSelected = [];
    }

    protected function didMouseUpOut():void
    {

    }


}
}
